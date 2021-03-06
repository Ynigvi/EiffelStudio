note
	description: "Objects that test `style' of EV_FRAME."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_STYLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			combo_box: EV_COMBO_BOX
			list_item: EV_LIST_ITEM
		do
				-- Create `frame' using `make_with_text'.
			create frame.make_with_text ("A Frame")
			frame.set_minimum_size (200, 200)
			
			create vertical_box
			vertical_box.extend (frame)
			
			create combo_box
			create list_item.make_with_text ("Lowered")
			list_item.select_actions.extend (agent frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_lowered))
			combo_box.extend (list_item)
			create list_item.make_with_text ("Raised")
			list_item.select_actions.extend (agent frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_raised))
			combo_box.extend (list_item)
			create list_item.make_with_text ("Etched in")
			list_item.select_actions.extend (agent frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_etched_in))
			combo_box.extend (list_item)
			create list_item.make_with_text ("Etched out")
			list_item.select_actions.extend (agent frame.set_style ({EV_FRAME_CONSTANTS}.Ev_frame_etched_out))
			combo_box.extend (list_item)
			
			vertical_box.extend (combo_box)
			vertical_box.disable_item_expand (combo_box)
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	frame: EV_FRAME;
		-- Widget that test is to be performed on.

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


end -- class FRAME_STYLE_TEST
