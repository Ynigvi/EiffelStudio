note
	description: "Warning when a class name of an export clause is not found in the surrounding universe."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCM

inherit
	EIFFEL_WARNING
		redefine
			build_explain,
			print_single_line_error_message,
			trace
		end

create
	make

feature {NONE} -- Creation

	make (name: STRING; location: LOCATION_AS; context: CLASS_C)
			-- Create an error object for missing class `name' at `location' in class `context'.
		require
			name_attached: attached name
			location_attached: attached location
			context_attached: attached context
		do
			set_class (context)
			set_location (location)
			set_class_name (name)
		end

feature -- Properties

	class_name: STRING
			-- Class name not found

	code: STRING = "VTCM"
			-- Error code

feature -- Status report

	less_than (other: VTCM): BOOLEAN
			-- Is `Current' less than `other'?
		require
			other_not_void: other /= Void
		do
			Result := associated_class.name < other.associated_class.name
		end

feature -- Output

	trace (f: TEXT_FORMATTER)
			-- <Precursor>
		do
			Precursor (f)
			if line > 0 then
				print_context_of_error (associated_class, f)
			end
		end

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Unknown class name: ")
			if line > 0 then
				a_text_formatter.add_class_syntax (Current, associated_class, class_name)
			else
				a_text_formatter.add (class_name)
				a_text_formatter.add (" in ")
				a_text_formatter.add (associated_class.group.target.name)
			end
			a_text_formatter.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			if class_name /= Void then
				a_text_formatter.add_space
				a_text_formatter.add ("Unknown class ")
				if line > 0 then
					a_text_formatter.add_class_syntax (Current, associated_class, class_name)
				else
					a_text_formatter.add (class_name)
				end
				a_text_formatter.add (".")
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_class_name (s: STRING)
			-- Assign `s' to `class_name'.
		require
			s_not_void: s /= Void
		do
			class_name := s.as_upper
		ensure
			class_name_set: class_name /= Void
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class VTCM
