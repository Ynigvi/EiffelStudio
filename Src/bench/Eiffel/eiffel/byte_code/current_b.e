-- Access to Current

class CURRENT_B 

inherit

	ACCESS_B
		redefine
			enlarged, is_current, make_byte_code,
			register_name, pre_inlined_code
		end;
	
feature 

	type: TYPE_I is
			-- Current type
		do
			Result := context.current_type;
		end;

	is_current: BOOLEAN is
			-- This is an access to Current
		do
			Result := True
		end

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			current_b: CURRENT_B;
		do
			current_b ?= other;
			Result := current_b /= Void
		end;

	enlarged: CURRENT_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			!CURRENT_BL!Result;
		end;

	register_name: STRING is
			-- The "Current" string
		once
			Result := "Current";
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to Current
		do
			ba.append (Bc_current);
		end;

feature -- Inlining

	pre_inlined_code: like Current is
		do
			!INLINED_CURRENT_B!Result
		end

end
