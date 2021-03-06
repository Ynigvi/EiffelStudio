note
	description: "Template for the last state of a wizard"
	legal:       "See notice at end of class."
	status:      "See notice at end of class."
	author:      "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date:        "$Date$"
	revision:    "$Revision$"

deferred class
	WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			display,
			proceed_with_current_info,
			is_final_state
		end

feature -- Basic Operations

	display
			-- Display Current State
		do
			first_window.set_final_state (b_finish)
			build
		end

	proceed_with_current_info
			-- destroy the window.
			-- Descendants have to redefine this routine
			-- if they want to add generation, warnings, ...
		do
			precursor
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

	notify_user (s: STRING)
			-- Output
		require
			not_void: s /= Void
		do
			progress_text.set_text(s)
			iteration := iteration + 1
			progress.set_proportion((iteration/total).truncated_to_real)
		end

	total, iteration: INTEGER

feature -- Access

	is_final_state: BOOLEAN = TRUE

	progress_text: EV_LABEL

	progress: EV_HORIZONTAL_PROGRESS_BAR;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source:	"[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
