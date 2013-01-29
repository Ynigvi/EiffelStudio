note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GOTO_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		local
			l_ev_vertical_box_1, l_vb_top: EV_VERTICAL_BOX
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
			l_ev_cell_1: EV_CELL
			l_sep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor {EV_DIALOG}

				-- Create all widgets.
			create l_vb_top
			create l_ev_vertical_box_1
			create line_number_label
			create line_number_text
			create l_ev_horizontal_box_1
			create l_ev_cell_1
			create go_button
			create cancel_button
			create l_sep

				-- Build_widget_structure.
			extend (l_vb_top)
			l_vb_top.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (line_number_label)
			l_ev_vertical_box_1.extend (line_number_text)
			l_vb_top.extend (create {EV_CELL})
			l_vb_top.extend (l_sep)
			l_vb_top.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (go_button)
			l_ev_horizontal_box_1.extend (cancel_button)

			set_minimum_width (250)
			set_title ("Go To Line")
			l_ev_vertical_box_1.set_padding_width (10)
			l_ev_vertical_box_1.set_border_width (10)
			l_ev_vertical_box_1.disable_item_expand (line_number_label)
			l_ev_vertical_box_1.disable_item_expand (line_number_text)
			l_vb_top.disable_item_expand (l_sep)
			l_vb_top.disable_item_expand (l_ev_horizontal_box_1)
			line_number_label.set_text ("Line number")
			line_number_label.align_text_left
			l_ev_horizontal_box_1.set_padding_width (10)
			l_ev_horizontal_box_1.set_border_width (10)
			l_ev_horizontal_box_1.disable_item_expand (go_button)
			l_ev_horizontal_box_1.disable_item_expand (cancel_button)
			go_button.set_text ("Go To")
			cancel_button.set_text ("Cancel")

				--Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	line_number_label: EV_LABEL
	line_number_text: EV_SPIN_BUTTON
	go_button, cancel_button: EV_BUTTON

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
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

end -- class GOTO_DIALOG_IMP
