note
	description: "[
		Objects that represent an EV_DIALOG.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_DIALOG generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_PIXMAP_SETTINGS_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			create_interface_objects, initialize, is_in_default_state
		end
			
	GB_INTERFACE_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants

			
				-- Build widget structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (select_pixmap_button)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (select_directory_button)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (pixmap_list)
			l_ev_vertical_box_3.extend (check_buttons_cell)
			l_ev_vertical_box_3.extend (check_buttons_box)
			check_buttons_box.extend (l_ev_cell_1)
			check_buttons_box.extend (check_all_button)
			check_buttons_box.extend (uncheck_all_button)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (pixmap_location_label)
			l_ev_horizontal_box_6.extend (pixmap_path_label)
			l_ev_vertical_box_1.extend (built_from_frame)
			built_from_frame.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (absolute_constant_radio_button)
			l_ev_horizontal_box_7.extend (absolute_constant_box1)
			absolute_constant_box1.extend (absolute_text)
			l_ev_vertical_box_4.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (relative_constant_radio_button)
			l_ev_horizontal_box_8.extend (relative_constant_box)
			relative_constant_box.extend (l_ev_horizontal_box_9)
			l_ev_horizontal_box_9.extend (l_ev_label_1)
			l_ev_horizontal_box_9.extend (relative_text)
			relative_constant_box.extend (l_ev_horizontal_box_10)
			l_ev_horizontal_box_10.extend (l_ev_label_2)
			l_ev_horizontal_box_10.extend (relative_directory_combo)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (ok_button)
			l_ev_vertical_box_6.extend (cancel_button)
			l_ev_vertical_box_6.extend (l_ev_cell_2)

			l_ev_horizontal_box_1.set_padding (10)
			l_ev_horizontal_box_1.set_border_width (10)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_box_6)
			l_ev_vertical_box_1.set_padding (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_1.disable_item_expand (built_from_frame)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_vertical_box_2)
			l_ev_vertical_box_2.set_padding (10)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_4)
			select_pixmap_button.set_text ("Select Individual ...")
			select_directory_button.set_text ("Select Directory...")
			l_ev_frame_1.set_minimum_width (150)
			l_ev_frame_1.set_minimum_height (150)
			integer_constant_set_procedures.extend (agent l_ev_vertical_box_3.set_border_width (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_vertical_box_3.disable_item_expand (check_buttons_cell)
			l_ev_vertical_box_3.disable_item_expand (check_buttons_box)
			integer_constant_set_procedures.extend (agent check_buttons_cell.set_minimum_height (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			integer_constant_set_procedures.extend (agent check_buttons_box.set_padding (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			check_buttons_box.disable_item_expand (check_all_button)
			check_buttons_box.disable_item_expand (uncheck_all_button)
			check_all_button.set_text ("Check all")
			check_all_button.set_tooltip ("Check all items, for inclusion as new pixmap constants")
			uncheck_all_button.set_text ("Uncheck all")
			uncheck_all_button.set_tooltip ("Uncheck all items")
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_6.set_padding (?))
			integer_constant_retrieval_functions.extend (agent large_padding)
			l_ev_horizontal_box_6.disable_item_expand (pixmap_location_label)
			pixmap_location_label.disable_sensitive
			pixmap_location_label.set_text ("Pixmap location:")
			pixmap_location_label.align_text_left
			pixmap_path_label.align_text_left
			built_from_frame.disable_sensitive
			built_from_frame.set_text ("Built from")
			l_ev_vertical_box_4.set_padding (5)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_vertical_box_5)
			l_ev_vertical_box_5.disable_item_expand (absolute_constant_radio_button)
			l_ev_vertical_box_5.merge_radio_button_groups (l_ev_horizontal_box_8)
			absolute_constant_radio_button.set_text ("Absolute PIXMAP constant named")
			absolute_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_ev_horizontal_box_8.disable_item_expand (relative_constant_radio_button)
			l_ev_horizontal_box_8.merge_radio_button_groups (l_ev_vertical_box_5)
			relative_constant_box.set_padding (5)
			l_ev_horizontal_box_9.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Relative PIXMAP constant named:")
			relative_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_ev_horizontal_box_10.set_padding (5)
			l_ev_horizontal_box_10.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Comprised of DIRECTORY: ")
			relative_directory_combo.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			l_ev_vertical_box_6.set_padding (10)
			l_ev_vertical_box_6.disable_item_expand (ok_button)
			l_ev_vertical_box_6.disable_item_expand (cancel_button)
			ok_button.disable_sensitive
			string_constant_set_procedures.extend (agent ok_button.set_text (?))
			string_constant_retrieval_functions.extend (agent ok_button_text)
			integer_constant_set_procedures.extend (agent ok_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			string_constant_set_procedures.extend (agent cancel_button.set_text (?))
			string_constant_retrieval_functions.extend (agent cancel_button_text)
			integer_constant_set_procedures.extend (agent cancel_button.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent default_button_width)
			string_constant_set_procedures.extend (agent set_title (?))
			string_constant_retrieval_functions.extend (agent pixmap_settings_dialog_title)

			set_all_attributes_using_constants
			
				-- Connect events.
			select_pixmap_button.select_actions.extend (agent select_pixmap_pressed)
			select_directory_button.select_actions.extend (agent select_directory_pressed)
			pixmap_list.check_actions.extend (agent item_checked (?))
			pixmap_list.uncheck_actions.extend (agent item_unchecked (?))
			check_all_button.select_actions.extend (agent check_all_button_selected)
			uncheck_all_button.select_actions.extend (agent uncheck_all_button_selected)
			absolute_constant_radio_button.select_actions.extend (agent absolute_radio_button_selected)
			absolute_text.change_actions.extend (agent absolute_text_changed)
			relative_constant_radio_button.select_actions.extend (agent relative_radio_button_selected)
			relative_text.change_actions.extend (agent relative_text_changed)
			relative_directory_combo.change_actions.extend (agent relative_directory_text_changed)
			ok_button.select_actions.extend (agent ok_button_pressed)
			cancel_button.select_actions.extend (agent cancel_button_pressed)

				-- Call `user_initialization'.
			user_initialization
		end
		
	frozen create_interface_objects
			-- Create objects
		do
			
				-- Create all widgets.
			create l_ev_horizontal_box_1
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_2
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_3
			create select_pixmap_button
			create l_ev_horizontal_box_4
			create select_directory_button
			create l_ev_horizontal_box_5
			create l_ev_frame_1
			create l_ev_vertical_box_3
			create pixmap_list
			create check_buttons_cell
			create check_buttons_box
			create l_ev_cell_1
			create check_all_button
			create uncheck_all_button
			create l_ev_horizontal_box_6
			create pixmap_location_label
			create pixmap_path_label
			create built_from_frame
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_7
			create l_ev_vertical_box_5
			create absolute_constant_radio_button
			create absolute_constant_box1
			create absolute_text
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_8
			create relative_constant_radio_button
			create relative_constant_box
			create l_ev_horizontal_box_9
			create l_ev_label_1
			create relative_text
			create l_ev_horizontal_box_10
			create l_ev_label_2
			create relative_directory_combo
			create l_ev_vertical_box_6
			create ok_button
			create cancel_button
			create l_ev_cell_2

			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
			user_create_interface_objects
		end


feature -- Access

	select_pixmap_button, select_directory_button, check_all_button, uncheck_all_button,
	ok_button, cancel_button: EV_BUTTON
	pixmap_list: EV_CHECKABLE_LIST
	check_buttons_cell: EV_CELL
	check_buttons_box, absolute_constant_box1: EV_HORIZONTAL_BOX
	pixmap_location_label,
	pixmap_path_label: EV_LABEL
	built_from_frame: EV_FRAME
	absolute_constant_radio_button, relative_constant_radio_button: EV_RADIO_BUTTON
	absolute_text,
	relative_text: EV_TEXT_FIELD
	relative_constant_box: EV_VERTICAL_BOX
	relative_directory_combo: EV_COMBO_BOX

feature {NONE} -- Implementation

	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4,
	l_ev_horizontal_box_5, l_ev_horizontal_box_6, l_ev_horizontal_box_7, l_ev_horizontal_box_8,
	l_ev_horizontal_box_9, l_ev_horizontal_box_10: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1, l_ev_vertical_box_2,
	l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5, l_ev_vertical_box_6: EV_VERTICAL_BOX
	l_ev_frame_1: EV_FRAME
	l_ev_cell_1,
	l_ev_cell_2: EV_CELL
	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_label_1, l_ev_label_2: EV_LABEL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	user_create_interface_objects
			-- Feature for custom user interface object creation, called at end of `create_interface_objects'.
		deferred
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	select_pixmap_pressed
			-- Called by `select_actions' of `select_pixmap_button'.
		deferred
		end
	
	select_directory_pressed
			-- Called by `select_actions' of `select_directory_button'.
		deferred
		end
	
	item_checked (a_list_item: EV_LIST_ITEM)
			-- Called by `check_actions' of `pixmap_list'.
		deferred
		end
	
	item_unchecked (a_list_item: EV_LIST_ITEM)
			-- Called by `uncheck_actions' of `pixmap_list'.
		deferred
		end
	
	check_all_button_selected
			-- Called by `select_actions' of `check_all_button'.
		deferred
		end
	
	uncheck_all_button_selected
			-- Called by `select_actions' of `uncheck_all_button'.
		deferred
		end
	
	absolute_radio_button_selected
			-- Called by `select_actions' of `absolute_constant_radio_button'.
		deferred
		end
	
	absolute_text_changed
			-- Called by `change_actions' of `absolute_text'.
		deferred
		end
	
	relative_radio_button_selected
			-- Called by `select_actions' of `relative_constant_radio_button'.
		deferred
		end
	
	relative_text_changed
			-- Called by `change_actions' of `relative_text'.
		deferred
		end
	
	relative_directory_text_changed
			-- Called by `change_actions' of `relative_directory_combo'.
		deferred
		end
	
	ok_button_pressed
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	
	cancel_button_pressed
			-- Called by `select_actions' of `cancel_button'.
		deferred
		end
	

feature {NONE} -- Constant setting

	frozen set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_32
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				if s /= Void then
					string_constant_set_procedures.item.call ([s])
				end
				string_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_integer_constants
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				if p /= Void then
					pixmap_constant_set_procedures.item.call ([p])
				end
				pixmap_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				if f /= Void then
					font_constant_set_procedures.item.call ([f])
				end
				font_constant_set_procedures.forth
			end	
		end

	frozen set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				if c /= Void then
					color_constant_set_procedures.item.call ([c])
				end
				color_constant_set_procedures.forth
			end
		end

	frozen set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
	
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [READABLE_STRING_GENERAL]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [STRING_32]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_PIXMAP]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER_INTERVAL]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_FONT]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_COLOR]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_COLOR]]

	frozen integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
