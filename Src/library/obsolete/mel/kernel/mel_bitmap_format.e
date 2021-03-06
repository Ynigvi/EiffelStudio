note

	description: 	
		"Implementation of the X bitmap format."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BITMAP_FORMAT

create

	make_from_file

feature {NONE} -- Initialization

	make_from_file (a_screen: MEL_SCREEN; filename: STRING)
			-- Retrieve the pixmap with file name `path'
			-- for `a_display'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid;
			filename_not_void: filename /= Void
		local
			path_ptr: ANY;
			identifier, display_handle: POINTER;
			a_height, a_width: INTEGER;
			x1, y1: INTEGER;
			a_status: INTEGER
		do
			path_ptr := filename.to_c;
			display_handle := a_screen.display.handle;
			identifier := x_read_bitmap_from_file 
					(a_screen.handle, $path_ptr, 
					$a_status, $a_width, $a_height, $x1, $y1);
			if identifier /= default_pointer then
				create bitmap.make_from_existing (a_screen.display, identifier, 1)
				width := a_width;
				height := a_height;
				x_hot := x1;
				y_hot := y1;
			end;
			status := a_status;
		end;

feature -- Access

	bitmap: MEL_PIXMAP
			-- One plane bitmap

	height: INTEGER;
			-- Height of `bitmap'

	width: INTEGER;
			-- Width of `bitmap'

	x_hot: INTEGER;
			-- Horizontal position of "hot" point

	y_hot: INTEGER;
			-- Vertical position of "hot" point

	is_valid: BOOLEAN
			-- Is Current `pixmap' valid?
		do
			Result := status = BitmapSuccess
		end;

	is_bitmap_file_invalid: BOOLEAN
			-- Was the filename used to retrieve the
			-- bitmap invalid?
		do
			Result := status = BitmapFileInvalid
		end;

	is_bitmap_no_memory: BOOLEAN
			-- Did the retrieval of the bitmap failed
			-- due to no memory?
		do
			Result := status = BitmapNoMemory
		end;

feature -- Transformation

	to_pixmap (a_screen: MEL_SCREEN; a_gc: MEL_GC): MEL_PIXMAP
			-- Convert bitmap to a pixmap using the default	
			-- depth of `a_screen' and values from `a_gc'
		require
			is_valid: is_valid	
		do
			create Result.make (a_screen, width, height,
					a_screen.default_depth);
			Result.copy_plane (bitmap, a_gc, 0, 0, width, height,
				0, 0, 1)
		end;

feature {NONE} -- Implementation

	status: INTEGER;
			-- Stored status from last attempt of
			-- retrieving a pixmap
			
feature {NONE} -- External features

	x_read_bitmap_from_file (a_screen: POINTER; fname: POINTER;
			a_status, a_width, a_height, x1, y1: POINTER): POINTER
		external
			"C"
		end;

	BitmapSuccess: INTEGER 
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapSuccess"
		end;

	BitmapFileInvalid: INTEGER
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapFileInvalid"
		end;

	BitmapNoMemory: INTEGER 
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"BitmapNoMemory"
		end;

invariant

	valid_bitmap: is_valid implies bitmap /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_BITMAP_FORMAT


