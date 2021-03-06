note

	description: "Simple label"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	LABEL

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

create

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create a unmanaged label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {LABEL_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	text: STRING
			-- Text of current label
		require
			exists: not destroyed
		do
			Result:= implementation.text
		end

feature -- Status setting

	allow_recompute_size
			-- Allow current label to recompute its size according to
			-- changes on its value.
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size
			-- Forbid current label to recompute its size according to
			-- changes on its value.
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size
		end;

	set_center_alignment
			-- Set text alignment of current label to center.
		require
			exists: not destroyed
		do
			implementation.set_center_alignment
		end;

	set_right_alignment
			-- Set text alignment of current label to right.
		require
			exists: not destroyed
		do
			implementation.set_right_alignment
		end;

	set_left_alignment
			-- Set text alignment of current label to left.
		require
			exists: not destroyed
		do
			implementation.set_left_alignment
		end;

feature -- Element chnage

	set_text (a_text: STRING)
			-- Set text of current label to `a_text'.
		require
			exists: not destroyed;
			not_a_text_void: a_text /= Void
		do
			implementation.set_text (a_text);
		ensure
			text.is_equal (a_text)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: LABEL_I;
			-- Implementation of current label

feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementatino

	is_fontable: BOOLEAN = True;
			-- Is current widget an heir of FONTABLE ?

feature {NONE} -- Implementation

	set_default
			-- Set default values to current label.
		do
		end;

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




end -- class LABEL

