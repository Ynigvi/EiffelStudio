indexing
	description: "AST representation of binary `/=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_NE_AS

inherit
	BIN_EQ_AS
		redefine
			infix_function_name, byte_anchor
		end

	PREFIX_INFIX_NAMES

feature -- Properties

	infix_function_name: STRING is 
		once
			Result := not_equal_infix
		end

	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			!BIN_NE_B! Result
		end

end -- class BIN_NE_AS
