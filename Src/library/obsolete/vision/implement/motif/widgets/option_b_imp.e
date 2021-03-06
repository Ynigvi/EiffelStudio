note

	description: 
		"EiffelVision implementation of a Motif option button. %
		%It is rectangle which displays an option menu when armed."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	OPTION_B_IMP

inherit

	OPTION_B_I;

	BUTTON_I;

	MANAGER_IMP
		rename
			set_size as button_set_size,
			set_height as button_set_height,
			set_width as button_set_width,
			is_shown as shown
		undefine
			create_callback_struct			
		end;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct			
		redefine
			set_size, set_height, set_width
		select
			set_size, set_height, set_width
		end;

	FONTABLE_IMP;

	MEL_OPTION_MENU
		rename
			make as mel_opt_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		redefine
			set_size, set_height, set_width
		end

create

	make

feature {NONE} -- Initialization

	make (an_option_menu: OPTION_B; man: BOOLEAN; oui_parent: COMPOSITE)
			-- Create a motif option menu button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_opt_make (an_option_menu.identifier, mc, man);
			an_option_menu.set_font_imp (Current);
		end;

feature -- Status report

	font_list: MEL_FONT_LIST
			-- Font list of button gadget
		do
			Result := button_gadget.font_list
		end;

	selected_button: BUTTON
			-- Current Push Button selected in the option menu
		local
			w: WIDGET_IMP
		do
			w ?= menu_history;
			if w /= Void then
				Result ?= w.widget_oui
			end;
		end;

	text: STRING
			-- Label of button
		do
			Result := button_gadget.label_as_string
		end;

	title: STRING
			-- Title of option button
		do
			Result := label_gadget.label_as_string
		end;

	title_width: INTEGER
			-- Width of title
		do
			Result := label_gadget.width
		end;

feature -- Status setting

	set_font_list (a_font_list: MEL_FONT_LIST)
			-- Set button_gadget font_list to `_font_list'.
		do
			button_gadget.set_font_list (a_font_list)
		end;

	set_text (a_text: STRING)
			-- Set button text to `a_text'.
		do
			button_gadget.unmanage;
			button_gadget.set_label_as_string (a_text)
			button_gadget.manage
		end;

	set_left_alignment, set_center_alignment
			-- Do nothing.
		do
		end;

	set_selected_button (button: BUTTON)
			-- Set `selected_button' to `button'
		local
			mel_w: MEL_RECT_OBJ
		do
			mel_w ?= button.implementation;
			set_menu_history (mel_w)
		end;

	set_title (a_title: STRING)
			-- Set option button title to `a_title'.
		do
			label_gadget.unmanage;
			label_gadget.set_label_as_string (a_title);
			label_gadget.manage
		end;

	attach_menu (a_menu: OPT_PULL)
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		local
			mel_menu: MEL_ROW_COLUMN
		do
			mel_menu ?= a_menu.implementation;
			button_gadget.set_sub_menu (mel_menu)
		end;

	set_height (new_height: INTEGER)
			-- Set height to `new_height'.
		do
			button_gadget.set_height (new_height)
		end;

	set_size (new_width: INTEGER; new_height: INTEGER)
			-- Set both width and height to `new_width'
			-- and `new_height'.
		local
			nw, nh: INTEGER;
		do
			nw := new_width;
			nh := new_height;
			if not title.is_empty then
				button_gadget.set_size (nw - title_width, new_height)
			else
				button_gadget.set_size (nw, new_height)
			end;
			button_set_size (nw, nh);
		end;

	set_width (new_width :INTEGER)
			-- Set width to `new_width'.
		do
			button_gadget.set_width (new_width);
			button_set_width (new_width);
		end;

	allow_recompute_size
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
			button_gadget.allow_recompute_size;
			enable_resize_width;
			enable_resize_height
		end;
	
	forbid_recompute_size
			-- Disallow current button to recompute its  size according to
			-- some changes on its text.
		do
			button_gadget.forbid_recompute_size;
			disable_resize_width;
			disable_resize_height
		end;

feature -- Removal

	remove_title
			-- Remove title.
		do
			set_title ("")
		end;

feature {NONE} -- Implementation

	add_activate_action (a_command: COMMAND; argument: ANY)
		do
		end

	add_release_action (a_command: COMMAND; argument: ANY)
		do
		end

	add_arm_action (a_command: COMMAND; argument: ANY)
		do
		end

	remove_activate_action (a_command: COMMAND; argument: ANY)
		do
		end

	remove_release_action (a_command: COMMAND; argument: ANY)
		do
		end

	remove_arm_action (a_command: COMMAND; argument: ANY)
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class OPTION_B_IMP

