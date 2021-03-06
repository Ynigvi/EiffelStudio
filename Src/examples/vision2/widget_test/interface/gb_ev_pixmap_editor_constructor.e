note
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

	GB_EV_PIXMAP_HANDLER
		undefine
			default_create
		end

	GB_CONSTANTS

feature -- Access

	ev_type: EV_PIXMAP
		-- Vision2 type represented by `Current'.

	type: STRING = "EV_PIXMAP"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			frame_box: EV_VERTICAL_BOX
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create horizontal_box
			create frame_box
			create modify_button.make_with_text ("Set with named file")
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (modify_button)
			create filler_label
			horizontal_box.extend (filler_label)
			horizontal_box.disable_item_expand (modify_button)
			frame_box.extend (horizontal_box)
			create pixmap_container
			frame_box.extend (pixmap_container)
			create frame.make_with_text (gb_ev_pixmap_pixmap)
			frame.extend (frame_box)
			Result.extend (frame)
			update_attribute_editor
		end

	update_attribute_editor
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			if first.pixmap_exists then
				add_pixmap_to_pixmap_container (first.twin)
				for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
			elseif first.pixmap_path = Void then
				-- `pixmap_path' is Void when we have not assigned a path yet,
				-- so we do nothing.
			else
				create error_label.make_with_text ("Error - named pixmap missing.")
				error_label.set_tooltip (first.pixmap_path.name)
				pixmap_container.extend (error_label)
				for_all_objects (agent {EV_PIXMAP}.disable_pixmap_exists)
			end
		end

	initialize_agents
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
		end

feature {NONE} -- Implementation

	modify_pixmap
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			new_pixmap: EV_PIXMAP
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
			l_extension: STRING_32
		do
			from
				create dialog
			until
				(dialog.full_file_path.is_empty and shown_once) or opened_file
			loop
				shown_once := True
				dialog.show_modal_to_window (parent_window (parent_editor))
				if not dialog.full_file_path.is_empty then
				 	l_extension := dialog.full_file_path.name
					l_extension := l_extension.substring (l_extension.count - 2, l_extension.count)
					if valid_file_extension (l_extension) then
						create new_pixmap
						new_pixmap.set_with_named_path (dialog.full_file_path)
							-- Must set the pixmap before the stretch takes place.
						for_all_objects (agent {EV_PIXMAP}.set_with_named_path (dialog.full_file_path))
						for_all_objects (agent {EV_PIXMAP}.set_pixmap_path (dialog.full_file_path))
						for_all_objects (agent {EV_PIXMAP}.enable_pixmap_exists)
						add_pixmap_to_pixmap_container (new_pixmap.twin)
						opened_file := True
					else
						create error_dialog
						error_dialog.set_text (invalid_type_warning)
						error_dialog.show_modal_to_window (parent_window (parent_editor))
					end
				end
			end
			rebuild_associated_editors (first)
		end

	add_pixmap_to_pixmap_container (pixmap: EV_PIXMAP)
			-- Add `pixmap' to `pixmap_container'.
		local
			x_ratio, y_ratio: REAL_64
			new_x, new_y: INTEGER
			biggest_ratio: REAL_64
		do
			if first.pixmap_path /= Void then
				pixmap.set_tooltip (first.pixmap_path.name)
					-- We also add a tooltip to the space to the right
					-- of the buttom, through `filler_label'.
				filler_label.set_tooltip (first.pixmap_path.name)
			end
			x_ratio := pixmap.width / minimum_width_of_object_editor
			y_ratio := pixmap.height / minimum_width_of_object_editor
			if x_ratio > 1 and y_ratio < 1 then
				new_x := minimum_width_of_object_editor
				new_y := (pixmap.height / x_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio < 1 then
				new_y := minimum_width_of_object_editor
				new_x := (pixmap.width / y_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio > 1 then
				biggest_ratio := x_ratio.max (y_ratio)
				new_x := (pixmap.width / biggest_ratio).truncated_to_integer
				new_y := (pixmap.height / biggest_ratio).truncated_to_integer
			end

			if new_x /= 0 and new_y /= 0 then
				pixmap.stretch (new_x, new_y)
			end
			pixmap_container.wipe_out
			pixmap_container.extend (pixmap)
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
		end

	pixmap_container: EV_CELL
		-- Holds a representation of the loaded pixmap.

	filler_label: EV_LABEL

	error_label: EV_LABEL

	modify_button: EV_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.

	pixmap_path_string: STRING = "Pixmap_path"

	Remove_string: STRING = "Remove"
		-- String on `modify_button' when able to remove pixmap.

	Remove_tooltip: STRING = "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.

	Select_tooltip: STRING = "Select pixmap";
		-- Tooltip on `modify_button' when able to remove pixmap.

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


end -- class GB_EV_PIXMAP_EDITOR_CONSTRUCTOR
