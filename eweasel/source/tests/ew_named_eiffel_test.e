﻿note
	description: "A named Eiffel test"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_NAMED_EIFFEL_TEST

inherit
	EW_PREDEFINED_VARIABLES
	EW_INSTRUCTION_TABLES
	EW_STRING_UTILITIES

create

	make

feature {NONE} -- Creation

	make (name, last, full_src_dir, tcf_name: READABLE_STRING_32; keys: LIST [READABLE_STRING_32])
			-- Create `Current' with test name `name',
			-- last source directory component `last', full
			-- source directory name `full_src_dir'  and test
			-- control file name `tcf_name'.
		require
			name_not_void: name /= Void
			last_src_dir_comp_not_void: last /= Void
			full_src_dir_not_void: full_src_dir /= Void
			tcf_not_void: tcf_name /= Void
		do
			test_name := name
			last_source_directory_component := last
			full_source_directory := full_src_dir
			test_control_file_name := tcf_name
			keywords := keys
		end

feature -- Execution

	execute (env: EW_TEST_ENVIRONMENT)
			-- Execute `Current' in the environment `env'.
		local
			tcf: EW_TEST_CONTROL_FILE
		do
			env.define (Source_dir_name, full_source_directory)
			create tcf.make (test_control_file_name, Void, test_command_table, True)
			tcf.parse_and_execute (env)
			last_test := tcf.last_test
			last_ok := tcf.last_ok
			errors := tcf.errors
		end

feature -- Status

	last_test: EW_EIFFEL_EWEASEL_TEST
			-- Last test parsed and/or executed

	last_ok: BOOLEAN
			-- Was test executed without any errors?

	errors: EW_ERROR_LIST
			-- Errors encountered, in order
			-- (void if `last_ok' is true)

feature -- Properties	

	test_name: READABLE_STRING_32
			-- Name user has associated with this test.
			-- Not necessarily the same as the test name
			-- chosen by the person who wrote the test.

	full_source_directory: READABLE_STRING_32
			-- Full path name of the source directory,
			-- where all files needed to conduct the test
			-- reside.

	last_source_directory_component: READABLE_STRING_32
			-- Last component of the source directory path
			-- name.

	test_control_file_name: READABLE_STRING_32
			-- Full name of test control file which describes
			-- how to perform this test.

	keywords: LIST [READABLE_STRING_32]
			-- Keywords associated with this test.

	has_keyword (word: READABLE_STRING_32): BOOLEAN
			-- Is `word' one of the keywords associated with
			-- `Current' ?
		require
			word_not_void: word /= Void
		do
			keywords.compare_objects
			keywords.start
			keywords.search (word)
			Result := not keywords.exhausted
		end

	has_one_keyword (words: LIST [READABLE_STRING_32]): BOOLEAN
			-- Is at least one keyword in `words' associated with
			-- `Current' ?
		require
			words_not_void: words /= Void
		do
			from
				words.start
			until
				words.after or Result
			loop
				if has_keyword (words.item) then
					Result := True
				end
			end
		end

	has_all_keywords (words: LIST [READABLE_STRING_32]): BOOLEAN
			-- Is every keyword in `words' associated with
			-- `Current' ?
		require
			words_not_void: words /= Void
		do
			from
				Result := True
				words.start
			until
				words.after or not Result
			loop
				if not has_keyword (words.item) then
					Result := False
				end
			end
		end

	manual_execution_required: BOOLEAN
			-- Does test need to be executed manually for some
			-- reason?
		do
			Result := has_keyword (Manual_keyword)
		end

	skip_requested: BOOLEAN
			-- Has creator of test requested that it be skipped?
		do
			Result := has_keyword (Skip_keyword)
		end

	execution_allowed: BOOLEAN
			-- May test be executed?
		do
			Result := not manual_execution_required and not skip_requested
		end

feature {NONE} -- Implementation

	Manual_keyword: STRING_32 = "manual"
			-- Keyword which indicates that a test needs
			-- to be executed manually rather than automatically

	Skip_keyword: STRING_32 = "skip"
			-- Keyword which indicates that a test needs
			-- to be skipped, for some reason

;note
	ca_ignore: "CA011", "CA011 — too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
