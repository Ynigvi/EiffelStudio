indexing
	description: "Command to display the ancestors of a routine."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ROUTINE_ANCESTORS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd
		end

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_ancestors, 1)
			Result.put (Pixmaps.Icon_format_feature_ancestors, 2)
		end
 
	feature_cmd: E_SHOW_ROUTINE_ANCESTORS
			-- Feature command that can generate the information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showpast
		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Routine_ancestors
		end

	post_fix: STRING is "ran"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (associated_feature)
		end

end -- class EB_ROUTINE_ANCESTORS_FORMATTER


