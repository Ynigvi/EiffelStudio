note
	description: "COM IDLDESC structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_IDL_DESC

inherit
	ECOM_STRUCTURE

	ECOM_IDL_FLAGS
		undefine
			copy, is_equal
		end

create
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	flags: INTEGER
			-- Flags
		do
			Result := ccom_idldesc_flags (item)
		ensure
			is_valid_idlflag (Result)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of IDLDESC structure
		do
			Result := c_size_of_idl_desc
		end

feature {NONE} -- Externals

	c_size_of_idl_desc: INTEGER
		external 
			"C [macro %"E_idldesc.h%"]"
		alias
			"sizeof(IDLDESC)"
		end

	ccom_idldesc_flags(a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_idldesc.h%"]"
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
end -- class ECOM_IDL_DESC


