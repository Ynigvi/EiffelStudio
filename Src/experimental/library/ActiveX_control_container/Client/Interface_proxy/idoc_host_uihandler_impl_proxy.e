note
	description: "Implemented `IDocHostUIHandler' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IDOC_HOST_UIHANDLER_IMPL_PROXY

inherit
	IDOC_HOST_UIHANDLER_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_idoc_host_uihandler_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; ppt: TAG_POINT_RECORD; pcmdt_reserved: ECOM_INTERFACE; pdisp_reserved: ECOM_INTERFACE)
			-- No description available.
			-- `dw_id' [in].  
			-- `ppt' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		local
			pcmdt_reserved_item: POINTER
			a_stub: ECOM_STUB
			pdisp_reserved_item: POINTER
		do
			if pcmdt_reserved /= Void then
				if (pcmdt_reserved.item = default_pointer) then
					a_stub ?= pcmdt_reserved
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pcmdt_reserved_item := pcmdt_reserved.item
			end
			if pdisp_reserved /= Void then
				if (pdisp_reserved.item = default_pointer) then
					a_stub ?= pdisp_reserved
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pdisp_reserved_item := pdisp_reserved.item
			end
			ccom_show_context_menu (initializer, dw_id, ppt.item, pcmdt_reserved_item, pdisp_reserved_item)
		end

	get_host_info (p_info: X_DOCHOSTUIINFO_RECORD)
			-- No description available.
			-- `p_info' [in, out].  
		do
			ccom_get_host_info (initializer, p_info.item)
		end

	show_ui (dw_id: INTEGER; p_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE; p_command_target: IOLE_COMMAND_TARGET_INTERFACE; p_frame: IOLE_IN_PLACE_FRAME_INTERFACE; p_doc: IOLE_IN_PLACE_UIWINDOW_INTERFACE)
			-- No description available.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		local
			p_active_object_item: POINTER
			a_stub: ECOM_STUB
			p_command_target_item: POINTER
			p_frame_item: POINTER
			p_doc_item: POINTER
		do
			if p_active_object /= Void then
				if (p_active_object.item = default_pointer) then
					a_stub ?= p_active_object
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_active_object_item := p_active_object.item
			end
			if p_command_target /= Void then
				if (p_command_target.item = default_pointer) then
					a_stub ?= p_command_target
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_command_target_item := p_command_target.item
			end
			if p_frame /= Void then
				if (p_frame.item = default_pointer) then
					a_stub ?= p_frame
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_frame_item := p_frame.item
			end
			if p_doc /= Void then
				if (p_doc.item = default_pointer) then
					a_stub ?= p_doc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_doc_item := p_doc.item
			end
			ccom_show_ui (initializer, dw_id, p_active_object_item, p_command_target_item, p_frame_item, p_doc_item)
		end

	hide_ui
			-- No description available.
		do
			ccom_hide_ui (initializer)
		end

	update_ui
			-- No description available.
		do
			ccom_update_ui (initializer)
		end

	enable_modeless (f_enable: INTEGER)
			-- No description available.
			-- `f_enable' [in].  
		do
			ccom_enable_modeless (initializer, f_enable)
		end

	on_doc_window_activate (f_activate: INTEGER)
			-- No description available.
			-- `f_activate' [in].  
		do
			ccom_on_doc_window_activate (initializer, f_activate)
		end

	on_frame_window_activate (f_activate: INTEGER)
			-- No description available.
			-- `f_activate' [in].  
		do
			ccom_on_frame_window_activate (initializer, f_activate)
		end

	resize_border (prc_border: TAG_RECT_RECORD; p_uiwindow: IOLE_IN_PLACE_UIWINDOW_INTERFACE; f_rame_window: INTEGER)
			-- No description available.
			-- `prc_border' [in].  
			-- `p_uiwindow' [in].  
			-- `f_rame_window' [in].  
		local
			p_uiwindow_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_uiwindow /= Void then
				if (p_uiwindow.item = default_pointer) then
					a_stub ?= p_uiwindow
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_uiwindow_item := p_uiwindow.item
			end
			ccom_resize_border (initializer, prc_border.item, p_uiwindow_item, f_rame_window)
		end

	translate_accelerator (lpmsg: TAG_MSG_RECORD; pguid_cmd_group: ECOM_GUID; n_cmd_id: INTEGER)
			-- No description available.
			-- `lpmsg' [in].  
			-- `pguid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		do
			ccom_translate_accelerator (initializer, lpmsg.item, pguid_cmd_group.item, n_cmd_id)
		end

	get_option_key_path (pch_key: CELL [STRING]; dw: INTEGER)
			-- No description available.
			-- `pch_key' [out].  
			-- `dw' [in].  
		do
			ccom_get_option_key_path (initializer, pch_key, dw)
		end

	get_drop_target (p_drop_target: IDROP_TARGET_INTERFACE; pp_drop_target: CELL [IDROP_TARGET_INTERFACE])
			-- No description available.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		local
			p_drop_target_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_drop_target /= Void then
				if (p_drop_target.item = default_pointer) then
					a_stub ?= p_drop_target
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_drop_target_item := p_drop_target.item
			end
			ccom_get_drop_target (initializer, p_drop_target_item, pp_drop_target)
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE])
			-- No description available.
			-- `pp_dispatch' [out].  
		do
			ccom_get_external (initializer, pp_dispatch)
		end

	translate_url (dw_translate: INTEGER; pch_urlin: STRING; ppch_urlout: CELL [STRING])
			-- No description available.
			-- `dw_translate' [in].  
			-- `pch_urlin' [in].  
			-- `ppch_urlout' [out].  
		do
			ccom_translate_url (initializer, dw_translate, pch_urlin, ppch_urlout)
		end

	filter_data_object (p_do: IDATA_OBJECT_INTERFACE; pp_doret: CELL [IDATA_OBJECT_INTERFACE])
			-- No description available.
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		local
			p_do_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_do /= Void then
				if (p_do.item = default_pointer) then
					a_stub ?= p_do
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_do_item := p_do.item
			end
			ccom_filter_data_object (initializer, p_do_item, pp_doret)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_idoc_host_uihandler_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_show_context_menu (cpp_obj: POINTER; dw_id: INTEGER; ppt: POINTER; pcmdt_reserved: POINTER; pdisp_reserved: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER,ecom_control_library::tagPOINT *,IUnknown *,IDispatch *)"
		end

	ccom_get_host_info (cpp_obj: POINTER; p_info: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](ecom_control_library::_DOCHOSTUIINFO *)"
		end

	ccom_show_ui (cpp_obj: POINTER; dw_id: INTEGER; p_active_object: POINTER; p_command_target: POINTER; p_frame: POINTER; p_doc: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER,::IOleInPlaceActiveObject *,::IOleCommandTarget *,::IOleInPlaceFrame *,::IOleInPlaceUIWindow *)"
		end

	ccom_hide_ui (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"]()"
		end

	ccom_update_ui (cpp_obj: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"]()"
		end

	ccom_enable_modeless (cpp_obj: POINTER; f_enable: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_on_doc_window_activate (cpp_obj: POINTER; f_activate: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_on_frame_window_activate (cpp_obj: POINTER; f_activate: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_resize_border (cpp_obj: POINTER; prc_border: POINTER; p_uiwindow: POINTER; f_rame_window: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](ecom_control_library::tagRECT *,::IOleInPlaceUIWindow *,EIF_INTEGER)"
		end

	ccom_translate_accelerator (cpp_obj: POINTER; lpmsg: POINTER; pguid_cmd_group: POINTER; n_cmd_id: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](ecom_control_library::tagMSG *,GUID *,EIF_INTEGER)"
		end

	ccom_get_option_key_path (cpp_obj: POINTER; pch_key: CELL [STRING]; dw: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_get_drop_target (cpp_obj: POINTER; p_drop_target: POINTER; pp_drop_target: CELL [IDROP_TARGET_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](::IDropTarget *,EIF_OBJECT)"
		end

	ccom_get_external (cpp_obj: POINTER; pp_dispatch: CELL [ECOM_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_translate_url (cpp_obj: POINTER; dw_translate: INTEGER; pch_urlin: STRING; ppch_urlout: CELL [STRING])
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_filter_data_object (cpp_obj: POINTER; p_do: POINTER; pp_doret: CELL [IDATA_OBJECT_INTERFACE])
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](::IDataObject *,EIF_OBJECT)"
		end

	ccom_delete_idoc_host_uihandler_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"]()"
		end

	ccom_create_idoc_host_uihandler_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IDocHostUIHandler_impl_proxy %"ecom_control_library_IDocHostUIHandler_impl_proxy_s.h%"]():EIF_POINTER"
		end

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




end -- IDOC_HOST_UIHANDLER_IMPL_PROXY
