class EV_GTK_EXTERNALS

feature {NONE} -- GTK macros for casting types
	
	gtk_object (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_OBJECT"
		end
	
	gtk_editable (widget: POINTER): POINTER is
		external 
			"C [macro <gtk/gtk.h>]"
		alias
			"GTK_EDITABLE"
		end
	
	
feature {NONE} -- GTK C functions

	-- window
	gtk_window_new (opt: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_window_set_title (widget: POINTER; t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_window_set_policy (w:POINTER; allow_shrink, allow_grow, auto_shrink: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	--scrolled window
	gtk_scrolled_window_new (hadj, vadj: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_scrolled_window_set_policy (w: POINTER; h, v: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	-- widget
	gtk_widget_show (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_hide (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_widget_realize (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end	
	
	gtk_widget_unrealize (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end	
	
	gtk_widget_set_sensitive (w: POINTER; sensitive: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_set_usize (widget: POINTER; w,h: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_set_uposition (widget: POINTER; x,y: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_grab_default (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_destroy (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_reparent (w: POINTER; p: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	-- general
	gtk_set_locale is
		external "C | <gtk/gtk.h>"
		end

	gtk_rc_parse (f: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_main is
		external "C | <gtk/gtk.h>"
		end

	gtk_main_quit is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_signal_handlers_destroy (widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_signal_disconnect (widget: POINTER; id: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	-- button
	gtk_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- toggle button
	gtk_toggle_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_toggle_button_set_state (button: POINTER; state: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_toggle_button_toggled (button: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toggle_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- check button
	gtk_check_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- radio button
	gtk_radio_button_new (gp: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_button_new_with_label (gp: POINTER; label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_button_group (gp: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- container
	gtk_container_add (container, widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_container_border_width (container: POINTER; width: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_hseparator_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_vseparator_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
		
	gtk_fixed_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_dialog_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_tooltips_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_tooltips_set_tip (tooltips, widget, tip, tip_private: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tooltips_enable (tooltips: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tooltips_disable (tooltips: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_tooltips_set_delay (delay: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_label_new (l: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_menu_item_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	

	gtk_label_set (l: POINTER; text: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_label_get (l: POINTER; text: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_exit (n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	 gtk_table_new (rows, columns: INTEGER; homogenous: BOOLEAN): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_set_col_spacings (t: POINTER; n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_set_row_spacings (t: POINTER; n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_attach (table, widget: POINTER; lef, right, top, bottom,
					  x_opt, y_opt, x_pad, y_pad: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_new (o, s: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_append_space (t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_orientation (t: POINTER; o: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_style (t: POINTER; style: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_space_size (t: POINTER; sz: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toolbar_set_tooltips (t: POINTER; fl: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
			
	--gtkbox
	
	gtk_hbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_vbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end
		
	gtk_box_pack_start (box, widget: POINTER; e, f: BOOLEAN; p: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_box_set_homogeneous (box: POINTER; homogeneous: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_box_set_spacing (box: POINTER; spacing: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	
	-- gtkframe
	gtk_frame_new (l: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- gtkeditable
	gtk_editable_insert_text (widget, text: POINTER; text_length, position: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_editable_delete_text (widget: POINTER; start_pos, end_pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_editable_get_chars (widget: POINTER; start_pos, end_pos: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	-- gtkentry
	gtk_entry_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_new_with_max_length (len: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_set_editable (e: POINTER; f: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_set_text (e: POINTER; t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_append_text (e: POINTER; t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_prepend_text (e: POINTER; t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_get_text (e: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_entry_set_max_length (e: POINTER; max: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_entry_select_region (e: POINTER; start_pos, end_pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_entry_set_position (e: POINTER; pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	-- gtktext
	gtk_text_new (hadj, vajd: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
		
	gtk_text_set_word_wrap (text: POINTER; word_wrap: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_text_set_editable (text: POINTER; editable: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_text_set_point (text: POINTER; pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_text_get_point (text: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_text_get_length (text: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_text_insert (text, font, fore_color, back_color, txt: POINTER; len: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	

	--notebook
	gtk_notebook_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_tab_pos (notebook: POINTER; pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_append_page (notebook, child, label: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_page (notebook: POINTER; page: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library


	c_gtk_init_toolkit is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_signal_connect (widget: POINTER; event: POINTER; 
			      routine: POINTER; object: POINTER; 
			      arguments: POINTER; 
			      set_event_data_rtn: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end

	-- widget
	c_gtk_widget_destroyed (widget: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_pixmap_create_from_xpm (parent: POINTER; fname: POINTER): POINTER is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_flags (w: POINTER; flags: INTEGER) is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_realized (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end	
	
	c_gtk_widget_visible (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_height (w: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_width (w: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_sensitive (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_set_size (w: POINTER; width, height: INTEGER) is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_minimum_width (w: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end
	c_gtk_widget_minimum_height (w: POINTER): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_free_call_back_block (p: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_toolbar_append_item (t: POINTER; text, tip, private_tip,
							   icon: POINTER; func: POINTER;
							   object: ANY; p: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end
	
	-- message_d
	c_gtk_create_message_d_buttons (dialog, ok_button,
					cancel_button, 
					help_button: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_create_message_d_label (dialog, label: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end
	
	
--XX	c_gtk_create_button_with_label (label_widget, label_text: POINTER): POINTER is
			-- out: label_widget pointer to buttons label widget
			-- in: label_text  text of label
--		external "C"
	--		end
	
	-- push_b
	c_gtk_get_label_widget (button: POINTER): POINTER is
		external "C | %"gtk_eiffel.h%""
		end
	
	-- toggle button
	c_gtk_toggle_button_active (button: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end

	-- text
	c_gtk_get_text_length (text: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end
	
	-- text
	c_gtk_get_text_max_length (text: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end	
	
	-- containers
	c_gtk_widget_show_children (widget: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end
	
feature {NONE} -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end
end
