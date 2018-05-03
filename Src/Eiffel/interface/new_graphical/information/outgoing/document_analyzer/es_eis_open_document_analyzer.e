note
	description: "Analyze the file given at creation to add bookmarks to titles' style."
	date: "$Date: 2017-08-30 10:28:12 +0200 (Wed, 30 Aug 2017) $"
	revision: "$Revision: $"

class
	ES_EIS_OPEN_DOCUMENT_ANALYZER

inherit
	ES_EIS_DOCUMENT_ANALYZER

create
	make

feature

	parse
		-- Parse the xml content file to add bookmarks on title that does not contains ones
		local
				l_regex, l_subregex: RX_PCRE_MATCHER
				l_string: STRING
				l_substring: STRING
				l_pos: INTEGER
				l_bookmark: STRING
				l_file : PLAIN_TEXT_FILE
				l_outfile : PLAIN_TEXT_FILE
			do
				create l_regex.make
				create l_subregex.make
				create l_file.make_open_read (content_file_path)
				l_string := ""

				from
					l_file.read_character
				until
					l_file.exhausted
				loop
					l_string.append_character (l_file.last_character)
					l_file.read_character
				end

				l_file.close

				l_regex.set_greedy (false)
				l_regex.compile ("<text:h text:style-name=%"Heading.*>(.*)</text:h>")
				l_subregex.compile ("<text:bookmark")

				l_pos := 1

				from
					l_regex.match_substring (l_string, l_pos, l_string.count)
				until
					not l_regex.has_matched
				loop
					l_pos := l_regex.captured_end_position (1)
					l_substring := l_string.substring (l_regex.captured_start_position (1),
													   l_pos)

					if not l_subregex.matches (l_substring) then
						l_bookmark := "<text:bookmark text:name=%""+ l_substring +"%"/>"
						l_string.insert_string (l_bookmark, l_regex.captured_start_position (1))
						l_pos := l_pos + l_bookmark.count
					end

					l_regex.match_substring (l_string, l_pos, l_string.count)
				end

				create l_outfile.make_create_read_write (content_file_path)
				l_outfile.put_string (l_string)
				l_outfile.close
			end
feature
	content_file_path: STRING do Result := tmp_directory_path + "/content.xml" end
note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
