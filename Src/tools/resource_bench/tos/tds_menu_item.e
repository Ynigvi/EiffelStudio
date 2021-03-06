note
	description: "Menu item representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_MENU_ITEM

create
	make

feature -- Initialization

	make
		do
			is_separator := false
			create command_id
		end

feature  -- Access

	text: STRING
			-- Text caption of the menu item.

	command_id: TDS_ID
			-- Id of the associated menu item command.

	flags: LINKED_LIST [STRING]
			-- 

	is_separator: BOOLEAN
			-- Is the menu item a separator?
			
	
	popup_menu: TDS_MENU
			-- Link to the popup-menu.

feature -- Element change

	set_text (a_text: STRING)
			-- Set `text' to `a_text'
		require
			a_text_exists: a_text /= Void and then a_text.count > 0
		do
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

	set_command_id (a_command_id: STRING)
			-- Set `command_id' to `a_command_id'
		require
			a_command_id_exits: a_command_id /= Void and then a_command_id.count > 0
		do
			command_id.set_id (a_command_id)
		end

	insert_flags (a_flag: STRING)
			-- Insert `a_flag' into `flags'.
		require
			a_flag_exists: a_flag /= Void and then a_flag.count > 0
		do
			if (flags = Void) then
				create flags.make
			end

			flags.extend (a_flag.twin)
		end

	set_separator
			-- Make the menu item a separator item.
		do
			is_separator := true
		ensure
			is_separator_set: is_separator
		end

	set_popup_menu (a_menu: TDS_MENU)
			-- Set `popup_menu' to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			popup_menu := a_menu
		ensure
			popup_menu_set: popup_menu = a_menu
		end

feature -- Code generation

	display
		do
			if (not is_separator) then
				if (text /= Void) and (popup_menu /= Void) then
					io.putstring (text)
				elseif (text /= Void) then
					io.putstring (text)
					io.putstring (" ")
					command_id.display
				end

				if (flags /= Void) then
					io.putstring (" FLAGS = ")
					from
						flags.start
					until 
						flags.after

					loop
						io.putstring (flags.item)
						io.putstring (" ")

						flags.forth
					end
				end

				if (popup_menu /= Void) then
					io.new_line
					io.putstring ("Popup-Menu :%N")
					popup_menu.display_popup
					io.putstring ("End Popup-menu")
				end
			else
				io.putstring ("SEPARATOR")
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE)
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (not is_separator) then
				if (popup_menu /= Void) then
					a_resource_file.putstring ("%N%TPOPUP ")
				else
					a_resource_file.putstring ("%N%TMENUITEM ")
				end

				if (text /= Void) and (popup_menu /= Void) then
					a_resource_file.putstring (text)
				elseif (text /= Void) then
					a_resource_file.putstring (text)
					a_resource_file.putstring (", ")
					command_id.generate_resource_file (a_resource_file)
				end

				if (flags /= Void) then
					a_resource_file.putstring (", ")

					from
						flags.start
					until 
						flags.after

					loop
						a_resource_file.putstring (flags.item)
						a_resource_file.putstring (" ")

						flags.forth
					end
				end

				if (popup_menu /= Void) then
					a_resource_file.putstring ("%N%TBEGIN")
					popup_menu.generate_resource_file_popup (a_resource_file)
					a_resource_file.putstring ("%N%TEND")
				end
			else
				a_resource_file.putstring ("%N%TMENUITEM SEPARATOR")
			end
		end

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
end -- class TDS_MENU_ITEM

