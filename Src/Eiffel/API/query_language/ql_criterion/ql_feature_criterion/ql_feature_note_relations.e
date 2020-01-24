note
	description: "[
					Criterion to test whether or not a feature is ancestor of another feature
					
					This criterion will use `data' attribute in every QL_FEATURE candidate object.
					IF a QL_FEATURE candidate is satisfied by this criterion. it's `data' attribute will
					be set with branch id (of type INTEGER)
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_NOTE_RELATIONS

inherit
	QL_FEATURE_CALLER_IS_CRI
	redefine
		find_result
	end

create
	make

feature{NONE} -- Implementation

	find_result
	-- Find callees of `l_feat'.
	local
		cfeat: STRING
		invariant_name: STRING
		l_invariant_list: like invariant_list
		l_feature_list: like feature_list
		l_branch_id_list: like user_data_list
		l_invariant_callee: like callee_list_for_invariant
		l_feature_callee: like callee_list_for_feature
		l_callees: LIST [TUPLE [class_c: CLASS_C; feature_name: STRING]]
		l_default_rescue: STRING
		l_class_name: STRING
		l_feature_name: STRING
		l_class_i: CLASS_I
		l_class: CLASS_C
		i,j,l_count,l_count_2: INTEGER
	do
		if features_from_domain (criterion_domain).count > 0 and then attached features_from_domain (criterion_domain).first.e_feature as l_feat then
			l_invariant_list := invariant_list
			l_feature_list := feature_list
			l_branch_id_list := user_data_list
			invariant_name := "_invariant"
			l_default_rescue := "default_rescue"
			--l_callees := l_feat.callees (flag)
			l_invariant_callee := callee_list_for_invariant
			l_feature_callee := callee_list_for_feature
			if attached l_feat.ast and then attached l_feat.ast.body and then attached {EIFFEL_LIST [AST_EIFFEL]} l_feat.ast.body.indexing_clause as l_as then
				from
					i := 1
					l_count := l_as.count
				until
					i > l_count
				loop
					if attached {INDEX_AS} l_as.i_th (i) as lt_as then
						if lt_as.tag /= Void then
							if lt_as.tag.name_32.as_lower.same_string ("extends") then
								from
									j := 1
									l_count_2 := lt_as.index_list.count
								until
									j > l_count_2
								loop
									if attached {STRING_AS} lt_as.index_list.i_th (j) as lt_item then
										l_class_name := lt_item.value_32.substring (lt_item.value_32.index_of ('{', 1)+1, lt_item.value_32.index_of ('}', 1)-1)
										if not l_class_name.is_empty then
											l_class_i := l_feat.universe.safe_class_named (l_class_name, l_feat.associated_class.group)
											if l_class_i /= Void then
												l_class := l_class_i.compiled_class
												l_feature_name := lt_item.value_32.substring (lt_item.value_32.index_of ('.', 1)+1, lt_item.value_32.count)
												if attached l_class.feature_named (l_feature_name) as the_feature then
													l_feature_list.extend (the_feature.e_feature)
													l_feature_callee.extend (the_feature.e_feature)
													l_branch_id_list.extend (1)
												end
											end
										end
									end
									j := j + 1
								end
							end
						end
					end
					i := i + 1
				end
			end
		end
	end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end
