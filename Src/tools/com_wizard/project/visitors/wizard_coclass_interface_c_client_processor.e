note
	description: "Processing interfaces for C client coclass."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR

inherit
	WIZARD_COCLASS_INTERFACE_C_PROCESSOR

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		rename
			coclass as Dictionary_coclass
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	generate_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR)
			-- Generate interface features.
		local
			l_name, l_type: STRING
			l_member: WIZARD_WRITER_C_MEMBER
			l_writer: WIZARD_WRITER_CPP_CLASS
		do
			if a_interface.is_implementing_coclass (coclass) and
					not a_interface.is_iunknown and not a_interface.is_idispatch then
				l_writer := coclass_generator.cpp_class_writer
				l_writer.add_import (a_interface.c_definition_header_file_name)
				l_writer.add_other_source (iid_definition (a_interface.name, a_interface.guid))

				create l_member.make
				l_member.set_comment (Interface_pointer_comment)
				l_member.set_name (variable_name (a_interface.c_type_name))

				create l_type.make (100)
				if a_interface.namespace /= Void and then not a_interface.namespace.is_empty then
					l_type.append (a_interface.namespace)
					l_type.append ("::")
				end
				l_type.append (a_interface.c_type_name)
				l_type.append (" *")
				l_member.set_result_type (l_type)

				l_writer.add_member (l_member, Private)

				l_name := a_interface.c_type_name
				coclass_generator.interface_names.extend (l_name)

				dispatch_interface := a_interface.dispinterface or a_interface.dual

				C_client_generator.initialize (coclass, a_interface, l_writer)
				C_client_generator.generate_functions_and_properties (a_interface)
			end
		end

	generate_source_interface_features (a_interface: WIZARD_INTERFACE_DESCRIPTOR)
			-- Generate source interface features.
		local
			c_server_visitor: WIZARD_C_SERVER_VISITOR
			source_generator: WIZARD_SOURCE_INTERFACE_C_CLIENT_GENERATOR
		do
			create c_server_visitor
			c_server_visitor.visit (a_interface.implemented_interface)
			create source_generator.generate (a_interface, coclass_generator.cpp_class_writer)
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
end -- class WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR


