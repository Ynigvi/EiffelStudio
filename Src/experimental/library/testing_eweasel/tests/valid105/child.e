
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class CHILD
inherit
	PARENT
		rename
			weasel as wimp
		end
	PARENT
		select
			weasel
		end
end
