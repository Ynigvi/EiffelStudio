note
	description: "Object that generates style for class item in editor token form"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_EDITOR_TOKEN_STYLE

inherit
	EB_EDITOR_TOKEN_STYLE

create
	make_with_class_i,
	make_with_class_c,
	make_with_ql_class,
	default_create

feature{NONE} -- Initialization

	make_with_class_i (a_class_i: like class_i)
			-- Initialize `class_i' with `a_class_i'.
		require
			a_class_i_attached: a_class_i /= Void
		do
			set_class_i (a_class_i)
		end

	make_with_class_c (a_class_c: like class_c)
			-- Initialize `class_c' with `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		do
			set_class_c (a_class_c)
		end

	make_with_ql_class (a_ql_class: QL_CLASS)
			-- Initialize `class_i' and `class_c' using data from `a_ql_class'.
		require
			a_ql_class_attached: a_ql_class /= Void
		do
			set_ql_class (a_ql_class)
		end

feature -- Access

	class_i: CLASS_I
		-- CLASS_I associated with `Current'

	class_c: CLASS_C
		-- CLASS_C associated with `Current'

	text: LIST [EDITOR_TOKEN]
			-- Editor token text generated by `Current' style
		local
			l_writer: like token_writer
			l_curly_enabled: BOOLEAN
		do
			l_writer := token_writer
			l_writer.new_line
			l_curly_enabled := is_curly_enabled
			if custom_name /= Void then
				if l_curly_enabled then
					l_writer.process_symbol_text (ti_l_curly)
				end
				l_writer.process_class_name_text (custom_name, class_i, False)
				if l_curly_enabled then
					l_writer.process_symbol_text (ti_r_curly)
				end
			elseif not is_class_c_set then
					-- Only class name is available if only `class_i' is set.
				if l_curly_enabled then
					l_writer.process_symbol_text (ti_l_curly)
				end
				class_i.append_name (l_writer)
				if l_curly_enabled then
					l_writer.process_symbol_text (ti_r_curly)
				end
			else
				if is_just_name_enabled then
					if l_curly_enabled then
						l_writer.process_symbol_text (ti_l_curly)
					end
					class_c.append_name (l_writer)
					if l_curly_enabled then
						l_writer.process_symbol_text (ti_r_curly)
					end
				else
					if l_curly_enabled then
						l_writer.process_symbol_text (ti_l_curly)
					end
					if is_short_generic_form_enabled then
						class_c.append_short_signature (l_writer, is_star_enabled)
					else
						class_c.append_signature (l_writer, is_star_enabled)
					end
					if l_curly_enabled then
						l_writer.process_symbol_text (ti_r_curly)
					end
					if is_processed_enabled then
						l_writer.add_string ("...")
					end
				end
			end
			Result := l_writer.last_line.content
		end

	custom_name: detachable STRING_32

