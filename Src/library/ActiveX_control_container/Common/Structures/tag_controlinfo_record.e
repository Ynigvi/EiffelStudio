note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_CONTROLINFO_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	cb: INTEGER
			-- No description available.
		do
			Result := ccom_tag_controlinfo_cb (item)
		end

	h_accel: POINTER
			-- No description available.
		do
			Result := ccom_tag_controlinfo_h_accel (item)
		end

	c_accel: INTEGER
			-- No description available.
		do
			Result := ccom_tag_controlinfo_c_accel (item)
		end

	dw_flags: INTEGER
			-- No description available.
		do
			Result := ccom_tag_controlinfo_dw_flags (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_tag_controlinfo
		end

feature -- Basic Operations

	set_cb (a_cb: INTEGER)
			-- Set `cb' with `a_cb'.
		do
			ccom_tag_controlinfo_set_cb (item, a_cb)
		end

	set_h_accel (a_h_accel: POINTER)
			-- Set `h_accel' with `a_h_accel'.
		do
			ccom_tag_controlinfo_set_h_accel (item, a_h_accel)
		end

	set_c_accel (a_c_accel: INTEGER)
			-- Set `c_accel' with `a_c_accel'.
		do
			ccom_tag_controlinfo_set_c_accel (item, a_c_accel)
		end

	set_dw_flags (a_dw_flags: INTEGER)
			-- Set `dw_flags' with `a_dw_flags'.
		do
			ccom_tag_controlinfo_set_dw_flags (item, a_dw_flags)
		end

feature {NONE}  -- Externals

	c_size_of_tag_controlinfo: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagCONTROLINFO_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagCONTROLINFO)"
		end

	ccom_tag_controlinfo_cb (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *):EIF_INTEGER"
		end

	ccom_tag_controlinfo_set_cb (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *, ULONG)"
		end

	ccom_tag_controlinfo_h_accel (a_pointer: POINTER): POINTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *):EIF_POINTER"
		end

	ccom_tag_controlinfo_set_h_accel (a_pointer: POINTER; arg2: POINTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *, ecom_control_library::wireHACCEL)"
		end

	ccom_tag_controlinfo_c_accel (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *):EIF_INTEGER"
		end

	ccom_tag_controlinfo_set_c_accel (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *, USHORT)"
		end

	ccom_tag_controlinfo_dw_flags (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *):EIF_INTEGER"
		end

	ccom_tag_controlinfo_set_dw_flags (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCONTROLINFO_s_impl.h%"](ecom_control_library::tagCONTROLINFO *, ULONG)"
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




end -- TAG_CONTROLINFO_RECORD

