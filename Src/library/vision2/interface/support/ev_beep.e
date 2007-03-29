indexing
	description: "System beep rountines."
	legal: "See notice at end of class."
	keywords: "color, pixel, rgb, 8, 16, 24"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_BEEP

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Commands

	asterisk is
			-- Asterisk beep.
		do
			implementation.asterisk
		end

	exclamation is
			-- Exclamation beep.
		do
			implementation.exclamation
		end

	hand is
			-- Hand beep.
		do
			implementation.hand
		end

	question is
			-- Question beep.
		do
			implementation.question
		end

	ok is
			-- Ok beep.
			-- System default beep.
		do
			implementation.ok
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_BEEP_I
			-- Responsible for interaction with native APIs.			

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_BEEP_IMP} implementation.make (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_BEEP
