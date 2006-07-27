indexing
	description: "Object that represents a criterion row in basic metric definition panel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_ROW

inherit
	EB_GRID_ROW

	QL_SHARED_NAMES

	EB_CONSTANTS

	QL_SHARED

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_criterion: like criterion; a_row: EV_GRID_ROW; a_grid: like grid; a_readonly: BOOLEAN; a_scope: like scope) is
			-- Initialize.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
			a_grid_attached: a_grid /= Void
			a_scope_attached: a_scope /= Void
		do
			grid := a_grid
			is_read_only := a_readonly
			scope := a_scope
			create {LINKED_LIST [EB_METRIC_CRITERION_ROW]} subrows.make
			resize_grid_agent := agent resize_grid
			property_item_deactivated_agent := agent on_property_item_deactivated
			if a_criterion /= Void then
				criterion_name := a_criterion.name.twin
				is_negation_used := a_criterion.is_negation_used
				if is_valid_row then
					load_valid_criterion_row (a_criterion, a_row, Void)
				else
					load_invalid_criterion_row (a_row)
				end
			else
				criterion_name := ""
				load_empty_row (a_row)
			end
		ensure
			grid_set: grid = a_grid
			is_read_only_set: is_read_only = a_readonly
		end

feature -- Loading

	load_empty_row (a_row: EV_GRID_ROW) is
			-- Load an empty row in `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		do
			is_in_default_state := True
			initialize_row (a_row)
			create {EV_GRID_LABEL_ITEM} property_item
			bind (a_row)
		end

	load_valid_criterion_row (a_criterion: like criterion; a_row: EV_GRID_ROW; a_original_criterion: like criterion) is
			-- Load `a_criterion' in `a_row'.
			-- `a_original_criterion' is the original criterion defined in the same row. This is introduced to maintain some context
			-- information when we change between same type of criteria.
			-- For example, we change from `text_contain' to `name_is', in this case, we want to maintain the text in `property_item'.
		require
			a_criterion_attached: a_criterion /= Void
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		local
			l_nary_cri: EB_METRIC_NARY_CRITERION
			l_row: EB_METRIC_CRITERION_ROW
			l_cursor: CURSOR
			l_domain_criterion, l_domain_criterion2: EB_METRIC_DOMAIN_CRITERION
			l_caller_criterion, l_caller_criterion2: EB_METRIC_CALLER_CALLEE_CRITERION
			l_text_criterion, l_text_criterion2: EB_METRIC_TEXT_CRITERION
			l_path_criterion: EB_METRIC_PATH_CRITERION
		do
				-- Load current row.
			initialize_row (a_row)
			if a_criterion.is_normal_criterion then
				create {EB_METRIC_NORMAL_CRITERION_PROPERTY_MANAGER} property_manager.make (grid)
			elseif a_criterion.is_caller_criterion then
				l_caller_criterion ?= a_criterion
				create {EB_METRIC_CALLER_CRITERION_MANAGER} property_manager.make (grid)
				if a_original_criterion /= Void then
					if a_original_criterion.is_domain_criterion then
						l_domain_criterion ?= a_original_criterion
						l_caller_criterion.set_domain (l_domain_criterion.domain)
					elseif a_original_criterion.is_caller_criterion then
						l_caller_criterion2 ?= a_original_criterion
						l_caller_criterion.set_domain (l_caller_criterion2.domain)
						if l_caller_criterion2.only_current_version then
							l_caller_criterion.enable_only_current_version
						else
							l_caller_criterion.disable_only_current_version
						end
					end
				end
			elseif a_criterion.is_domain_criterion then
				create {EB_METRIC_DOMAIN_PROPERTY_MANAGER} property_manager.make (grid)
				l_domain_criterion ?= a_criterion
				if a_original_criterion /= Void and then a_original_criterion.is_domain_criterion then
					l_domain_criterion2 ?= a_original_criterion
					l_domain_criterion.set_domain (l_domain_criterion2.domain)
				end
			elseif a_criterion.is_path_criterion then
				create {EB_METRIC_PATH_CRITERION_PROPERTY_MANAGER} property_manager.make (grid)
				l_path_criterion ?= a_criterion
				if a_original_criterion /= Void and then (a_original_criterion.is_text_criterion or a_original_criterion.is_path_criterion) then
					l_text_criterion2 ?= a_original_criterion
					l_path_criterion.set_path (l_text_criterion2.text)
				end
			elseif a_criterion.is_text_criterion then
				create {EB_METRIC_TEXT_CRITERION_PROPERTY_MANAGER} property_manager.make (grid)
				l_text_criterion ?= a_criterion
				if a_original_criterion /= Void and then (a_original_criterion.is_text_criterion or a_original_criterion.is_path_criterion) then
					l_text_criterion2 ?= a_original_criterion
					l_text_criterion.set_text (l_text_criterion2.text)
					if l_text_criterion2.is_text_criterion then
						if l_text_criterion2.is_case_sensitive then
							l_text_criterion.enable_case_sensitive
						else
							l_text_criterion.disable_case_sensitive
						end
						if l_text_criterion2.is_identical_comparison_used then
							l_text_criterion.enable_identical_comparison
						else
							l_text_criterion.disable_identical_comparison
						end
					else
						l_text_criterion.disable_case_sensitive
						l_text_criterion.disable_identical_comparison
					end
				end
			end
			property_manager.change_actions.extend (agent (grid.change_actions).call ([]))
			property_manager.load_properties (a_criterion)
			property_item := property_manager.property_item
			bind (a_row)

				-- Load subrows.
			l_nary_cri ?= a_criterion
			if l_nary_cri /= Void then
				l_cursor := l_nary_cri.operands.cursor
				from
					l_nary_cri.operands.start
				until
					l_nary_cri.operands.after
				loop
					a_row.insert_subrow (a_row.subrow_count + 1)
 					create l_row.make (l_nary_cri.operands.item, a_row.subrow (a_row.subrow_count), grid, is_read_only, scope)
					register_subrow (l_row)
					l_nary_cri.operands.forth
				end
				l_nary_cri.operands.go_to (l_cursor)
				if not is_read_only then
					a_row.insert_subrow (a_row.subrow_count + 1)
					create l_row.make (Void, a_row.subrow (a_row.subrow_count), grid, is_read_only, scope)
					register_subrow (l_row)
				end
				if grid_row.is_expandable and then not grid_row.is_expanded then
					grid_row.expand
				end
			end
		end

	load_invalid_criterion_row (a_row: EV_GRID_ROW) is
			-- Load invalid criterion in `a_row'.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		do
			initialize_row (a_row)
			create {EV_GRID_LABEL_ITEM} property_item
			bind (a_row)
		end

