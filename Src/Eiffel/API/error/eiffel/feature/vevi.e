note
	description: "Variable Initialization error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VEVI

inherit
	FEATURE_ERROR
		redefine
			build_explain,
			print_single_line_error_message
		end

	SHARED_WORKBENCH

create
	make_attribute,
	make_attributes,
	make_local,
	make_result

feature {NONE} -- Creation

	make_attribute (a: FEATURE_I; class_id: INTEGER; p: FEATURE_I; l: LOCATION_AS; f: FEATURE_I)
			-- Create error that attribute `a' from a class identified by `class_id'
			-- is not initialized at location `l' of feature `f' by the creation procedure `p'.
		require
			a_attached: attached a
			valid_class_id: class_id > 0
			p_attached: attached p
			l_attached: attached l
			f_attached: attached f
		do
			set_class (system.class_of_id (class_id))
			set_written_class (f.written_class)
			set_feature (f)
			create attributes.make_filled (a.enclosing_feature.api_feature (class_id), 1)
			if p /= f then
				creation_procedure := p.enclosing_feature.api_feature (class_id)
			end
			set_location (l)
		ensure
			attributes_attached: attached attributes
		end

	make_attributes (a: LIST [FEATURE_I]; class_id: INTEGER; p: FEATURE_I; l: LOCATION_AS; f: FEATURE_I)
			-- Create error that attributes `a' from a class identified by `class_id'
			-- are not initialized at location `l' of feature `f' by the creation procedure `p'.
		require
			a_attached: attached a
			valid_class_id: class_id > 0
			p_attached: attached p
			l_attached: attached l
			f_attached: attached f
		do
			set_class (system.class_of_id (class_id))
			set_written_class (f.written_class)
			set_feature (f)
			create attributes.make_empty (a.count)
			across
				a as i
			loop
				attributes.extend (i.item.enclosing_feature.api_feature (class_id))
			end
			if p /= f then
				creation_procedure := p.enclosing_feature.api_feature (class_id)
			end
			set_location (l)
		ensure
			attributes_attached: attached attributes
		end

	make_local (n: STRING; c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error object for a local `n'.
		require
			n_attached: attached n
			n_not_empty: not n.is_empty
			c_attached: attached c
			l_attached: attached l
		do
			local_name := n
			c.init_error (Current)
			set_location (l)
		ensure
			local_name_set: local_name = n
		end

	make_result (c: AST_CONTEXT; l: LOCATION_AS)
			-- Create error object for Result.
		require
			c_attached: attached c
			l_attached: attached l
		do
			c.init_error (Current)
			set_location (l)
		end

feature -- Error properties

	code: STRING = "VEVI"
			-- Error code

feature {NONE} -- Variable name

	attribute_variable: E_FEATURE
			-- Attribute

	attributes: SPECIAL [E_FEATURE]
			-- Attributes.

	local_name: STRING
			-- Local variable.

feature {NONE} -- Context

	creation_procedure: detachable E_FEATURE
			-- Creation procedure that causes the error (if different from `current_feature')

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			Precursor (a_text_formatter)
			if attached creation_procedure then
				a_text_formatter.add ("Creation procedure: ")
				creation_procedure.append_signature (a_text_formatter)
				a_text_formatter.add (" declared in ")
				creation_procedure.written_class.append_name (a_text_formatter)
				a_text_formatter.add_new_line
			end
			append_variable_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			a_text_formatter.add (" ")
			append_variable_name (a_text_formatter)
		end

	append_variable_name (a_text_formatter: TEXT_FORMATTER)
			-- Append associated variable name to `a_text_formatter'.
		local
			separator: CHARACTER_32
			f: E_FEATURE
		do
			if attached attributes as a then
				a_text_formatter.add ("Attribute(s)")
					-- Preceed first element with a colon.
				separator := ':'
				across
					a as i
				loop
					a_text_formatter.add_char (separator)
					a_text_formatter.add_space
					f := i.item
					if f.written_in /= class_c.class_id then
						a_text_formatter.process_symbol_text ("{")
						f.written_class.append_name (a_text_formatter)
						a_text_formatter.process_symbol_text ("}")
						a_text_formatter.process_symbol_text (".")
					end
					f.append_name (a_text_formatter)
						-- Switch to a comma.
					separator := ','
				end
			elseif attached local_name as l then
				a_text_formatter.add ("Local: ")
				a_text_formatter.add_local (l)
			else
				a_text_formatter.add ("Variable: ")
				a_text_formatter.process_keyword_text ("Result", Void)
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
