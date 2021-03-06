note
	description: "Creation of a like Current."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CURRENT

inherit
	CREATE_INFO
		redefine
			generate_cid, make_type_byte_code,
			generate_cid_array, generate_cid_init,
			generate_gen_type_conversion,
			generate_type_id, generate_type_annotations
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_type: LIKE_CURRENT)
			-- Initialize Current with `a_type'.
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Access

	type: LIKE_CURRENT
			-- Type on which is based current. Useful to keep track of attachment marks.

feature -- Update

	updated_info: CREATE_INFO
			-- <Precursor>
		do
				-- Nothing to do, creating Current never changes.
			Result := Current
		end

feature -- C code generation

	analyze
			-- Mark we need the dynamic type of current
		do
			context.mark_current_used
			context.add_dftype_current
		end

	generate_type (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
			-- Generate creation type id (dynamic type) of current	
		do
			buffer.put_string ("eif_new_type(")
			context.generate_current_dftype
			buffer.put_two_character (',', ' ')
				-- Discard the upper bits as `eif_new_type' only accepts the lower part.
			buffer.put_natural_16 (type.annotation_flags & 0x00FF)
			buffer.put_character (')')
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL_32)
			-- <Precursor>
		do
			context.generate_current_dftype
		end

	generate_type_annotations  (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL_32)
			-- <Precursor>
		do
				-- Discard the upper bits as `eif_new_type' only accepts the lower part.
			buffer.put_natural_16 (type.annotation_flags & 0x00FF)
		end

feature -- Il code generation

	generate_il
			-- Generate byte code for like Current creation type.
		local
			cl_type_i: CL_TYPE_A
		do
			cl_type_i := context.original_class_type.type
			if cl_type_i.is_expanded then
					-- Create type directly.
				(create {CREATE_TYPE}.make (cl_type_i)).generate_il
			else
				il_generator.generate_current
				il_generator.create_like_object
				il_generator.generate_check_cast (Void, cl_type_i)
			end
		end

	generate_il_type
			-- Load type of Current object.
		do
			il_generator.generate_current_as_reference
			il_generator.load_type
		end

feature -- Generic conformance

	generate_gen_type_conversion (a_level: NATURAL)

		do
			-- Nothing.
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN)

		do
			context.generate_current_dftype
			context.buffer.put_character (',')
		end

	make_type_byte_code (ba : BYTE_ARRAY)

		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_current_type)
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER)
		local
			dummy : INTEGER
		do
			buffer.put_string ("0,")
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL)
		local
			dummy : INTEGER
		do
			buffer.put_new_line
			buffer.put_string ("typarr")
			buffer.put_natural_32 (a_level)
			buffer.put_character ('[')
			buffer.put_integer (idx_cnt.value)
			buffer.put_four_character (']', ' ', '=', ' ')
			context.generate_current_dftype
			buffer.put_character (';')
			dummy := idx_cnt.next
		end

	type_to_create : CL_TYPE_A

		do
			-- None.
			-- If Current is generic it already
			-- carries all the info in it's header.
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class CREATE_CURRENT