feature -- Status report

	is_empty_row: BOOLEAN is
			-- Is current empty?
			-- i.e., no criterion is specified.
		do
			Result := is_in_default_state
		end

	is_invalid_row: BOOLEAN is
			-- Is current row invalid?
			-- i.e., a wrong criterion name is sepcified.
		do
			Result := (not is_empty_row) and then not criterion_factory.has_criterion (criterion_name, scope)
		end

	is_valid_row: BOOLEAN is
			-- Is current row valid?
			-- i.e., a right criterion name is sepcified.
		do
			Result := (not is_empty_row) and then (criterion_factory.has_criterion (criterion_name, scope))
		end

	is_valid_nary_row: BOOLEAN is
			-- Is current and valid "AND" or "OR" criterion row?
		do
			Result := is_valid_row and then is_nary_criterion (criterion_name)
		end

	is_read_only: BOOLEAN
			-- Is current row read only?

	is_negation_used: BOOLEAN
			-- Is negation used?

	is_nary_criterion (a_name: STRING): BOOLEAN is
			-- Does `a_name' represent an "AND" or "OR" criterion?
		require
			a_name_attached: a_name /= Void
		do
			Result := a_name.is_case_insensitive_equal (query_language_names.ql_cri_and) or
					  a_name.is_case_insensitive_equal (query_language_names.ql_cri_or)
		end

	is_domain_criterion (a_name: STRING; a_scope: QL_SCOPE): BOOLEAN is
			-- Does `a_name' of scope `a_scope' represent a domain criteiron?
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		local
			l_cri_factory: like criterion_factory
			l_criterion: EB_METRIC_CRITERION
		do
			l_cri_factory := criterion_factory
			if l_cri_factory.has_criterion (a_name, a_scope) then
				l_criterion := l_cri_factory.metric_criterion (a_scope, a_name)
				Result := l_criterion.is_domain_criterion
			end
		end

	is_in_default_state: BOOLEAN
			-- Is current row in default state?
			-- Default state means that current row is empty row from the start.

