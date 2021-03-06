﻿note
	description: "An Eiffel validity error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class EW_EIFFEL_VALIDITY_ERROR

inherit
	EW_EIFFEL_ERROR
		redefine
			is_equal,
			is_less,
			matches_pattern
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like class_name; a_code: like validity_code)
			-- Create current validity error with `a_name' and `a_code'.
		require
			a_name_not_void: a_name /= Void
			a_code_not_void: a_code /= Void
		do
			class_name := a_name
			validity_code := a_code
		ensure
			class_name_set: class_name = a_name
			validity_code_set: validity_code = a_code
		end

feature -- Properties

	validity_code: READABLE_STRING_32
			-- Validity code which was violated.

feature -- Modification

	set_validity_code (a_code: like validity_code)
		require
			a_code_not_void: a_code /= Void
		do
			validity_code := a_code
		ensure
			validity_code_set: validity_code = a_code
		end

feature -- Summary

	summary: STRING_32
		do
			Result := {STRING_32} "Validity error"
			if not class_name.is_empty  then
				Result.append ({STRING_32} " in class ")
				Result.append (class_name)
			end;
			Result.append ({STRING_32} " code ")
			if attached validity_code as v then
				Result.append (v)
			end
			if has_line_number then
				Result.append ({STRING_32} " at line ")
				Result.append_integer (line_number)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (other) and validity_code.same_string (other.validity_code)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result :=
				class_name < other.class_name or else
				(class_name.same_string (other.class_name) and validity_code < other.validity_code) or else
				(class_name.same_string (other.class_name) and validity_code.same_string (other.validity_code) and line_number < other.line_number)
		end

	matches_pattern (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result :=
				Precursor (other) and
				validity_code.same_string (other.validity_code)
		end

invariant
	validity_code_not_void: validity_code /= Void

note
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
