note

	description:
		"Pulldown menu of an option button, it is attached to an option %
		%button which is automatically created. It can contain all %
		%kinds of buttons"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	OPT_PULL

inherit

	PULLDOWN
		redefine
			parent, implementation
		end;

create

	make, make_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_name: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_name: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a pulldown menu with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			widget_manager.new (Current, a_parent);
			create {OPT_PULL_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	parent: COMPOSITE
			-- Parent of pulldown menu
		do
			Result ?= widget_manager.parent (Current)
		end;

	selected_button: BUTTON
					-- Current Push Button selected in the option menu
		require
			exists: not destroyed
		do
			Result := implementation.selected_button
		end;

	option_button: OPTION_B
			-- Option button of the current opt_pull
		require
			exists: not destroyed
		do
			Result := implementation.option_button
		end;

	button: BUTTON
		do
			Result := option_button
		end;

	caption: STRING
		require
			exists: not destroyed
		do
			Result := implementation.caption;
		end

feature -- Element change

   	set_selected_button (a_button: BUTTON)
					-- Set `selected_button' to `a_button'
		require
			exists: not destroyed
		do
			implementation.set_selected_button(a_button)
		ensure
			a_button.same (selected_button)
		end;

	set_caption (a_caption: STRING)
		require
			exists: not destroyed;
			valid_caption: a_caption /= Void;
		do
			implementation.set_caption (a_caption);
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: OPT_PULL_I;
			-- Implementation of pulldown menu

feature {NONE} -- Implementation

	set_default
			-- Set default values to current pulldown menu.
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




end -- class OPT_PULL

