indexing
	description:
		"Graphical picture stored as a two dimensional map of pixels.%N%
		%Can be modified and displayed."
	status: "See notice at end of class"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation,
			is_equal,
			copy
		end

	EV_PRIMITIVE
		undefine
			set_background_color,
			background_color,
			set_foreground_color,
			foreground_color,
			is_equal,
			is_in_default_state,
			copy
		redefine
			implementation
		end

	EV_PIXMAP_ACTION_SEQUENCES
		undefine
			is_equal,
			copy
		redefine
			implementation
		end
		
create
	default_create,
	make_with_size

feature {NONE} -- Initialization

	make_with_size (a_width, a_height: INTEGER) is
			-- Create with `a_width' and `a_height'.
		require
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			default_create
			set_size (a_width, a_height)
		ensure then
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Basic Operations

	flush is
			-- Ensure that the appearence of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		require	
			not_destroyed: not is_destroyed
		do
			implementation.flush
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same appearance as `Current'.
		do
			if other /= Void then
					-- Images are proportional.
				Result := (
					width * other.height = other.width * height
				)
			end
		end

feature -- Status setting

	set_with_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknown_image_format' or `Ev_corrupt_image_data'
			-- exceptions.
			-- See `supported_image_formats' in EV_ENVIRONMENT for valid file formats.
		require
			not_destroyed: not is_destroyed
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
		do
			implementation.read_from_named_file(file_name)
		end

	set_size (a_width, a_height: INTEGER) is
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Do not stretch image.
			-- May cause cropping.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.set_size (a_width, a_height)	
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

	stretch (a_width, a_height: INTEGER) is
			-- Assign `a_width' and `a_height' to `width' and `weight'.
			-- Stretch the image to new size.
		require
			not_destroyed: not is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		do
			implementation.stretch (a_width, a_height)
		ensure
			width_assigned: width = a_width
			height_assigned: height = a_height
		end

feature -- Duplication

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in format `a_format'.
		require
			not_destroyed: not is_destroyed
			a_format_not_void: a_format /= Void
			a_filename_not_void: a_filename /= Void
		do
			implementation.save_to_named_file (a_format, a_filename)
		end

	copy (other: like Current) is 
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			if implementation = Void then
				default_create
			end
			implementation.copy_pixmap (other)
		end

feature {EV_ANY_I, EV_IMAGE_LIST_IMP, EV_STOCK_PIXMAPS_IMP, EV_FIGURE_POSTSCRIPT_DRAWER, ANY} -- Implementation

	implementation: EV_PIXMAP_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PIXMAP_IMP} implementation.make (Current)
		end
		
end -- class EV_PIXMAP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