feature -- Status report

	is_short_generic_form_enabled: BOOLEAN
			-- Is short generic form enabled?
			-- Short generic form is replacing generic constraints to save space.
			-- For example, short generic form for class HASH_TABLE [G, H -> HASHABLE] is HASH_TABLE [G, H-> ...]
			-- Have no effect if `class_c' is not set.

	is_complete_generic_form_enabled: BOOLEAN
			-- Is complete generic form enabled?
			-- Complete generic form is what appears in class name in class declaration.
			-- Have no effect if `class_c' is not set.
		do
			Result := not is_short_generic_form_enabled
		ensure
			good_result: Result = not is_short_generic_form_enabled
		end

	is_processed_enabled: BOOLEAN
			-- Is associated class marked as processed?
			-- If True, "..." will be displayed after class signature.
			-- For example, "STRING ..."
			-- Have no effect if `class_c' is not set.

	is_just_name_enabled: BOOLEAN
			-- Should only class name be displayed?
			-- If True, `is_short_generic_form_enabled', `is_complete_generic_form_enabled',
			-- `is_start_enabled' and `is_processed_enabled' will have no effect.

	is_star_enabled: BOOLEAN
			-- Should "*" indicating a deferred be included in `text'?
			-- Have no effect if `class_c' is not set.

	is_curly_enabled: BOOLEAN
			-- Should curly brace be displayed surrounding class name?
			-- If True, the output will be like {STRING_8} instead of just STRING_8.

	is_class_c_set: BOOLEAN
			-- Is `class_c' set?
		do
			Result := class_c /= Void
		end

	is_class_i_set: BOOLEAN
			-- Is `class_i' set?
		do
			Result := class_i /= Void
		end

	is_text_ready: BOOLEAN
			-- Is `text' ready to be returned?
		do
			Result := is_class_c_set or else is_class_i_set
		end

feature -- Setting

	set_class_i (a_class_i: like class_i)
			-- Set `class_i' with `a_class_i'.
		require
			a_class_i_attached: a_class_i /= Void
		do
			class_i := a_class_i
			if a_class_i.is_compiled then
				class_c := a_class_i.compiled_class
			else
				class_c := Void
			end
		ensure
			class_i_set: class_i = a_class_i
			class_c_set: (a_class_i.is_compiled implies class_c = a_class_i.compiled_class) and
						 (not a_class_i.is_compiled implies class_c = Void)
		end

	set_class_c (a_class_c: like class_c)
			-- Set `class_c' with `a_class_c'.
		do
			class_c := a_class_c
			class_i := a_class_c.original_class
		ensure
			class_c_set: class_c = a_class_c
			class_i_set: class_i = a_class_c.original_class
		end

	set_ql_class (a_ql_class: QL_CLASS)
			-- Set `class_i' and `class_c' using data from `a_ql_class'.
		require
			a_ql_class_attached: a_ql_class /= Void
		do
			if a_ql_class.is_compiled then
				set_class_c (a_ql_class.class_c)
			else
				set_class_i (a_ql_class.class_i)
			end
		end

	enable_short_generic_form
			-- Enable short generic form.
			-- See `is_short_generic_form_enabled' for more information.
		do
			is_short_generic_form_enabled := True
		ensure
			short_generic_form_enabled: is_short_generic_form_enabled
		end

	enable_complete_generic_form
			-- Enable complete generic form.
			-- See `is_complete_generic_form_enabled' for more information.
		do
			is_short_generic_form_enabled := False
		ensure
			complete_generic_form_enabled: is_complete_generic_form_enabled
		end

	enable_star
			-- Enable a star "*" after class name.
			-- See `is_star_enabled' for more information.
		do
			is_star_enabled := True
		ensure
			star_enabled: is_star_enabled
		end

	disable_star
			-- Disable a star "*" after class name.
			-- See `is_star_enabled' for more information.
		do
			is_star_enabled := False
		ensure
			star_disabled: not is_star_enabled
		end

	enable_processed
			-- Enable processed mark.
			-- See `is_processed_enabled' for more information.
		do
			is_processed_enabled := True
		ensure
			processed_enabled: is_processed_enabled
		end

	disable_processed
			-- Disable processed mark.
			-- See `is_processed_enabled' for more information.
		do
			is_processed_enabled := False
		ensure
			processed_disabled: not is_processed_enabled
		end

	enable_just_name
			-- Enable that just_name is to be displayed.
			-- See `is_just_name_enabled' for more information.
		do
			is_just_name_enabled := True
		ensure
			just_name_enabled: is_just_name_enabled
		end

	disable_just_name
			-- Enable that not just_name is to be displayed.
			-- See `is_just_name_enabled' for more information.
		do
			is_just_name_enabled := False
		ensure
			just_name_disabled: not is_just_name_enabled
		end

	enable_curly
			-- Enable curly display surrounding class name.
			-- See `is_curly_enabled' for more information.
		do
			is_curly_enabled := True
		ensure
			curly_enabled: is_curly_enabled
		end

	disable_curly
			-- Disable curly display surrounding class name.
			-- See `is_curly_enabled' for more information.
		do
			is_curly_enabled := False
		ensure
			curly_disabled: not is_curly_enabled
		end

	enable_custom_name (a_name: STRING_32)
			-- Use `a_name' as the name displayed.
		require
			a_name_not_void: a_name /= Void
		do
			custom_name := a_name
		ensure
			custom_name_set: custom_name = a_name
		end

	disable_custom_name
			-- Use `a_name' as the name displayed.
		do
			custom_name := Void
		ensure
			custom_name_cleared: custom_name = Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
