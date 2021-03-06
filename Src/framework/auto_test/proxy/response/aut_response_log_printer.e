note
	description: "Printer to print response from interpreter into log file."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_RESPONSE_LOG_PRINTER

inherit
	AUT_RESPONSE_VISITOR

	AUT_SHARED_CONSTANTS

create
	make,
	make_with_prefix

feature{NONE} -- Initialize

	make (a_output_stream: like output_stream)
			-- Initialize.
		require
			a_output_stream_attached: a_output_stream /= Void
		do
			output_stream := a_output_stream
			response_prefix := interpreter_log_prefix.twin
		ensure
			output_stream_set: output_stream = a_output_stream
			response_prefix_set: response_prefix /= Void and then response_prefix.is_equal (interpreter_log_prefix)
		end

	make_with_prefix (a_output_stream: like output_stream; a_response_prefix: STRING)
			-- Initialize.
		require
			a_output_stream_attached: a_output_stream /= Void
			a_response_prefix_attached: a_response_prefix /= Void
		do
			output_stream := a_output_stream
			response_prefix := a_response_prefix.twin
		ensure
			output_stream_set: output_stream = a_output_stream
			response_prefix_set: response_prefix /= Void and then response_prefix.is_equal (a_response_prefix)
		end

feature -- Access

	response_prefix: STRING
			-- Prefix to add in front of every response line

	output_stream: KI_CHARACTER_OUTPUT_STREAM
			-- Stream where output fron `Current' printer should go to

feature -- Process

	process_normal_response (a_response: AUT_NORMAL_RESPONSE)
			-- Process `a_response'.
		do
			print_line (multi_line_value_start_tag)
			print_lines_with_prefix (a_response.text, <<response_prefix>>)
			print_line (multi_line_value_end_tag)
			if a_response.has_exception then
				print_line (interpreter_exception_message)
				print_line (a_response.exception.code.out)
				print_line (a_response.exception.recipient_name)
				print_line (a_response.exception.class_name)
				print_line (a_response.exception.tag_name)
				print_line (a_response.exception.is_invariant_violation_on_feature_entry.out)
				print_line (multi_line_value_start_tag)
				print_lines_with_prefix (a_response.exception.trace, <<response_prefix>>)
				print_line (multi_line_value_end_tag)
			else
				print_line (interpreter_success_message)
			end
			print_line (interpreter_done_message)
		end

	process_error_response (a_response: AUT_ERROR_RESPONSE)
			-- Process `a_response'.
		local
			l_prefixes: ARRAY [STRING]
		do
			l_prefixes := <<response_prefix>>
			print_line (multi_line_value_start_tag)
			print_lines_with_prefix (a_response.text, l_prefixes)
			print_line (multi_line_value_end_tag)
			print_lines_with_prefix (a_response.text, <<response_prefix>>)
			print_line (interpreter_done_message)
		end

	process_bad_response (a_response: AUT_BAD_RESPONSE)
			-- Process `a_response'.
		do
			print_lines_with_prefix (a_response.text,  <<response_prefix>>)
		end

feature{NONE} -- Implementation

	lines_with_prefixes (a_text: STRING; a_prefixes: ARRAY [STRING]): LIST [STRING]
			-- List of lines in `a_text', each line is prepended with prefixes in `a_prefixes' in order.
			-- If `a_text' is empty, an empty list will be returned.
		require
			a_text_attached: a_text /= Void
			a_prefixes_attached: a_prefixes /= Void
			a_prefixes_not_have_void: not a_prefixes.has (Void)
		local
			l_prefix: STRING
			l_lines: LIST [STRING]
		do
			if a_text.is_empty then
				create {ARRAYED_LIST [STRING]} Result.make (0)
			else
				create l_prefix.make (64)
				a_prefixes.do_all (agent l_prefix.append ({STRING}?))
				l_lines := a_text.split ('%N')
				if not l_lines.is_empty then
					l_lines.finish
					l_lines.remove
				end
				from
					l_lines.start
				until
					l_lines.after
				loop
					l_lines.item.prepend (l_prefix)
					l_lines.forth
				end
				Result := l_lines
			end
		ensure
			result_attached: Result /= Void
			data_correct: not Result.has (Void)
			result_is_empty_when_a_text_is_empty: a_text.is_empty implies Result.is_empty
		end

	print_lines_with_prefix (a_text: STRING; a_prefixes: ARRAY [STRING])
			-- Print lines in `a_text', each line is prepended with prefixes in `a_prefixes' in order.
			-- If `a_text' is empty, nothing is printed.
		require
			a_text_attached: a_text /= Void
			a_prefixes_attached: a_prefixes /= Void
			a_prefixes_not_have_void: not a_prefixes.has (Void)
		do
			lines_with_prefixes (a_text, a_prefixes).do_all (agent pure_print_line)
		end

	pure_print_line (a_string: STRING)
			-- Print `a_string' in a line into `output_stream'.
		require
			a_string_attached: a_string /= Void
		do
			output_stream.put_string (a_string)
			output_stream.put_character ('%N')
		end

	print_line (a_line: STRING)
			-- Print `a_line' with `response_prefix'.
		require
			a_line_attached: a_line /= Void
		do
			output_stream.put_string (response_prefix)
			output_stream.put_string (a_line)
			output_stream.put_character ('%N')
		end

invariant
	response_prefix_attached: response_prefix /= Void
	output_stream_attached: output_stream /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
