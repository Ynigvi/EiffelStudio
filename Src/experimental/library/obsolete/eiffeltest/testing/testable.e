note
	description:
		"Components that are able to execute tests"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TESTABLE inherit

	RUNNABLE
		rename
			is_enabled as is_test_enabled
		end

	LOGGABLE

	RUN_RESULT_FACTORY
	
	STANDARD_OUTPUT_FACILITY

	RANDOMIZABLE

feature -- Access

	id: STRING
			-- Test ID
		do
			if not is_top_level then
				Result := container.id
			end
			if Result = Void then 
				create Result.make (0)
			else
				Result.extend ('.') 
			end
			Result.append (number.out)
		ensure
			non_empty_result: Result /= Void and then not Result.is_empty
		end
	 
	name: STRING
			-- Name of test
		deferred
		end
	 
	number: INTEGER 
			-- Test number
			
	test_results: TEST_RESULT
			-- Results of test
		deferred
		end
	 
	container: TEST_SUITE
			-- Handle to container that contains the test
	
	result_record (n: INTEGER): TEST_RUN_RESULT
			-- Result record for run `n'
		do
			if has_passed (n) then
				run_result_factory.select_product ("T")
			else
				if not is_exception (n) then
					run_result_factory.select_product ("F")
				else
					run_result_factory.select_product ("E")
				end
			end
			Result := run_result_factory.product
		ensure
			non_void_result: Result /= Void
		end

feature -- Measurement

	run_count: INTEGER
			-- Number of runs
	deferred
	end
 
	total_run_count: INTEGER
			-- Total number of runs
			-- (Differs from `run_count' in case of containers.)
	deferred
	end
 
feature -- Status report

	is_name_set: BOOLEAN
			-- Is name set?
		do
			Result := name /= Void and then not name.is_empty
		end

	has_fixture: BOOLEAN
			-- Does parent container have a fixture set up?
		do
			Result := is_container_set and then container.fixture /= Void
		end
		
	has_results: BOOLEAN
			-- Are test results available?
		do
			Result := test_results /= Void and then test_results.has_results
		end
		
	is_number_set: BOOLEAN
			-- Is test number set?
		do
			Result := number > 0
		end

	is_container_set: BOOLEAN
			-- Is container set?
		do
			Result := container /= Void and then not container.is_empty and then
				container.has (Current)
		end

	is_top_level: BOOLEAN
			-- Is test on top level of test hierarchy?
		do
			Result := (container = Void)
		end
		
	top_level_allowed: BOOLEAN
			-- Can test be inserted in the top level of test hierarchy?
		deferred
		end
	 
	produces_result: BOOLEAN
			-- Does test produce result?
		deferred
		end
	 
	is_complete_test: BOOLEAN
	 		-- Is test a complete test case?
			-- (If no, it is a test step.)
		deferred
		end
	
	is_test_container: BOOLEAN
			-- is test a container?
		deferred
		end
	 
	all_tests_passed: BOOLEAN
			-- Did all tests pass?
		require
			results_available: has_results
		do
			Result := test_results.all_tests_passed
		end

	has_any_execution_time: BOOLEAN
			-- Does any test have a recorded execution time?
		require
			results_available: has_results
		deferred
		end

	is_exception (n: INTEGER): BOOLEAN
			-- Did run `n' of test throw an exception?
		require
			valid_run_number: valid_run_index (n)
		deferred
		end
	 
	is_test_enabled: BOOLEAN
			-- Is test enabled?
	 	do
			Result := not test_disabled_flag
		end
		
	valid_run_index (n: INTEGER): BOOLEAN
	 		-- Is run index `n' valid?
		do
			Result := 1 <= n and n <= total_run_count
		ensure then
			valid_index: 1 <= n and n <= total_run_count
		end

feature -- Status setting

	set_number (n: INTEGER)
			-- Set test number to `n'.
		require
			non_negative_number: n >= 0
		do
			number := n
		ensure
			number_set: number = n
		end

	set_container (c: like container)
			-- Set container to `c'.
		do
			container := c
		ensure
			container_set: container = c
			current_test_in_container: c /= Void implies c.has (Current)
		end

	enable_test
			-- Enable execution.
		do
			test_disabled_flag := False
		ensure
			enabled: is_test_enabled
		end
	 
	disable_test
			-- Disable execution.
		do
			test_disabled_flag := True
		ensure
			disabled: not is_test_enabled
		end
		
	clear_results
			-- Clear results.
		require
			results_available: test_results /= Void
		deferred
		ensure
			results_cleared: not has_results
		end 

feature -- Basic operations

	execute
			-- Execute test.
		deferred
		ensure then
			result_counted_if_available: produces_result implies
					run_count = old run_count + 1
		end

	set_up
			-- Set up test.
		do
		end

	tear_down
			-- Clean up test.
		do
		end
		
feature {NONE} -- Implementation

	test_disabled_flag: BOOLEAN
			-- Is test disabled?
	
invariant

	produces_result_definition: produces_result = (test_results /= Void)
	top_level_definition: is_top_level = (container = Void)
	number_set_definition: is_number_set = (number > 0)
	test_number_non_negative: number >= 0
	non_empty_name: name /= Void and then not name.is_empty
	ready_test_constraint: is_ready implies (is_number_set and is_name_set)
	parent_container_or_top_level:
			is_ready implies (is_top_level xor is_container_set)
	container_set_properly: container /= Void implies is_container_set
	container_is_complete_test: is_test_container implies is_complete_test
	complete_test_produces_result: is_complete_test implies produces_result

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TESTABLE

