indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class DIALOG_I 

inherit

	WM_SHELL_I



	
feature 

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		deferred
		end; 

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		deferred
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		deferred
		end;

	is_poped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		obsolete "Use is_popped_up instead, corrected feature spelling."
		deferred
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		deferred
		end;

	lower is
			-- Lower the shell in the stacking order.
		deferred
		end; 

	popdown is
			-- Popdown current dialog shell.
		deferred
		ensure
			not is_popped_up
		end; 

	popup is
			-- Popup current dialog shell with no grab on it.
		deferred
		ensure
			is_popped_up
		end; 

	raise is
			-- Raise the shell to the top of the stacking order.
		deferred
		end; -- raise

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		deferred
		ensure
			is_cascade_grab
		end; -- set_cascade_grab

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		deferred
		ensure
			is_exclusive_grab
		end; -- set_exclusive_grab

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		deferred
		ensure
			is_no_grab
		end -- set_no_grab

feature

	dialog_command_target is
			-- set the command target to the dialog_shell
		deferred
		end;

	widget_command_target is
			-- set the command target to the widget
		deferred
		end;

	screen_object: POINTER is
		deferred
		end

	action_target: POINTER is
		deferred
		end


end -- class DIALOG_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
