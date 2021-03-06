note
	description: "Objects that provide a new attribute editor for EV_WIDGET properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	GB_CONSTANTS

feature -- Access

	ev_type: EV_WIDGET

	type: STRING
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_widget_string
		end

	update_attribute_editor
			-- Update status of `attribute_editor' to reflect information
			-- from `first'.
		do
			minimum_height_entry.set_text (first.minimum_height.out)
			minimum_width_entry.set_text (first.minimum_width.out)
		end

	attribute_editor: GB_OBJECT_EDITOR_ITEM
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create minimum_width_entry.make (Current, Result, Minimum_width_string, gb_ev_widget_minimum_width, gb_ev_widget_minimum_width_tooltip, agent set_minimum_width (?), agent valid_minimum_dimension (?), components)
			create minimum_height_entry.make (Current, Result, Minimum_height_string, gb_ev_widget_minimum_height, gb_ev_widget_minimum_height_tooltip, agent set_minimum_height (?), agent valid_minimum_dimension (?), components)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end

	initialize_agents
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
		end

feature {NONE} -- Implementation

	minimum_width_entry, minimum_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `minimum_width' and `minimum_height'.

	set_minimum_width (integer: INTEGER)
			-- Update property `minimum_width' on the first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_width (integer))
		end

	valid_minimum_dimension (value: INTEGER): BOOLEAN
			-- Is `value' a valid minimum_width or minimum_height?
		do
			Result := value >= 0
		end

	set_minimum_height (integer: INTEGER)
			-- Update property `minimum_height' on first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_height (integer))
		end

	Minimum_width_string: STRING = "Minimum_width"
	Minimum_height_string: STRING = "Minimum_height";

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


end -- class GB_EV_WIDGET_EDITOR
