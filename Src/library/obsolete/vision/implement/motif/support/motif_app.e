note

	description: 
		"Parent of any graphic application based on motif implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	MOTIF_APP 

inherit

	GRAPHICS
		redefine
			init_toolkit
		end

create

	make

feature {NONE} -- Initialization

	make 
			-- Create the application.
		do
			set_toolkit;
			set_default;
			create screen.make ("");
			create base.make (application_name, screen);
			build;
			base.realize;
			iterate
		end;

feature -- Access

	application_name: STRING;
			-- Name of the application top level

	base: BASE;
			-- Top level of the application

	screen: SCREEN;
			-- Default screen of the application
			-- (take the envirronment variable $DISPLAY)

feature -- Element change

	build
			-- Build an application.
		do
		end;

feature {NONE} -- Implementation

	set_default
			-- Define default parameters for the application.
		do
		end;

	init_toolkit: TOOLKIT_IMP; 
			-- Toolkit of the application

	set_toolkit
			-- Set motif as toolkit.
		do
			create init_toolkit.make (application_name);
			if (toolkit = Void) then end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MOTIF_APP

