
indexing

	description:
		"Server root-class for the polling example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POLLING_SERVER

create

	make

feature

	make (argv: ARRAY [STRING]) is
		local
			x, y: INTEGER
			soc: NETWORK_DATAGRAM_SOCKET
			ps: MEDIUM_POLLER
			readcomm: DATAGRAM_READER
			writecomm: SERVER_DATAGRAM_WRITER
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" portnumber%N")
			else
				create soc.make_bound (argv.item (1).to_integer)
				create ps.make_read_only
				create readcomm.make (soc)
				ps.put_read_command (readcomm)
				create writecomm.make (soc)
				ps.put_write_command (writecomm)
				ps.execute (15, 20000)
				ps.make_write_only
				ps.execute (15, 20000)
				soc.close
			end
		rescue
			if not soc.is_closed then
				soc.close
			end
		end

end -- POLLING_SERVER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

