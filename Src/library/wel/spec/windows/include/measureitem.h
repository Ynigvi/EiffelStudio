/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __WEL_MEASUREITEMSTRUCT__
#define __WEL_MEASUREITEMSTRUCT__

#ifndef __WEL__
# include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_measureitemstruct_get_ctltype(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->CtlType))
#define cwel_measureitemstruct_get_ctlid(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->CtlID))
#define cwel_measureitemstruct_get_itemid(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemID))
#define cwel_measureitemstruct_get_itemwidth(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemWidth))
#define cwel_measureitemstruct_get_itemheight(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemHeight))
#define cwel_measureitemstruct_get_itemdata(_ptr_) ((EIF_INTEGER) (((MEASUREITEMSTRUCT *) _ptr_)->itemData))

#define cwel_measureitemstruct_set_itemwidth(_ptr_, _value_) (((MEASUREITEMSTRUCT *) _ptr_)->itemWidth = (_value_))
#define cwel_measureitemstruct_set_itemheight(_ptr_, _value_) (((MEASUREITEMSTRUCT *) _ptr_)->itemHeight = (_value_))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MEASUREITEMSTRUCT__ */
