indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: change, modify, update
	Product: EiffelStore
	Database: All_Bases

deferred class DB_CHANGE_I

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok
			{ANY} is_connected
		end

	DB_EXEC_USE

feature -- Element change

	modify (s: STRING) is
			-- Pass to active database handle a modification
			-- query with SQL statement `s'.
		deferred
		end

feature -- Status setting

	set_ht (table: HASH_TABLE [ANY, STRING]) is
			-- Pass map `table' to current.
		deferred
		end

end -- class DB_CHANGE_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
