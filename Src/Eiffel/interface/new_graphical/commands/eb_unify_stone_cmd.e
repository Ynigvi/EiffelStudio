note
	description: "Command to separate the stone management between the development%
				%window and the context tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_UNIFY_STONE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext
		end

	EB_RECYCLABLE

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (dev: EB_DEVELOPMENT_WINDOW)
			-- Initialize `Current' and associate it with `dev'.
		do
			window := dev
			enable_sensitive
		end

feature -- Status report

	description: STRING_GENERAL
		do
			Result := Interface_names.e_Toggle_stone_management
		end

	name: STRING = "Toggle_stone"

	pixmap: EV_PIXMAP
		do
			if window.is_unified_stone then
				Result := pixmaps.icon_pixmaps.context_unlink_icon
			else
				Result := pixmaps.icon_pixmaps.context_link_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			if window.is_unified_stone then
				Result := pixmaps.icon_pixmaps.context_unlink_icon_buffer
			else
				Result := pixmaps.icon_pixmaps.context_link_icon_buffer
			end
		end

	tooltip: STRING_GENERAL
		do
			if window.is_unified_stone then
				Result := Interface_names.e_Separate_stone
			else
				Result := Interface_names.e_Unify_stone
			end
		end

	tooltext: STRING_GENERAL
			-- Text displayed on the toolbar button.
		do
			Result := Interface_names.b_Toggle_stone_management
		end

	menu_name: STRING_GENERAL
		do
			if window.is_unified_stone then
				Result := Interface_names.m_Separate_stone
			else
				Result := Interface_names.m_Unify_stone
			end
		end

feature -- Basic operations

	execute
			-- Toggle between a unified mode and a separate mode.
		local
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
			mi: EV_MENU_ITEM
		do
			if not flag then
				flag := True
				window.toggle_unified_stone
				if internal_managed_menu_items /= Void then
					from
						internal_managed_menu_items.start
					until
						internal_managed_menu_items.after
					loop
						mi := internal_managed_menu_items.item
						if mi /= Void then
							mi.remove_text
							mi.set_text (menu_name)
							mi.set_pixmap (pixmap)
						end
						internal_managed_menu_items.forth
					end
				end

				if internal_managed_sd_toolbar_items /= Void then
					from
						internal_managed_sd_toolbar_items.start
					until
						internal_managed_sd_toolbar_items.after
					loop
						l_button := internal_managed_sd_toolbar_items.item
						if l_button /= Void then
							l_button.select_actions.block
							if window.is_unified_stone then
								l_button.enable_select
							else
								l_button.disable_select
							end
							l_button.select_actions.resume
						end
						internal_managed_sd_toolbar_items.forth
					end
				end

				update_tooltip
				flag := False
			end
		end

	update_tooltip
			-- Display the good tooltip on buttons.
		do
			if internal_managed_sd_toolbar_items /= Void then
				internal_managed_sd_toolbar_items.do_all (agent {EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON}.set_tooltip (tooltip))
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON
			-- Create a new sd toolbar button for this command.
		do
				-- Create the button
			create Result.make (Current)
			check added: recycle_pool.has (Result) end
			initialize_sd_toolbar_item (Result, display_text)
			if window.preferences.development_window_data.context_unified_stone then
				Result.enable_select
			end
			Result.select_actions.extend (agent execute)
			Result.enable_sensitive
		end

feature {NONE} -- Recyclable

	internal_recycle
			-- Recycle
		do
			window := Void
		end

feature {NONE} -- Implementation

	flag: BOOLEAN
			-- Is `Current' being executed?

	window: EB_DEVELOPMENT_WINDOW;
			-- Window `Current' is associated with.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_UNIFY_STONE_CMD
