-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct MenuTrackingData

class MENU_TRACKING_DATA_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct MenuTrackingData)"
		end

	get_menu_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_menu"
		end

	set_menu_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_menu"
		ensure
			a_value_set: a_value = get_menu_external (an_item)
		end

	get_itemselected_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_itemSelected"
		end

	set_itemselected_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_itemSelected"
		ensure
			a_value_set: a_value = get_itemselected_external (an_item)
		end

	get_itemundermouse_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_itemUnderMouse"
		end

	set_itemundermouse_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_itemUnderMouse"
		ensure
			a_value_set: a_value = get_itemundermouse_external (an_item)
		end

	get_itemrect_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_itemRect"
		end

	set_itemrect_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_itemRect"
		end

	get_virtualmenutop_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_virtualMenuTop"
		end

	set_virtualmenutop_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_virtualMenuTop"
		ensure
			a_value_set: a_value = get_virtualmenutop_external (an_item)
		end

	get_virtualmenubottom_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_get_virtualMenuBottom"
		end

	set_virtualmenubottom_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuTrackingData_member_set_virtualMenuBottom"
		ensure
			a_value_set: a_value = get_virtualmenubottom_external (an_item)
		end

end