feature -- Basic operation

	bind (a_row: EV_GRID_ROW) is
			-- Bind current criterion in `a_row'.
		do
			refresh_criterion_item
			a_row.set_item (1, Void)
			a_row.set_item (2, Void)
			if not property_item.deactivate_actions.has (resize_grid_agent) then
				property_item.deactivate_actions.extend (resize_grid_agent)
			end
			a_row.set_item (1, criterion_item)
			a_row.set_item (2, property_item)
			set_grid_row (a_row)
		ensure
			binded_to_grid: is_binded_to_grid
		end

	colors: EV_STOCK_COLORS is
			-- Color factory
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	resize_grid is
			-- Resize `grid' according to size changes of column.
		do
			grid.resize_column (2, 0)
		end

	resize_grid_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `resize_grid'

feature -- Access

	criterion_name: STRING
			-- Name of criterion specified in current row

	scope: QL_SCOPE
			-- Scope of current row

	grid: EB_METRIC_CRITERION_GRID
			-- Grid in which current is located

	criterion_item: EB_METRIC_CRITERION_GRID_EDITABLE_ITEM is
			-- Item used to display and edit criterion name
		local
			l_provider: EB_METRIC_CRITERION_PROVIDER
		do
			if criterion_item_internal = Void then
				create criterion_item_internal
				create l_provider.make (criterion_list)
				criterion_item_internal.set_completion_possibilities_provider (l_provider)
				criterion_item_internal.pointer_double_press_actions.force_extend (agent activate_criterion_item)
				criterion_item_internal.activate_actions.extend (agent on_criterion_item_activated)
				criterion_item_internal.deactivate_actions.extend (agent on_criterion_item_deactivated)
			end
			Result := criterion_item_internal
		ensure
			result_attached: Result /= Void
		end

	parent: like current
			-- Parent of current row

	criterion: EB_METRIC_CRITERION is
			-- Criterion representing current row
		local
			l_nary_metric: EB_METRIC_NARY_CRITERION
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_row: EB_METRIC_CRITERION_ROW
			l_criterion: EB_METRIC_CRITERION
		do
			if is_empty_row then
			elseif is_invalid_row then
				create {EB_METRIC_NORMAL_CRITERION} Result.make (scope, criterion_name)
			elseif is_valid_row then
				Result := criterion_factory.metric_criterion (scope, criterion_name)
				Result.set_is_negation_used (is_negation_used)
				check property_manager /= Void end
				property_manager.store_properties (Result)

					-- Store subrows.
				l_nary_metric ?= Result
				if l_nary_metric /= Void then
					from
						l_row_index := 1
						l_row_count := grid_row.subrow_count
					until
						l_row_index > l_row_count
					loop
						l_row ?= grid_row.subrow (l_row_index).data
						if l_row /= Void then
							l_criterion := l_row.criterion
							if l_criterion /= Void then
								l_nary_metric.operands.extend (l_criterion)
							end
						end
						l_row_index := l_row_index + 1
					end
				end
			end
		end

	not_prefix: STRING is "not"
			-- Not prefix

	ellipse: STRING is "..."
			-- Ellipse

	property_item: EV_GRID_ITEM
			-- Grid item to display criterion properties

	subrows: LIST [EB_METRIC_CRITERION_ROW]
			-- Subrows of current row

	property_manager: EB_METRIC_CRITERION_PROPERTY_MANAGER
			-- Property manager

feature -- Setting

	set_parent (a_parent: like parent) is
			-- Set `parent 'with `a_parent'.
		require
			a_parent_attached: a_parent /= Void
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	register_subrow (a_row: EB_METRIC_CRITERION_ROW) is
			-- Register `a_row' into `subrows'.
		require
			a_row_attached: a_row /= Void
		do
			subrows.extend (a_row)
			a_row.set_parent (Current)
		end

	remove_subrow (a_row: EB_METRIC_CRITERION_ROW) is
			-- Remove `a_row' from `subrows'.	
		require
			a_row_attached: a_row /= Void
		do
			subrows.prune_all (a_row)
		end

