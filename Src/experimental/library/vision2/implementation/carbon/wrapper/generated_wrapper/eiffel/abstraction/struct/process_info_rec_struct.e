-- This file has been generated by EWG. Do not edit. Changes will be lost!

class PROCESS_INFO_REC_STRUCT

inherit

	EWG_STRUCT

	PROCESS_INFO_REC_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	processinfolength: INTEGER is
			-- Access member `processInfoLength'
		require
			exists: exists
		do
			Result := get_processinfolength_external (item)
		ensure
			result_correct: Result = get_processinfolength_external (item)
		end

	set_processinfolength (a_value: INTEGER) is
			-- Set member `processInfoLength'
		require
			exists: exists
		do
			set_processinfolength_external (item, a_value)
		ensure
			a_value_set: a_value = processinfolength
		end

	processname: POINTER is
			-- Access member `processName'
		require
			exists: exists
		do
			Result := get_processname_external (item)
		ensure
			result_correct: Result = get_processname_external (item)
		end

	set_processname (a_value: POINTER) is
			-- Set member `processName'
		require
			exists: exists
		do
			set_processname_external (item, a_value)
		ensure
			a_value_set: a_value = processname
		end

	processnumber: POINTER is
			-- Access member `processNumber'
		require
			exists: exists
		do
			Result := get_processnumber_external (item)
		ensure
			result_correct: Result = get_processnumber_external (item)
		end

	set_processnumber (a_value: POINTER) is
			-- Set member `processNumber'
		require
			exists: exists
		do
			set_processnumber_external (item, a_value)
		end

	processtype: INTEGER is
			-- Access member `processType'
		require
			exists: exists
		do
			Result := get_processtype_external (item)
		ensure
			result_correct: Result = get_processtype_external (item)
		end

	set_processtype (a_value: INTEGER) is
			-- Set member `processType'
		require
			exists: exists
		do
			set_processtype_external (item, a_value)
		ensure
			a_value_set: a_value = processtype
		end

	processsignature: INTEGER is
			-- Access member `processSignature'
		require
			exists: exists
		do
			Result := get_processsignature_external (item)
		ensure
			result_correct: Result = get_processsignature_external (item)
		end

	set_processsignature (a_value: INTEGER) is
			-- Set member `processSignature'
		require
			exists: exists
		do
			set_processsignature_external (item, a_value)
		ensure
			a_value_set: a_value = processsignature
		end

	processmode: INTEGER is
			-- Access member `processMode'
		require
			exists: exists
		do
			Result := get_processmode_external (item)
		ensure
			result_correct: Result = get_processmode_external (item)
		end

	set_processmode (a_value: INTEGER) is
			-- Set member `processMode'
		require
			exists: exists
		do
			set_processmode_external (item, a_value)
		ensure
			a_value_set: a_value = processmode
		end

	processlocation: POINTER is
			-- Access member `processLocation'
		require
			exists: exists
		do
			Result := get_processlocation_external (item)
		ensure
			result_correct: Result = get_processlocation_external (item)
		end

	set_processlocation (a_value: POINTER) is
			-- Set member `processLocation'
		require
			exists: exists
		do
			set_processlocation_external (item, a_value)
		ensure
			a_value_set: a_value = processlocation
		end

	processsize: INTEGER is
			-- Access member `processSize'
		require
			exists: exists
		do
			Result := get_processsize_external (item)
		ensure
			result_correct: Result = get_processsize_external (item)
		end

	set_processsize (a_value: INTEGER) is
			-- Set member `processSize'
		require
			exists: exists
		do
			set_processsize_external (item, a_value)
		ensure
			a_value_set: a_value = processsize
		end

	processfreemem: INTEGER is
			-- Access member `processFreeMem'
		require
			exists: exists
		do
			Result := get_processfreemem_external (item)
		ensure
			result_correct: Result = get_processfreemem_external (item)
		end

	set_processfreemem (a_value: INTEGER) is
			-- Set member `processFreeMem'
		require
			exists: exists
		do
			set_processfreemem_external (item, a_value)
		ensure
			a_value_set: a_value = processfreemem
		end

	processlauncher: POINTER is
			-- Access member `processLauncher'
		require
			exists: exists
		do
			Result := get_processlauncher_external (item)
		ensure
			result_correct: Result = get_processlauncher_external (item)
		end

	set_processlauncher (a_value: POINTER) is
			-- Set member `processLauncher'
		require
			exists: exists
		do
			set_processlauncher_external (item, a_value)
		end

	processlaunchdate: INTEGER is
			-- Access member `processLaunchDate'
		require
			exists: exists
		do
			Result := get_processlaunchdate_external (item)
		ensure
			result_correct: Result = get_processlaunchdate_external (item)
		end

	set_processlaunchdate (a_value: INTEGER) is
			-- Set member `processLaunchDate'
		require
			exists: exists
		do
			set_processlaunchdate_external (item, a_value)
		ensure
			a_value_set: a_value = processlaunchdate
		end

	processactivetime: INTEGER is
			-- Access member `processActiveTime'
		require
			exists: exists
		do
			Result := get_processactivetime_external (item)
		ensure
			result_correct: Result = get_processactivetime_external (item)
		end

	set_processactivetime (a_value: INTEGER) is
			-- Set member `processActiveTime'
		require
			exists: exists
		do
			set_processactivetime_external (item, a_value)
		ensure
			a_value_set: a_value = processactivetime
		end

	processappspec_struct: FSSPEC_STRUCT is
			-- Access member `processAppSpec'
		require
			exists: exists
		do
			create Result.make_shared (get_processappspec_external (item))
		ensure
			result_not_void: Result /= Void
			result_has_correct_item: Result.item = processappspec
		end

	set_processappspec_struct (a_value: FSSPEC_STRUCT) is
			-- Set member `processAppSpec'
		require
			a_value_not_void: a_value /= Void
			exists: exists
		do
			set_processappspec_external (item, a_value.item)
		ensure
			a_value_set: a_value.item = processappspec
		end

	processappspec: POINTER is
			-- Access member `processAppSpec'
		require
			exists: exists
		do
			Result := get_processappspec_external (item)
		ensure
			result_correct: Result = get_processappspec_external (item)
		end

	set_processappspec (a_value: POINTER) is
			-- Set member `processAppSpec'
		require
			exists: exists
		do
			set_processappspec_external (item, a_value)
		ensure
			a_value_set: a_value = processappspec
		end

end