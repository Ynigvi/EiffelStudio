note
	description: "Summary description for {ES_EIS_SHARED_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_SHARED_TYPE

feature

	parse_type (a_type_string: STRING_32): INTEGER
			-- Parse `a_type_string' and return the corresponding integer.
			-- If not a valid type, default type is returned.
		require
			a_type_string_not_void: a_type_string /= Void
		do
			if a_type_string.is_case_insensitive_equal ({ES_EIS_TOKENS}.traceability_var_name) then
				Result := {EIS_ENTRY}.traceability_type
			elseif a_type_string.is_case_insensitive_equal ({ES_EIS_TOKENS}.refinement_var_name) then
				Result := {EIS_ENTRY}.refinement_type
			elseif a_type_string.is_case_insensitive_equal ({ES_EIS_TOKENS}.containment_var_name) then
				Result := {EIS_ENTRY}.containment_type
			elseif a_type_string.is_case_insensitive_equal ({ES_EIS_TOKENS}.verify_var_name) then
				Result := {EIS_ENTRY}.verify_type
			elseif a_type_string.is_case_insensitive_equal ({ES_EIS_TOKENS}.satisfy_var_name) then
				Result := {EIS_ENTRY}.satisfy_type
			else
				Result := {EIS_ENTRY}.default_type
			end
		ensure
			Result_not_void: Result /= Void
		end

		type_string_from_eis_entry (entry: EIS_ENTRY): STRING_32
				-- Return the string representation of the entry's type
			require
				entry_not_void: entry /= Void
				type_valid: entry.valid_type (entry.type)
			do
				inspect entry.type
				when {EIS_ENTRY}.traceability_type then
					Result := {ES_EIS_TOKENS}.traceability_var_name
				when {EIS_ENTRY}.refinement_type then
					Result := {ES_EIS_TOKENS}.refinement_var_name
				when {EIS_ENTRY}.containment_type then
					Result := {ES_EIS_TOKENS}.containment_var_name
				when {EIS_ENTRY}.verify_type then
					Result := {ES_EIS_TOKENS}.verify_var_name
				when {EIS_ENTRY}.satisfy_type then
					Result := {ES_EIS_TOKENS}.satisfy_var_name
				else
					Result := {ES_EIS_TOKENS}.traceability_var_name
				end
			ensure
				result_not_void: Result /= Void
			end
note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
