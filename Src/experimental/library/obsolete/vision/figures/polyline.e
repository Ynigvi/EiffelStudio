note

	description: "Sequences of continuous segments"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	POLYLINE

inherit

	ENDED
		undefine
			copy, is_equal
		end

	PATH
		rename
			make as path_make
		undefine
			copy, is_equal
		end;
	
	OPEN_FIG	
		undefine
			copy, is_equal
		redefine
			translate,
			set_origin,
			set_no_origin,
			self_scale,
			self_rotate,	
			scale,
			rotate,
			clip_draw,
			conf_recompute,
			attach_drawing
		end;

	LINKED_LIST [POINT]
		rename
			extend as list_add,
			put_left as list_put_left,
			put_right as list_put_right,
			duplicate as list_duplicate,
			merge_left as list_merge_left,
			merge_right as list_merge_right,
			put as list_put,
			put_i_th as list_put_i_th,
			make as linked_list_make,
			wipe_out as linked_list_wipe_out
		end;

	LINKED_LIST [POINT]
		rename
			make as linked_list_make,
			extend as add
		redefine
			put_right, 
			put_left, 
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			add,
			wipe_out
		select
			put_right, 
			put_left, 
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			add,
			wipe_out
		end

create

	make 


feature -- Initialization	 

	make
			-- Create a world as a figure with f as a figure 
			-- for visual modification notification
		do
			init_fig (Void);
			path_make ;
			create changes_box.make;
			create surround_box.make;
			linked_list_make;
			create origin;
		ensure
			is_empty
		end;

feature -- Access

	origin: COORD_XY_FIG;
			-- Origin of the world

feature -- Duplication

	duplicate (n: INTEGER): like Current
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off;
			valid_sublist: n >= 0
		do
			Result := list_duplicate (n);
			Result.attach_drawing_imp (drawing);
			Result.set_origin (origin)
		end;

feature  -- Element change

	add (v: like first)
			-- Append `v' to list.
		do
			v.attach_drawing_imp (drawing);
			list_add (v);
			set_conf_modified
		end;

	put_left (v: like first)
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing_imp (drawing);
			list_put_left (v);
			set_conf_modified
		end;

	put_right (v: like first)
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing_imp (drawing);
			list_put_right (v);
			set_conf_modified
		end;

	attach_drawing (a_drawing: DRAWING)
			-- Attach a drawing to the figure.
		local
			keep_cursor: CURSOR;
		do
			drawing := a_drawing.implementation;
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.attach_drawing_imp (drawing);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified_with (surround_box)
		end;

	merge_left (other: like Current)
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		do
			from
				other.start
			until
				other.off
			loop
				other.attach_drawing_imp (drawing);
				other.forth
			end;
			list_merge_left (other);
			set_conf_modified
		end;

	merge_right (other: like Current)
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		do
			from
				other.start
			until
				other.off
			loop
				other.attach_drawing_imp (drawing);
				other.forth
			end;
			list_merge_right (other);
			set_conf_modified
		end;

	put (v: like first)
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		do
			v.attach_drawing_imp (drawing);
			list_put (v);
			set_conf_modified
		end;

	put_i_th (v: like first; i: INTEGER)
			-- Put item `v' at `i'-th position.
		do
			v.attach_drawing_imp (drawing);
			list_put_i_th (v, i);
			set_conf_modified
		end;

	rotate (a: REAL; p: like origin)
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0;
			point_exists: p /= Void
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.rotate (a, p);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	scale (f: REAL; p: like origin)
			-- Scale figure by `f' relative to `p'.
		require else
			scale_factor_positive: f > 0.0;
			point_exists: p /= Void
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.scale (f, p);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	self_rotate (a: REAL)
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0;
			origin_exists: origin /= Void
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.rotate (a, origin);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	self_scale (f: REAL)
			-- Scale figure by `f' relative to `origin'.
		require else
			scale_factor_positive: f > 0.0;
			origin_exists: origin /= Void
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.scale (f, origin);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;


	set_origin (p: like origin)
			-- Set `origin' to `p'.
		require else
			p_exists: p /= Void
		do
			origin := p
		ensure then
			origin_set: origin = p
		end;

	translate (v: VECTOR)
			-- Translate current figure by `v'.
		require else
			vector_exists: v /= Void
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.translate (v);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	xyrotate (a: REAL; px, py: INTEGER)
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER)
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified	
		end;

	xytranslate (vx, vy: INTEGER)
			-- Translate by `vx' horizontally and `vy' vertically.
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

feature -- Removal

	wipe_out
		do
			linked_list_wipe_out;
			set_conf_modified
		end;

feature -- Output
			
	draw
			-- Draw the figure in `drawing'.
		require else
			a_drawing_attached: drawing /= Void;
			one_segment_at_least: count > 1
		local
			p1, p2: POINT;
			keep_cursor: CURSOR;
		do
			if drawing.is_drawable then
				drawing.set_cap_style (cap_style);
				set_drawing_attributes (drawing);
				keep_cursor := cursor;
				from
					start;
					p1 := item;
					forth;
					p2 := item
				until
					off
				loop
					drawing.draw_segment (p1, p2);
					p1 := p2;
					forth;
					if not off then
							p2 := item
					end
				end;
				go_to (keep_cursor)
			end
		end;

	clip_draw (clip: CLIP)
		do
			if conf_receive then
				if conf_modified then
					conf_recompute
				end
			else
				conf_recompute
			end;
			if drawing.is_drawable then
				draw
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN
			-- Is the figure superimposable to `other' ?
		local
			keep_cursor: CURSOR;
			other_keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			keep_cursor := other.cursor;
			from
				start;
				other.start;
				Result := true;
			until
				not Result or off or other.off
			loop
				Result := Result and item.is_superimposable (other.item);
				forth;
				other.forth;
			end;
			Result := Result and off and other.off;
			go_to (keep_cursor);
			other.go_to (other_keep_cursor)
		end;

feature {NONE} -- Element change

	set_no_origin
			-- Erase definition of `origin'.
		do
			origin := Void
		ensure then
			no_origin: origin = Void
		end;

feature {NONE} -- Updating

	conf_recompute
		local
			keep_cursor: CURSOR;
		do
			from
				keep_cursor := cursor;
				start;
				surround_box.wipe_out;
			until
				off
			loop
				item.conf_recompute;
				surround_box.merge (item.surround_box);
				forth;
			end;
			go_to (keep_cursor);
			unset_conf_modified
		end;
		
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




end -- class POLYLINE

