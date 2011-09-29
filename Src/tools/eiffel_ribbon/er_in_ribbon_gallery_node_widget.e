note
	description: "EiffelVision Widget ER_RIBBON_IN_RIBBON_GALLERY_NODE_WIDGET.%
		%The original version of this class was generated by EiffelBuild."
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_IN_RIBBON_GALLERY_NODE_WIDGET

inherit
	ER_IN_RIBBON_GALLERY_NODE_WIDGET_IMP


feature {NONE} -- Initialization

	user_create_interface_objects
			-- Create any auxilliary objects needed for ER_RIBBON_IN_RIBBON_GALLERY_NODE_WIDGET.
			-- Initialization for these objects must be performed in `user_initialization'.
		do
				-- Create attached types defined in class here, initialize them in `user_initialization'.
				create checker
		end

	user_initialization
			-- Perform any initialization on objects created by `user_create_interface_objects'
			-- and from within current class itself.
		do
				-- Initialize types defined in current class
		end

feature -- Command

	set_tree_node_data (a_data: detachable ER_TREE_NODE_IN_RIBBON_GALLERY_DATA)
			-- Update GUI with tree node data
		do
			tree_node_data := a_data
			if attached a_data as l_data then
				if attached a_data.command_name as l_command_name then
					command_name.set_text (l_command_name)
				else
					command_name.remove_text
				end

--				if attached a_data.label_title as l_label_title then
--					label.set_text (l_label_title)
--				else
--					label.remove_text
--				end

				max_rows.set_text (l_data.max_rows.out)
				max_columns.set_text (l_data.max_columns.out)
			end
		end

feature {NONE} -- Implementation

	checker: ER_IDENTIFIER_UNIQUENESS_CHECKER
			-- Identifier uniqueness checker

	tree_node_data: detachable ER_TREE_NODE_IN_RIBBON_GALLERY_DATA
			-- In-ribbon gallery tree node data

	on_command_name_change
			-- Called by `change_actions' of `command_name'.
		do
			checker.on_identifier_name_change (command_name, tree_node_data)
		end

	on_command_name_focus_out
			-- <Precursor>
		do
			checker.on_focus_out (command_name, tree_node_data)
		end

	on_label_text_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_label_title (label.text)
			end
		end

	on_max_rows_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				if max_rows.text.is_integer then
					l_data.set_max_rows (max_rows.text.to_integer)
				end
			end
		end

	on_max_columns_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				if max_columns.text.is_integer then
					l_data.set_max_columns (max_columns.text.to_integer)
				end
			end
		end
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
