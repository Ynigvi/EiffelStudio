indexing

	description:
		"Resource valid for the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("system_tool_width", rt, 440)
			create tool_height.make ("system_tool_height", rt, 500)
			create command_bar.make ("system_tool_bar", rt, true)
			create parse_ace_after_saving.make ("parse_ace_after_saving", rt, True)
			--!! hidden_clusters.make ("hidden_clusters", rt, <<>>)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	parse_ace_after_saving: BOOLEAN_RESOURCE
	--hidden_clusters: ARRAY_RESOURCE

end -- class SYSTEM_CATEGORY
