indexing

	description: 
		"Callback structure specific to the toggle button. %
		%Associated C structure is XmToggleButtonCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_CALLBACK_STRUCT

inherit

	MEL_ANY_CALLBACK_STRUCT
		redefine
			reasons_list
		end

creation
	make

feature -- Access

	reasons_list: ARRAY [INTEGER] is 
			-- List of reasons that is valid for this
			-- callback structure
			-- (Reasons - XmCR_ARM, XmCR_DISARM, XmCR_VALUE_CHANGED)
		once
			Result := <<XmCR_ARM, XmCR_DISARM, XmCR_VALUE_CHANGED>>;
		end;

	set: BOOLEAN is
			-- Is the button selected?
		do
			Result := c_set (handle) /= 0
		end

feature {NONE} -- Implementation

	c_set (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmToggleButtonCallbackStruct *): EIF_INTEGER"
		end;

end -- class MEL_TOGGLE_BUTTON_CALLBACK_STRUCT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
