-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- functions wrapper
class CFBASE_FUNCTIONS

obsolete
	"Use class CFBASE_FUNCTIONS_EXTERNAL instead."

inherit

	CFBASE_FUNCTIONS_EXTERNAL

feature
-- Ignoring cfrange_make since its return type is a composite type

	cfnull_get_type_id: INTEGER is
		local
		do
			Result := cfnull_get_type_id_external
		end

	cfallocator_get_type_id: INTEGER is
		local
		do
			Result := cfallocator_get_type_id_external
		end

	cfallocator_set_default (allocator: POINTER) is
		local
		do
			cfallocator_set_default_external (allocator)
		end

	cfallocator_get_default: POINTER is
		local
		do
			Result := cfallocator_get_default_external
		end

	cfallocator_create (allocator: POINTER; context: POINTER): POINTER is
		local
		do
			Result := cfallocator_create_external (allocator, context)
		end

	cfallocator_allocate (allocator: POINTER; size: INTEGER; hint: INTEGER): POINTER is
		local
		do
			Result := cfallocator_allocate_external (allocator, size, hint)
		end

	cfallocator_reallocate (allocator: POINTER; ptr: POINTER; newsize: INTEGER; hint: INTEGER): POINTER is
		local
		do
			Result := cfallocator_reallocate_external (allocator, ptr, newsize, hint)
		end

	cfallocator_deallocate (allocator: POINTER; ptr: POINTER) is
		local
		do
			cfallocator_deallocate_external (allocator, ptr)
		end

	cfallocator_get_preferred_size_for_size (allocator: POINTER; size: INTEGER; hint: INTEGER): INTEGER is
		local
		do
			Result := cfallocator_get_preferred_size_for_size_external (allocator, size, hint)
		end

	cfallocator_get_context (allocator: POINTER; context: POINTER) is
		local
		do
			cfallocator_get_context_external (allocator, context)
		end

	cfget_type_id (cf: POINTER): INTEGER is
		local
		do
			Result := cfget_type_id_external (cf)
		end

	cfcopy_type_iddescription (type_id: INTEGER): POINTER is
		local
		do
			Result := cfcopy_type_iddescription_external (type_id)
		end

	cfretain (cf: POINTER): POINTER is
		local
		do
			Result := cfretain_external (cf)
		end

	cfrelease (cf: POINTER) is
		local
		do
			cfrelease_external (cf)
		end

	cfget_retain_count (cf: POINTER): INTEGER is
		local
		do
			Result := cfget_retain_count_external (cf)
		end

	cfmake_collectable (cf: POINTER): POINTER is
		local
		do
			Result := cfmake_collectable_external (cf)
		end

	cfequal (cf1: POINTER; cf2: POINTER): INTEGER is
		local
		do
			Result := cfequal_external (cf1, cf2)
		end

	cfhash (cf: POINTER): INTEGER is
		local
		do
			Result := cfhash_external (cf)
		end

	cfcopy_description (cf: POINTER): POINTER is
		local
		do
			Result := cfcopy_description_external (cf)
		end

	cfget_allocator (cf: POINTER): POINTER is
		local
		do
			Result := cfget_allocator_external (cf)
		end

end