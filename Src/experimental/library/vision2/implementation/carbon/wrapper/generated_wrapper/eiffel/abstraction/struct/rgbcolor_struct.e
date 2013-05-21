-- This file has been generated by EWG. Do not edit. Changes will be lost!

class RGBCOLOR_STRUCT

inherit

	EWG_STRUCT

	RGBCOLOR_STRUCT_EXTERNAL
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

	red: INTEGER is
			-- Access member `red'
		require
			exists: exists
		do
			Result := get_red_external (item)
		ensure
			result_correct: Result = get_red_external (item)
		end

	set_red (a_value: INTEGER) is
			-- Set member `red'
		require
			exists: exists
		do
			set_red_external (item, a_value)
		ensure
			a_value_set: a_value = red
		end

	green: INTEGER is
			-- Access member `green'
		require
			exists: exists
		do
			Result := get_green_external (item)
		ensure
			result_correct: Result = get_green_external (item)
		end

	set_green (a_value: INTEGER) is
			-- Set member `green'
		require
			exists: exists
		do
			set_green_external (item, a_value)
		ensure
			a_value_set: a_value = green
		end

	blue: INTEGER is
			-- Access member `blue'
		require
			exists: exists
		do
			Result := get_blue_external (item)
		ensure
			result_correct: Result = get_blue_external (item)
		end

	set_blue (a_value: INTEGER) is
			-- Set member `blue'
		require
			exists: exists
		do
			set_blue_external (item, a_value)
		ensure
			a_value_set: a_value = blue
		end

end