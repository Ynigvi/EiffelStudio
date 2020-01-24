note
	description	: "Dialog to class in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CHOOSE_BOOKMARK_DIALOG

inherit
	ES_DIALOG

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_LOCALE
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_with_source

feature -- Access

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.class_normal_icon_buffer
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.cancel_button
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := Interface_names.t_Choose_bookmark
		end

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

feature {NONE} -- Initialization

	make_with_source (a_source: STRING)
		require
			source_not_null: a_source /= Void
		do
			source := a_source
			make
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_shared: EB_SHARED_WINDOW_MANAGER
			l_win: like development_window
		do
			create l_shared
			l_win := l_shared.window_manager.last_focused_development_window
			check not_void: l_win /= Void end

			prepare (l_win.menus.context_menu_factory, a_container)

			on_bookmark_name_entry_changed
		ensure then
		end

	prepare (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_container: EV_VERTICAL_BOX)
			-- Create the controls and setup the layout
		local
			controls_box: EV_VERTICAL_BOX
			l_layouts: EV_LAYOUT_CONSTANTS
			l_bookmark: EV_TREE_ITEM
			l_file: PLAIN_TEXT_FILE
			l_content: STRING
			l_regex: RX_PCRE_MATCHER
		do
			create l_layouts

			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)
			set_button_action ({ES_DIALOG_BUTTONS}.cancel_button, agent on_cancel)

				-- Create the controls.
			create bookmark_name_entry
			bookmark_name_entry.change_actions.extend (agent on_bookmark_name_entry_changed)
			create bookmarks_tree.default_create
			bookmarks_tree.set_minimum_width (l_layouts.dialog_unit_to_pixels(300))
			bookmarks_tree.set_minimum_height (l_layouts.dialog_unit_to_pixels(300))
			bookmarks_tree.select_actions.extend (agent on_bookmark_selected)

			create l_file.make_open_read (source)
			create l_regex.make
			create l_content.make_empty

			from
				l_file.read_character
			until
				l_file.exhausted
			loop
				l_content.append_character (l_file.last_character)
				l_file.read_character
			end

			l_regex.set_greedy (false)
			l_regex.compile ("<w:bookmarkStart w:id=%".*%" w:name=%"(.+)%"/>")

			from
				l_regex.match (l_content)
			until
				not l_regex.has_matched
			loop
				bookmarks_tree.extend (create {EV_TREE_ITEM}.make_with_text (l_regex.captured_substring (1)))
				l_content := l_content.substring (l_regex.captured_end_position (0), l_content.count)
				l_regex.match (l_content)
			end

--			bookmarks_tree.associate_textable_recursively  (bookmark_name_entry, bookmarks_tree)

			show_actions.extend (agent bookmark_name_entry.set_focus)

				-- Create the left panel: a Combo Box to type the name of the class
				-- and a tree to select the class.
			create controls_box
			controls_box.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			controls_box.set_border_width ({ES_UI_CONSTANTS}.dialog_border)
--			controls_box.extend (bookmark_name_entry)
--			controls_box.disable_item_expand (bookmark_name_entry)

			controls_box.extend (bookmarks_tree)

				-- Pack the buttons_box and the controls.
			a_container.extend (controls_box)
		end

feature -- Access

	selected: BOOLEAN
			-- Has the user selected a class (True) or pushed
			-- the cancel button (False)?

	bookmark: STRING
			-- class selected by the user, if any.
		require
			selected: selected
		do
			Result := selected_bookmark
		end

	source: STRING

feature {NONE} -- Implementation

	selected_bookmark: STRING
			-- the selected bookmark, if any.

feature {NONE} -- Vision2 events

	on_ok
			-- Terminate the dialog.
		do
			selected := not selected_bookmark.is_empty
		end

	on_cancel
			-- Terminate the dialog and clear the selection.
		do
			selected := False
			dialog.destroy
		end

	on_class_double_click (	x_rel: INTEGER;
							y_rel: INTEGER;
							button: INTEGER;
							x_tilt: DOUBLE;
							y_tilt: DOUBLE;
							pression: DOUBLE;
							x_abs: INTEGER;
							y_abs: INTEGER )
			-- Call on_ok through an agent compatible with double click actions.
		do
			on_ok
		end

	on_bookmark_name_entry_changed
			-- Handler for class name entry just changed
		local
			l_button: EV_BUTTON
			l_class_i: CLASS_I
			l_text: STRING_32
			l_caret_pos: INTEGER
		do
			l_button := dialog_window_buttons.item (default_button)
			check not_void: l_button /= Void end
			l_class_i ?= bookmark_name_entry.data
			l_text := bookmark_name_entry.text.as_upper

			if l_class_i /= Void then
				l_button.enable_sensitive
			else
				if not l_text.is_empty and then eiffel_universe.classes_with_name (l_text.as_string_8).count = 1 then
					l_button.enable_sensitive
				else
					l_button.disable_sensitive
				end
			end

			bookmark_name_entry.change_actions.block
			l_caret_pos := bookmark_name_entry.caret_position

			bookmark_name_entry.set_text (l_text)
			bookmark_name_entry.set_caret_position (l_caret_pos)
			bookmark_name_entry.change_actions.resume
		end

	on_bookmark_selected
		local
			l_button: EV_BUTTON
			l_text: STRING_32
			l_caret_pos: INTEGER
		do
			l_button := dialog_window_buttons.item (default_button)
			check not_void: l_button /= Void end
			selected_bookmark := bookmarks_tree.selected_item.text

			l_button.enable_sensitive
		end

feature {NONE} -- Controls

	bookmark_name_entry: EV_COMBO_BOX
			-- Combo box where the user can type its class name.

	bookmarks_tree: EV_TREE;
			-- Tree where the user can choose its bookmark.

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

end -- class EB_CHOOSE_CLASS_DIALOG

