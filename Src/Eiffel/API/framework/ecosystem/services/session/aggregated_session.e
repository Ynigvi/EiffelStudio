note
	description: "[
		A session to aggregate another session, providing read access to the wrapped session's data values and write access to only the current session.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	AGGREGATED_SESSION

inherit
	SESSION
		rename
			make as make_session,
			make_per_window as make_per_window_session
		redefine
			safe_dispose,
			has,
			value,
			value_or_default,
			store
		end

create
	make,
	make_per_window

feature {NONE} -- Initialization

	make (a_per_project: BOOLEAN; a_manager: like manager; a_session: like inner_session)
			-- Initialize a global session
			--
			-- `a_per_project': True to initialize a per-project session.
			-- `a_manager': Session manager that owns Current.
			-- `a_session': An inner session that Current aggregates.
		require
			a_manager_attached: attached a_manager
			a_manager_is_interface_usable: a_manager.is_interface_usable
			a_session_attached: attached a_session
			a_session_is_interface_usable: a_session.is_interface_usable
		do
			make_session (a_per_project, a_manager)
			set_inner_session (a_session)
		ensure
			is_per_project_set: is_per_project = a_per_project
			manager_set: manager = a_manager
			inner_session_set: inner_session = a_session
		end

	make_per_window (a_per_project: BOOLEAN; a_window: SHELL_WINDOW_I; a_manager: like manager; a_session: like inner_session)
			-- Initialize a session bound to a window.
			--
			-- `a_per_project': True to initialize a per-project session.
			-- `a_window': Window to initialize a per-window session for.
			-- `a_manager': Session manager that owns Current.
			-- `a_session': An inner session that Current aggregates.
		require -- from SESSION
			a_window_attached: attached a_window
			a_window_is_interface_usable: a_window.is_interface_usable
			a_manager_attached: attached a_manager
			a_manager_is_interface_usable: a_manager.is_interface_usable
			a_session_attached: attached a_session
			a_session_is_interface_usable: a_session.is_interface_usable
		do
			make_per_window_session (a_per_project, a_window, a_manager)
			set_inner_session (a_session)
		ensure
			is_per_project_set: is_per_project = a_per_project
			is_per_window: is_per_window
			manager_set: manager = a_manager
			inner_session_set: inner_session = a_session
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		do
			if a_disposing then
				set_inner_session (Void)
			end
			Precursor (a_disposing)
		ensure then
			inner_session_detached: inner_session = Void
		end

feature {SESSION_MANAGER_S} -- Access

	inner_session: detachable SESSION_I assign set_inner_session
			-- Inner session object

feature {SESSION_MANAGER_S} -- Element change

	set_inner_session (a_session: like inner_session)
			-- <Precursor>
		require
			is_interface_usable: is_interface_usable
			a_session_is_interface_usable: attached a_session implies a_session.is_interface_usable
		do
			if attached inner_session as l_inner and then l_inner.is_interface_usable then
					-- remove old event handler
				l_inner.value_changed_event.unsubscribe (agent on_inner_session_value_changed)
			end

				-- Set extension name
			if attached a_session then
				set_extension_name (a_session.extension_name)
			else
				set_extension_name (Void)
			end

			inner_session := a_session
			if attached a_session then
					-- Set event handler for propagating value changed events
				a_session.value_changed_event.subscribe (agent on_inner_session_value_changed)
			end
		ensure
			inner_session_set: inner_session = a_session
			extension_name_set: (attached a_session and then extension_name ~ a_session.extension_name) or else
				(not attached a_session and then not attached extension_name)
		end

feature -- Query

	value alias "[]" (a_id: READABLE_STRING_GENERAL): detachable ANY assign set_value
			-- <Precursor>
		do
			if data.has (a_id.as_string_32) then
				Result := Precursor {SESSION} (a_id)
			else
				Result := inner_session.value (a_id)
			end
		end

	value_or_default (a_id: READABLE_STRING_GENERAL; a_default_value: ANY): ANY
			-- <Precursor>
		do
			if data.has (a_id.as_string_32) then
				Result := Precursor {SESSION} (a_id, a_default_value)
			else
				Result := inner_session.value_or_default (a_id, a_default_value)
			end
		end

feature -- Status report

	has (a_id: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_id) or else inner_session.has (a_id)
		end

feature -- Basic operations

	store
			-- <Precursor>
		do
			if is_dirty then
				Precursor
				if attached inner_session as l_session then
					l_session.store
				end
			end
		end

feature {NONE} -- Event handlers

	on_inner_session_value_changed (a_session: SESSION; a_id: STRING_32)
			-- <Precursor>
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			if not data.has (a_id) then
					-- There is no local version of data `a_id', so we have to propagated the event
					-- to the aggregate client.
				value_changed_event.publish ([Current, a_id])
			end
		end

invariant
	extension_name_set: not (is_actively_disposing or is_disposed) implies (attached inner_session as l_session and then extension_name ~ l_session.extension_name)

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
