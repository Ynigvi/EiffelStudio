note
	description: "Summary description for {EB_DOCUMENTATION_FORMATTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOCUMENTATION_FORMATTER

inherit
	EB_SHORT_FORMATTER
	redefine
		menu_name,
		mode,
		capital_command_name,
		generate_text
	end

create
	make
feature

	menu_name: STRING_GENERAL
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showdoc
		end

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.doc
		end

	capital_command_name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.l_Doc
		end

feature {NONE}

	generate_text
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_with_breakable
				if not is_dotnet_mode then
					editor.handle_before_processing (false)
					if associated_class /= Void then
						last_was_error := short_context_text (associated_class, editor.text_displayed)
					end
					editor.handle_after_processing
				else
					editor.handle_before_processing (false)
					set_is_without_breakable
					if class_i /= Void then
						last_was_error := short_dotnet_text (internal_consumed_type, class_i, editor.text_displayed)
					elseif associated_class /= Void then
						last_was_error := short_dotnet_text (internal_consumed_type, associated_class.lace_class, editor.text_displayed)
					end
					editor.handle_after_processing
				end
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.enable_has_breakable_slots
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
