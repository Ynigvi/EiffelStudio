﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_TEST_DESCRIPTION_INST

inherit
	EW_TEST_INSTRUCTION

feature

	inst_initialize (desc: READABLE_STRING_32)
			-- Initialize instruction from `args'.
		do
			if desc.is_empty then
				init_ok := False
				failure_explanation := {STRING_32} "no test description supplied"
			else
				test_description := desc
				init_ok := True
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
		do
			test.set_test_description (test_description)
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' always succeed.

feature {NONE}

	test_description: READABLE_STRING_32
			-- Description of test

;note
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
