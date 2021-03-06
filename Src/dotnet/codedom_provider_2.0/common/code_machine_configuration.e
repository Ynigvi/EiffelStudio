note
	description: "Machine configuration file manipulation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_MACHINE_CONFIGURATION

inherit
	CODE_SHARED_EVENT_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Load configuration file and initialize attributes accordingly.
		local
			l_retried: BOOLEAN
			l_codedom_node: XML_XML_NODE
			l_res: SYSTEM_OBJECT
		do
			if not l_retried then
				create machine_config.make
				machine_config.load_string (Machine_config_path)
				compilers_node := machine_config.get_elements_by_tag_name ("compilers").item (0)
				if compilers_node = Void then
					l_codedom_node := machine_config.get_elements_by_tag_name ("system.codedom").item (0)
					if l_codedom_node = Void then
						l_codedom_node := machine_config.create_element ("system.codedom")
					end
					compilers_node := machine_config.create_element ("compilers")
					l_res := l_codedom_node.append_child (compilers_node)
				end
				initialized := True
			end
		ensure
			non_void_config: machine_config /= Void
			non_void_compilers_node_if_initialized: initialized implies compilers_node /= Void
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
		
feature -- Access

	initialized: BOOLEAN
			-- Was machine configuration correctly loaded?

	language_provider (a_language: STRING): STRING
			-- Language provider type fully qualified name for `a_language' if any
		local
			l_node: XML_XML_NODE
		do
			l_node := language_node (a_language)
			if l_node /= Void then
				Result := l_node.attributes.item (2).value
			end
		end
		
	language_extension (a_language: STRING): STRING
			-- Language file extension for `a_language' if any
		local
			l_node: XML_XML_NODE
		do
			l_node := language_node (a_language)
			if l_node /= Void then
				Result := l_node.attributes.item (1).value
			end
		end
	
	languages: LIST [STRING]
			-- List of languages in configuration file
		local
			l_compilers: XML_XML_NODE_LIST
			i, l_count: INTEGER
		do
			l_compilers := compilers_node.child_nodes
			from
				l_count := l_compilers.count
				create {ARRAYED_LIST [STRING]} Result.make (l_count)
			until
				i = l_count
			loop
				Result.extend (l_compilers.item (i).attributes.item (0).value.split (<<';'>>).item (0))
				i := i + 1
			end
			Result.compare_objects
		ensure
			non_void_languages: Result /= Void
			compare_objects: Result.object_comparison
		end
		
feature -- Basic Operations

	add_compiler_entry (a_language, a_extension, a_provider: STRING)
			-- Add provider `a_provider' associated with language `a_language'
			-- and file extension `a_extension' to list of codedom providers.
		require
			non_void_language: a_language /= Void
			valid_language: not a_language.is_empty
			non_void_extension: a_extension /= Void
			valid_extension: not a_extension.is_empty
			non_void_provider: a_provider /= Void
			valid_provider: not a_provider.is_empty
		local
			l_node: XML_XML_NODE
			l_res: SYSTEM_OBJECT
			l_attr: XML_XML_ATTRIBUTE
		do
			remove_compiler_entry (a_language)
			l_node := machine_config.create_element ("compiler")
			l_attr := machine_config.create_attribute ("language")
			l_attr.set_value (a_language)
			l_attr := l_node.attributes.append (l_attr)
			l_attr := machine_config.create_attribute ("extension")
			l_attr.set_value (a_extension)
			l_attr := l_node.attributes.append (l_attr)
			l_attr := machine_config.create_attribute ("type")
			l_attr.set_value (a_provider)
			l_attr := l_node.attributes.append (l_attr)
			l_res := compilers_node.append_child (l_node)
			machine_config.save_string (Machine_config_path)
		end
		
	remove_compiler_entry (a_language: STRING)
			-- Remove `a_language' codedom provider from list if present
			-- otherwise do nothing.
		local
			l_node: XML_XML_NODE
			l_res: SYSTEM_OBJECT
		do
			l_node := language_node (a_language)
			if l_node /= Void then
				l_res := compilers_node.remove_child (l_node)
				machine_config.save_string (Machine_config_path)
			end
		end

feature {NONE} -- Implementation
	
	compilers_node: XML_XML_NODE
			-- CodeDom compilers node in config file "machine.config"

	machine_config: SYSTEM_DLL_CONFIG_XML_DOCUMENT
			-- Machine configuration file content

	Machine_config_path: STRING
			-- Path to "machine.config" configuration file
		once
			Result := {RUNTIME_ENVIRONMENT}.get_runtime_directory 
			Result.append ("\CONFIG\machine.config")
		end

	language_node (a_language: STRING): XML_XML_NODE
			-- XML node in machine configuration file corresponding to language `a_language' if any
		local
			l_compilers: XML_XML_NODE_LIST
			i, l_count: INTEGER
			l_found: BOOLEAN
			l_synonyms: SYSTEM_ARRAY
		do
			if compilers_node /= Void then
				l_compilers := compilers_node.child_nodes
				from
					i := 0
					l_count := l_compilers.count
				until
					i >= l_count or l_found
				loop
					l_synonyms := l_compilers.item (i).attributes.item (0).value.split (<<';'>>)
					{SYSTEM_ARRAY}.sort (l_synonyms)
 					l_found := {SYSTEM_ARRAY}.binary_search (l_synonyms, a_language.to_cil) >= 0
 					i := i + 1
				end
				if l_found then
					Result := l_compilers.item (i - 1)
				end
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
end -- class CODE_MACHINE_CONFIGURATION