feature{NONE} -- Actions

	on_criterion_item_activated (a_window: EV_POPUP_WINDOW) is
			-- Action to be performed when `criterion_item' is activated
		do
			if not criterion_item.text.is_empty then
				criterion_item.text_field.select_all
			end
		end

	on_criterion_item_deactivated is
			-- Action to be performed when `criterion_item' is deactivated
		require
			bined_to_grid: is_binded_to_grid
		local
			l_text: STRING
			l_name: TUPLE [name: STRING; negation: BOOLEAN]
			l_is_empty: BOOLEAN
			l_criterion: like criterion
		do
			l_text := criterion_item.text.twin
			l_text.left_adjust
			l_text.right_adjust
			l_text.to_lower

			if not (is_empty_row and then (l_text.is_equal (ellipse))) then
				l_name := name_from_text_field (l_text)
				l_is_empty := is_empty_row
				is_in_default_state := False
				if l_name = Void then
						-- We entered invalid state.
					criterion_name := l_text
					if parent /= Void then
						parent.remove_subrow (Current)
					end
					load_invalid_criterion_row (grid_row)
					if l_is_empty then
						insert_empty_row_in_parent
					end
				else
						-- We entered valid state.
					if
						(is_nary_criterion (criterion_name) and then is_nary_criterion (l_name.name)) or else
						l_name.name.is_case_insensitive_equal (criterion_name)
					then
							-- If current row is "and" or "or" before and after editing, or
							-- if current row is the same criterion before and after editing
						criterion_name := l_name.name
						is_negation_used := l_name.negation
						refresh_criterion_item
					else
							-- If current row contains a different criterion after editing
						l_criterion := criterion
						criterion_name := l_name.name
						is_negation_used := l_name.negation
						if parent /= Void then
							parent.remove_subrow (Current)
						end
						load_valid_criterion_row (criterion_factory.metric_criterion (scope, l_name.name), grid_row, l_criterion)
					end
					if l_is_empty then
						insert_empty_row_in_parent
					end
				end
				grid.change_actions.call ([])
			end
		end

	on_property_item_deactivated is
			-- Action to be performed when `property_item' deactivated.
		do
			grid.change_actions.call ([])
		end

feature{NONE} -- Implementation

	property_item_deactivated_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_property_item_deactivated'

	insert_empty_row_in_parent is
			-- Insert an empty row in `parent'
		local
			l_row: EB_METRIC_CRITERION_ROW
			l_cursor: CURSOR
			l_has_empty_row: BOOLEAN
		do
			if parent /= Void then
				l_cursor := parent.subrows.cursor
				from
					parent.subrows.start
				until
					parent.subrows.after or l_has_empty_row
				loop
					l_has_empty_row := parent.subrows.item.is_empty_row
					parent.subrows.forth
				end
				parent.subrows.go_to (l_cursor)
				if not l_has_empty_row then
					parent.grid_row.insert_subrow (parent.grid_row.subrow_count + 1)
					create l_row.make (Void, parent.grid_row.subrow (parent.grid_row.subrow_count), grid, is_read_only, scope)
					parent.register_subrow (l_row)
				end
			end
		end

	criterion_item_internal: like criterion_item
			-- Implementation of `criterion_item'

	initialize_row (a_row: EV_GRID_ROW) is
			-- Initialize `a_row', all subrows.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		do
			subrows.wipe_out
			from
			until
				a_row.subrow_count = 0
			loop
				a_row.parent.remove_row (a_row.subrow (a_row.subrow_count).index)
			end
		ensure
			no_subrow_exists: a_row.subrow_count = 0
		end

	name_from_text_field (a_name_str: STRING): TUPLE [name: STRING; negation: BOOLEAN]
			-- Name from text_field
		require
			a_name_str_attached: a_name_str /= Void
		local
			l_name_str: STRING
			l_index: INTEGER
			l_count: INTEGER
			c: CHARACTER
			l_negation_str: STRING
			l_criterion_name: STRING
			l_criterion_valid: BOOLEAN
			done: BOOLEAN
		do
			l_name_str := a_name_str.as_lower
			l_name_str.left_adjust
			l_name_str.right_adjust
			if l_name_str.is_empty then
				l_criterion_name := ""
				is_negation_used := False
			else
				l_criterion_name := l_name_str.twin
				l_count := l_name_str.count
				from
					l_index := 1
				until
					l_index = l_count or done
				loop
					c := l_name_str.item (l_index)
					if c = ' ' or c = '%T' then
						done := True
					else
						l_index := l_index + 1
					end
				end
				check done implies l_index < l_count end
				if done then
					l_negation_str := l_name_str.substring (1, l_index - 1)
					l_negation_str.right_adjust
					if l_negation_str.is_equal (not_prefix) then
						is_negation_used := True
						l_name_str := l_name_str.substring (l_index, l_count)
						l_name_str.left_adjust
					end
				else
					is_negation_used := False
				end
				l_criterion_valid := criterion_factory.has_criterion (l_name_str, scope)
			end
			if l_criterion_valid then
				Result := [l_name_str, is_negation_used]
			else
				Result := Void
			end
		end

	refresh_criterion_item is
			-- Refresh `criterion_item'.
		local
			l_text: STRING
			l_pixmap: like pixmap
		do
			l_pixmap := pixmap
			if l_pixmap = Void then
				criterion_item.remove_pixmap
			else
				criterion_item.set_pixmap (l_pixmap)
			end
			if is_empty_row then
				if is_read_only then
					criterion_item.set_text ("")
				else
					criterion_item.set_text (ellipse)
				end
			elseif is_valid_row then
				create l_text.make (30)
				if is_negation_used then
					l_text.append (not_prefix)
					l_text.append (" ")
				end
				l_text.append (criterion_name)
				criterion_item.set_text (l_text)
			elseif is_invalid_row then
				criterion_item.set_text (criterion_name.twin)
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap for `criterion_item'
		local
			l_criterion: EB_METRIC_CRITERION
		do
			if is_valid_row then
				l_criterion := criterion_factory.metric_criterion (scope, criterion_name)
				if l_criterion.is_and_criterion then
					if is_negation_used then
						Result := pixmaps.icon_pixmaps.metric_not_and_icon
					else
						Result := pixmaps.icon_pixmaps.metric_and_icon
					end
				elseif l_criterion.is_or_criterion then
					if is_negation_used then
						Result := pixmaps.icon_pixmaps.metric_not_or_icon
					else
						Result := pixmaps.icon_pixmaps.metric_or_icon
					end
				elseif l_criterion.is_text_criterion then
					if is_negation_used then
						Result := pixmaps.icon_pixmaps.metric_not_text_criteria_icon
					else
						Result := pixmaps.icon_pixmaps.metric_text_criteria_icon
					end
				elseif l_criterion.is_normal_criterion then
					if is_negation_used then
						Result := pixmaps.icon_pixmaps.metric_not_common_criteria_icon
					else
						Result := pixmaps.icon_pixmaps.metric_common_criteria_icon
					end
				elseif l_criterion.is_domain_criterion then
					if is_negation_used then
						Result := pixmaps.icon_pixmaps.metric_not_relational_criteria_icon
					else
						Result := pixmaps.icon_pixmaps.metric_relational_criteria_icon
					end
				end
			elseif is_invalid_row then
				Result := pixmaps.icon_pixmaps.general_error_icon
			end
		end

	criterion_list: SORTABLE_ARRAY [NAME_FOR_COMPLETION] is
			-- List of criterion of `a_scope'
		local
			l_name_list: LIST [STRING]
			l_name_array: ARRAY [NAME_FOR_COMPLETION]
			l_name: NAME_FOR_COMPLETION
			l_pixmap: EV_PIXMAP
		do
			if criterion_list_internal = Void then
				l_name_list := criterion_factory_table.item (scope).available_names
				create l_name_array.make (1, l_name_list.count)
				from
					l_name_list.start
				until
					l_name_list.after
				loop
					create l_name.make (l_name_list.item)
					l_pixmap := criterion_pixmap_from_name (l_name_list.item)
					if l_pixmap /= Void then
						l_name.set_icon (l_pixmap)
					end
					l_name_array.put (l_name, l_name_list.index)
					l_name_list.forth
				end
				create criterion_list_internal.make_from_array (l_name_array)
				criterion_list_internal.sort
			end
			Result := criterion_list_internal
		ensure
			result_attached: Result /= Void
		end

	criterion_list_internal: like criterion_list
			-- Implementation of `criterion_list'

	criterion_pixmap_from_name (a_name: STRING): EV_PIXMAP is
			-- Pixmap of criterion named `a_name'.
		require
			a_name_attached: a_name /= Void
		local
			l_criterion: EB_METRIC_CRITERION
		do
			if a_name.is_equal (query_language_names.ql_cri_and) then
				Result := pixmaps.icon_pixmaps.metric_and_icon
			elseif a_name.is_equal (query_language_names.ql_cri_or) then
				Result := pixmaps.icon_pixmaps.metric_or_icon
			else
				l_criterion := criterion_factory.metric_criterion (scope, a_name)
				if l_criterion /= Void then
					if l_criterion.is_normal_criterion then
						Result := pixmaps.icon_pixmaps.metric_common_criteria_icon
					elseif l_criterion.is_text_criterion then
						Result := pixmaps.icon_pixmaps.metric_text_criteria_icon
					elseif l_criterion.is_domain_criterion then
						Result := pixmaps.icon_pixmaps.metric_relational_criteria_icon
					end
				end
			end
		end

	activate_criterion_item is
			-- Activate `criterion_item'.
		do
			if not is_read_only then
				criterion_item.activate
			end
		end

invariant
	grid_attached: grid /= Void
	scope_attached: scope /= Void
	criterion_name_attached: criterion_name /= Void
	subrows_attached: subrows /= Void

indexing
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


end
