indexing
	description: "Objects join all debug values: STRING, INTEGER, BOOLEAN, REFERENCES, ..."
	author: "Arnaud PICHERY"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE

inherit
	DEBUG_EXT
	BEURK_HEXER

create
	make_boolean, make_character, make_integer, make_real,
	make_double, make_pointer, make_object,	make_manifest_string

feature -- Initialization

	make_boolean(value: BOOLEAN) is
			-- make a boolean item initialized to `value'
		do
			value_boolean := value
			type := Type_boolean
		ensure
			type /= Type_unknown
		end

	make_character(value: CHARACTER) is
			-- make a character item initialized to `value'
		do
			value_character := value
			type := Type_character
		ensure
			type /= Type_unknown
		end

	make_integer(value: INTEGER) is
			-- make a integer item initialized to `value'
		do
			value_integer := value
			type := Type_integer
		ensure
			type /= Type_unknown
		end

	make_real(value: REAL) is
			-- make a real item initialized to `value'
		do
			value_real := value
			type := Type_real
		ensure
			type /= Type_unknown
		end

	make_double(value: DOUBLE) is
			-- make a double item initialized to `value'
		do
			value_double := value
			type := Type_double
		ensure
			type /= Type_unknown
		end

	make_pointer(value: POINTER) is
			-- make a pointer item initialized to `value'
		do
			value_pointer := value
			type := Type_pointer
		ensure
			type /= Type_unknown
		end

	make_object(value: STRING) is
			-- make a object item initialized to `value'
		do
			value_object := value
			type := Type_object
		ensure
			type /= Type_unknown
		end

	make_manifest_string(value: STRING) is
			-- make a string item initialized to `value'
		do
			value_object := value
			type := Type_string
		ensure
			type /= Type_unknown
		end

feature -- Action
	
	send_value is
			-- send the value the application
		local
			value_string_c: ANY
		do
			inspect (type)
				when Type_boolean then
					send_bool_value(value_boolean)

				when Type_character then
					send_char_value(value_character)

				when Type_integer then
					send_integer_value(value_integer)

				when Type_real then
					send_real_value(value_real)

				when Type_double then
					send_double_value(value_double)

				when Type_pointer then
					send_ptr_value(value_pointer)

				when Type_string then
					value_string_c := value_object.to_c
					send_string_value($value_string_c)
				
				when Type_object then
					send_ref_value(hex_to_integer(value_object))

				else
					-- unexpected value, do nothing
					debug("DEBUGGER")
						io.putstring ("Error: unexpected value in [DUMP_VALUE]send_value%N")
					end
			end
		end
	

feature -- Inapplicable

feature {NONE} -- Implementation

	type: INTEGER 
		-- type discrimant, possible values are Type_XXXX

	value_boolean	: BOOLEAN
	value_character	: CHARACTER
	value_integer	: INTEGER
	value_real		: REAL
	value_double	: DOUBLE
	value_bits		: BIT_REF -- not yet implemented.
	value_pointer	: POINTER
	value_object	: STRING -- string standing for the address of the object if type=Type_object, or 
							 -- String if type=Type_string

feature {NONE} -- Private Constants
	
	Type_unknown	: INTEGER is 0
	Type_boolean	: INTEGER is 1
	Type_character	: INTEGER is 2
	Type_integer	: INTEGER is 3
	Type_real		: INTEGER is 4
	Type_double		: INTEGER is 5
	Type_bits		: INTEGER is 6
	Type_pointer	: INTEGER is 7
	Type_object		: INTEGER is 8
	Type_string		: INTEGER is 9

end -- class DUMP_VALUE
