indexing
	description: "CEIFFEL_COMPILER_COCLASS Implementation."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	CEIFFEL_COMPILER_COCLASS_IMP

inherit
	CEIFFEL_COMPILER_COCLASS

creation
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Creation. Implement if needed.
		do
			
		end

	make_from_pointer (cpp_obj: POINTER) is
			-- Creation.
		do
			set_item (cpp_obj)
			make
		end

feature -- Access

	is_successful: BOOLEAN is
			-- Was last compilation successful?
		do
			-- Put Implementation here.
		end

	freezing_occurred: BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		do
			-- Put Implementation here.
		end

	compiler_version: STRING is
			-- Compiler version.
		do
			-- Put Implementation here.
		end

	ise_eiffel: STRING is
			-- Return ISE_EIFFEL environment var.
		do
			-- Put Implementation here.
		end

	freeze_command_name: STRING is
			-- Eiffel Freeze command name
		do
			-- Put Implementation here.
		end

	freeze_command_arguments: STRING is
			-- Eiffel Freeze command arguments
		do
			-- Put Implementation here.
		end

	has_signable_generation: BOOLEAN is
			-- Is the compiler a trial version.
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

	compile is
			-- Compile.
		do
			-- Put Implementation here.
		end

	finalize is
			-- Finalize.
		do
			-- Put Implementation here.
		end

	precompile is
			-- Precompile.
		do
			-- Put Implementation here.
		end

	generate_msil_keyfile (filename: STRING) is
			-- Generate a cyrptographic key filename.
			-- `filename' [in].  
		do
			-- Put Implementation here.
		end

	remove_file_locks is
			-- Remove file locks
		do
			-- Put Implementation here.
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::CEiffelCompiler %"ecom_eiffel_compiler_CEiffelCompiler_s.h%"](EIF_OBJECT)"
		end

end -- CEIFFEL_COMPILER_COCLASS_IMP

