indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_COMPONENT_VIEWER_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local 
			l_ev_vertical_box_1: EV_VERTICAL_BOX
			l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
			l_ev_tool_bar_1: EV_TOOL_BAR
			l_ev_tool_bar_separator_1, l_ev_tool_bar_separator_2: EV_TOOL_BAR_SEPARATOR
			l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_tool_bar_1
			create component_button
			create l_ev_tool_bar_separator_1
			create display_button
			create builder_button
			create l_ev_tool_bar_separator_2
			create type_display
			create l_ev_horizontal_separator_1
			create component_holder
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_tool_bar_1)
			l_ev_tool_bar_1.extend (component_button)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_1)
			l_ev_tool_bar_1.extend (display_button)
			l_ev_tool_bar_1.extend (builder_button)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_2)
			l_ev_horizontal_box_1.extend (type_display)
			l_ev_vertical_box_1.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_1.extend (component_holder)
			
			set_minimum_width (300)
			set_minimum_height (400)
			set_title ("Display window")
			l_ev_vertical_box_1.set_padding_width (2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_separator_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_tool_bar_1)
			component_button.set_tooltip ("Target component into tool")
			component_button.set_pixmap (icon_component_viewer_color_png)
			display_button.set_tooltip ("Display view")
			display_button.set_pixmap (icon_component_display_view_color_png)
			builder_button.set_tooltip ("Builder view")
			builder_button.set_pixmap (icon_component_build_view_color_png)
			type_display.align_text_left
			
				--Connect events.
			component_button.select_actions.extend (agent show_usage_dialog)
			display_button.select_actions.extend (agent set_display_view)
			builder_button.select_actions.extend (agent set_build_view)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	component_button: EV_TOOL_BAR_BUTTON
	display_button, builder_button: EV_TOOL_BAR_RADIO_BUTTON
	type_display: EV_LABEL
	component_holder: EV_CELL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	show_usage_dialog is
			-- Called by `select_actions' of `component_button'.
		deferred
		end
	
	set_display_view is
			-- Called by `select_actions' of `display_button'.
		deferred
		end
	
	set_build_view is
			-- Called by `select_actions' of `builder_button'.
		deferred
		end
	

end -- class GB_COMPONENT_VIEWER_IMP
