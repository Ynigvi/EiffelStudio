﻿note
	description: "Allows persisting and retrieving combo content from and to registry"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SAVED_SETTINGS

inherit
	WIZARD_REGISTRY_STORE
		export
			{NONE} all
		end

	ANY

feature -- Access

	max_count: INTEGER
			-- Maximum number of items to be saved per combo box
		do
			if internal_max_count = Void then
				create internal_max_count
				internal_max_count.set_item (Default_max_combo_count)
			end
			Result := internal_max_count.item
		ensure
			valid_count: Result > 0
		end

feature -- Element Change

	set_max_count (a_max_count: INTEGER)
			-- Set `max_count' with `a_max_count'.
		require
			valid_max_count: a_max_count > 0
		do
			if internal_max_count = Void then
				create internal_max_count
			end
			internal_max_count.set_item (a_max_count)
		ensure
			max_count_set: max_count = a_max_count
		end

feature -- Basic Operations

	initialize_combo (a_combo: EV_COMBO_BOX; a_name: STRING)
			-- Fill `a_combo' with saved values with key `a_name' if any.
			-- Will persist combo values in key with name `a_name'.
		require
			non_void_combo: a_combo /= Void
		local
			l_list: LIST [STRING_32]
		do
			a_combo.set_data (agent save_list (?, a_name))
			if is_saved_list (a_name) then
				l_list := saved_list (a_name)
				fill_combo (a_combo, l_list)
			end
		end

	add_combo_item (a_entry: STRING_32; a_combo: EV_COMBO_BOX)
			-- Add entry `a_entry' to combo box `a_combo' if not there already.
			-- Persist combo box strings.
		local
			l_item: EV_LIST_ITEM
			l_entry: STRING_32
			l_has_entry: BOOLEAN
		do
			if not a_entry.is_empty then
				l_entry := a_entry.as_lower
				from
					a_combo.start
				until
					l_has_entry or a_combo.after
				loop
					l_has_entry := a_combo.item.text.same_string (l_entry)
					a_combo.forth
				end
				if not l_has_entry then
					if a_combo.count >= max_count then
						a_combo.finish
						a_combo.remove
					end
					create l_item.make_with_text (a_entry)
					a_combo.put_front (l_item)
				end
				if attached {ROUTINE [LIST [STRING_32]]} a_combo.data as l_save_routine then
					l_save_routine.call (a_combo.strings)
				end
			end
		end

feature {NONE} -- Implementation

	fill_combo (a_combo: EV_COMBO_BOX; a_list: LIST [STRING_32])
			-- Fill `a_combo' with strings in `a_list'.
		require
			non_void_combo: a_combo /= Void
			non_void_list: a_list /= Void
		do
			a_combo.wipe_out
			if not a_list.is_empty then
				a_combo.select_actions.block
				from
					a_list.start
				until
					a_list.after
				loop
					a_combo.extend (create {EV_LIST_ITEM}.make_with_text (a_list.item))
					a_list.forth
				end
				a_combo.select_actions.resume
				a_combo.set_text (a_list.first)
			end
		end

feature {NONE} -- Private Access

	internal_max_count: INTEGER_REF
			-- Cell storing value for `max_count'

	Default_max_combo_count: INTEGER = 10;
			-- Maximum combo entries

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
