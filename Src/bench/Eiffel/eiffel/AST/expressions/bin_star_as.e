indexing
	description: "AST representation of binary `*' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_STAR_AS

inherit
	ARITHMETIC_AS

	PREFIX_INFIX_NAMES
		rename
			star_infix as infix_function_name
		end

feature -- Properties

	byte_anchor: BIN_STAR_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_STAR_AS
