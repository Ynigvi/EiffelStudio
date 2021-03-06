note
	description: "Window on which is displayed the wizards"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WINDOW

inherit
	EV_TITLED_WINDOW
		rename
			copy as copy_titled_window
		redefine
			create_interface_objects,
			destroy,
			initialize,
			is_in_default_state
		select
			copy_titled_window
		end

	WIZARD_STATE_MANAGER
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_factory: WIZARD_FACTORY)
			-- Initialize Current window.
		require
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory
			default_create
		ensure
			factory_set: factory = a_factory
		end

	create_interface_objects
			-- <Precursor>
		do
			create wizard_page
			create help_b
			create cancel_b
			create next_b
			create previous_b

			Precursor
		end

	initialize
			-- <Precursor>
		local
			v1: EV_VERTICAL_BOX
		do
			Precursor
			create v1
			v1.extend (wizard_page)
			build_navigation_bar (v1)
			extend (v1)
			set_size (dialog_unit_to_pixels(503), dialog_unit_to_pixels(385))
		end

	build_navigation_bar (a_box: EV_BOX)
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
			h_sep: EV_HORIZONTAL_SEPARATOR
			navigation_bar: EV_HORIZONTAL_BOX
					-- Horizontal box containing navigation buttons
		do
			create previous_b.make_with_text_and_action (b_back, agent previous_page)
			previous_b.align_text_center
			set_default_size_for_button (previous_b)

			create next_b.make_with_text_and_action (b_next, agent next_page)
			next_b.align_text_center
			set_default_size_for_button (next_b)

			create cancel_b.make_with_text_and_action (b_cancel, agent cancel_actions)
			cancel_b.align_text_center
			set_default_size_for_button (cancel_b)

			create help_b.make_with_text_and_action (b_help, agent show_help)
			help_b.align_text_center
			set_default_size_for_button (help_b)
			help_b.hide

			create h1
			h1.extend (previous_b)
			h1.disable_item_expand(previous_b)
			h1.extend (next_b)
			h1.disable_item_expand (next_b)

			create navigation_bar
			navigation_bar.set_padding (dialog_unit_to_pixels(11))
			navigation_bar.set_border_width (dialog_unit_to_pixels(11))
			navigation_bar.extend (help_b)
			navigation_bar.disable_item_expand (help_b)
			navigation_bar.extend (create {EV_CELL})
			navigation_bar.extend (h1)
			navigation_bar.disable_item_expand (h1)
			navigation_bar.extend (cancel_b)
			navigation_bar.disable_item_expand (cancel_b)

			create h_sep
			a_box.extend (h_sep)
			a_box.disable_item_expand (h_sep)
			a_box.extend (navigation_bar)
			a_box.disable_item_expand (navigation_bar)
		end

feature {WIZARD_SHARED} -- Basic Opertations

	load_first_state
			-- Load first state.
		local
			wizard_initial_state: WIZARD_STATE_WINDOW
		do
			wizard_initial_state := factory.new_wizard_initial_state
			proceed_with_new_state (wizard_initial_state)
			update_navigation
		end

feature -- Basic Operations

	add_help_button
			-- Add help button to the navigation bar.
		do
			check
				non_void_help_button: help_b /= Void
			end
			help_b.show
		end

feature -- Command

	destroy
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor
			if attached (create {EV_ENVIRONMENT}).application as a then
				a.destroy
			end
		end

feature -- Access

	wizard_page: EV_VERTICAL_BOX
			-- Page on which is displayed the information
			-- needed to be completed by the user in order
			-- to be performed.

	factory: WIZARD_FACTORY
			-- Factory to create initial wizard window.

feature {NONE} -- Implementation

	previous_b, next_b, cancel_b, help_b: EV_BUTTON
			-- Button ensuring the navigation.

	is_final: BOOLEAN
			-- Is it the final state?

feature {WIZARD_STATE_WINDOW, WIZARD_STATE_MANAGER} -- Basic Operations	

	set_final_state (text: READABLE_STRING_GENERAL)
			-- Current state is final, hence a special process.
		do
			next_b.set_text(text)
			is_final := True
		end

	set_intermediary_state
			-- Current state is intermediate.
		do
			is_final := False
		end

	disable_next_button
			-- Disable the Next/Finish button
		do
			next_b.disable_sensitive
		end

	disable_back_button
			-- Disable the Next/Finish button
		do
			previous_b.disable_sensitive
		end

	disable_cancel_button
			-- Disable the cancel button
		do
			cancel_b.disable_sensitive
		end

	enable_next_button
			-- Ensable the Next/Finish button
		do
			next_b.enable_sensitive
		end

	enable_back_button
			-- Enable the Next/Finish button
		do
			previous_b.enable_sensitive
		end

	enable_cancel_button
			-- Enable the cancel button
		do
			cancel_b.enable_sensitive
		end

feature -- Basic Operations

	previous_page
			-- Go to the previous page.
		do
			if history.count > 1 then
				back
			end
			update_navigation
		end

	update_navigation
			-- Update navigation buttons.
		do
			if history.count < 1 or else history.isfirst  then
				previous_b.disable_sensitive
			elseif is_final then
				previous_b.enable_sensitive
			else
				previous_b.enable_sensitive
				next_b.set_text(b_next)
			end
		end

	next_page
			-- Go to next page if possible.
		do
			if not history.after then
				next
			end
			update_navigation
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN = True;
		-- Is `Current' in its default state?

invariant
	factory_not_void: factory /= Void

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
