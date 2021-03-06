note
	description: "Error for a feature call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VUAR

inherit
	FEATURE_ERROR
		redefine
			is_defined
		end

feature -- Properties

	called_feature: detachable E_FEATURE

	code: STRING = "VUAR"

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				called_feature /= Void
		end

feature -- Output

	print_called_feature (a_text_formatter: TEXT_FORMATTER)
		local
			a_class: CLASS_C
		do
			if attached called_feature as f then
				a_class := called_feature.written_class
				a_text_formatter.add ("Called feature: ")
				called_feature.append_signature (a_text_formatter)
				a_text_formatter.add (" from ")
				a_class.append_name (a_text_formatter)
				a_text_formatter.add_new_line
			end
		end

feature -- Setting

	set_called_feature (f: FEATURE_I; class_id: INTEGER)
		require
			valid_f: f /= Void
			valid_class_id: class_id > 0
		do
			called_feature := f.enclosing_feature.api_feature (class_id)
		ensure
			called_feature_not_void: called_feature /= Void
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class VUAR
