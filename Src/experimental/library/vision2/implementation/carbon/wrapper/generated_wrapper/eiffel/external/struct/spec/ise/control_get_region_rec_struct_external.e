-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct ControlGetRegionRec

class CONTROL_GET_REGION_REC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct ControlGetRegionRec)"
		end

	get_region_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlGetRegionRec_member_get_region"
		end

	set_region_external (an_item: POINTER; a_value: POINTER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlGetRegionRec_member_set_region"
		ensure
			a_value_set: a_value = get_region_external (an_item)
		end

	get_part_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlGetRegionRec_member_get_part"
		end

	set_part_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_ControlGetRegionRec_member_set_part"
		ensure
			a_value_set: a_value = get_part_external (an_item)
		end

end
