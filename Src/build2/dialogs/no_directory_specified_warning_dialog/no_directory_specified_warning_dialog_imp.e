indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NO_DIRECTORY_SPECIFIED_WARNING_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
			create l_vertical_box_21
			create l_horizontal_box_22
			create l_vertical_box_22
			create l_cell_9
			create pixmap_cell
			create l_cell_10
			create l_label_9
			create l_horizontal_box_23
			create l_label_10
			create directory_name_field
			create l_cell_11
			create l_horizontal_box_24
			create l_cell_12
			create ok_button
			create cancel_button
			
			extend (l_vertical_box_21)
			l_vertical_box_21.extend (l_horizontal_box_22)
			l_horizontal_box_22.extend (l_vertical_box_22)
			l_vertical_box_22.extend (l_cell_9)
			l_vertical_box_22.extend (pixmap_cell)
			l_vertical_box_22.extend (l_cell_10)
			l_horizontal_box_22.extend (l_label_9)
			l_vertical_box_21.extend (l_horizontal_box_23)
			l_horizontal_box_23.extend (l_label_10)
			l_horizontal_box_23.extend (directory_name_field)
			l_vertical_box_21.extend (l_cell_11)
			l_vertical_box_21.extend (l_horizontal_box_24)
			l_horizontal_box_24.extend (l_cell_12)
			l_horizontal_box_24.extend (ok_button)
			l_horizontal_box_24.extend (cancel_button)
			
			set_title (no_directory_dialog)
			l_vertical_box_21.set_padding_width (10)
			l_vertical_box_21.disable_item_expand (l_horizontal_box_22)
			l_vertical_box_21.disable_item_expand (l_horizontal_box_23)
			l_vertical_box_21.disable_item_expand (l_horizontal_box_24)
			l_horizontal_box_22.set_padding_width (10)
			l_horizontal_box_22.set_border_width (10)
			l_horizontal_box_22.disable_item_expand (l_vertical_box_22)
			l_label_9.set_text ("You have not specified a DIRECTORY constant for one or more relative PIXMAP%Nconstants, and no matching directory constant is available. %NPlease enter the name of a DIRECTORYconstant which will be used.")
			l_label_9.align_text_left
			l_horizontal_box_23.set_padding_width (10)
			l_horizontal_box_23.set_border_width (10)
			l_horizontal_box_23.disable_item_expand (l_label_10)
			l_label_10.set_text ("Use DIRECTORY constant named:")
			l_horizontal_box_24.set_padding_width (10)
			l_horizontal_box_24.set_border_width (10)
			l_horizontal_box_24.disable_item_expand (ok_button)
			l_horizontal_box_24.disable_item_expand (cancel_button)
			ok_button.set_text (ok_button_text)
			ok_button.set_minimum_width (default_button_width)
			cancel_button.set_text (cancel_button_text)
			cancel_button.set_minimum_width (default_button_width)
			
			directory_name_field.change_actions.extend (agent text_changed)
			ok_button.select_actions.extend (agent ok_button_pressed)
			cancel_button.select_actions.extend (agent cancel_button_pressed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end
feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	l_vertical_box_21, l_vertical_box_22: EV_VERTICAL_BOX
	l_horizontal_box_22, l_horizontal_box_23, l_horizontal_box_24: EV_HORIZONTAL_BOX
	l_cell_9, pixmap_cell, l_cell_10, l_cell_11, l_cell_12: EV_CELL
	l_label_9, l_label_10: EV_LABEL
	directory_name_field: EV_TEXT_FIELD
	ok_button, cancel_button: EV_BUTTON
	
	text_changed is
			-- Called by `change_actions' of `directory_name_field'.
		deferred
		end
	
	ok_button_pressed is
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	
	cancel_button_pressed is
			-- Called by `select_actions' of `cancel_button'.
		deferred
		end
	

end -- class NO_DIRECTORY_SPECIFIED_WARNING_DIALOG_IMP
