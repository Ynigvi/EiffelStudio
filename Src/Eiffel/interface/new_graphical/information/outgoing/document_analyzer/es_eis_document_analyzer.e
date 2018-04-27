note
	description: "Analyze the file given in creation to add bookmarks to titles' style."
	date: "$Date: 2017-08-30 10:00:30 +0200 (Wed, 30 Aug 2017) $"
	revision: "$Revision: $"

deferred class
	ES_EIS_DOCUMENT_ANALYZER

feature {NONE} -- Initialization

	make (a_file_path: STRING)
			-- Initialize the object with the file to analyze
		do
			file_path := a_file_path
		end

feature -- Compressed files manipulations

	zip
			-- Compress a file and rename it
		do
			zip_call (file_path.to_c)
		end

	zip_call (a_file_path: ANY)
			-- External call to linux zip command.
			-- Should be remplace by a multiplatform zip
			-- in future.
		external
			"C inline use <stdlib.h>"
		alias
			"{
				char* cmd = malloc(sizeof (char) * (18 + strlen ((char*) *$a_file_path)));
				sprintf(cmd, "zip -r %s ~/tmp_doc", (char*) *$a_file_path);
				system (cmd);
			}"
		end

	unzip
			-- Uncompress a file in order to be able to parse it
		do
			unzip_call (file_path.to_c)
		end

	unzip_call (a_file_path: ANY)
			-- External call to linux unzip command.
			-- Should be remplace by a multiplatform unzip
			-- in future.
		external
			"C inline use <stdlib.h>"
		alias
			"{
				char* cmd = malloc(sizeof (char) * (20 + strlen ((char*) *$a_file_path)));
				sprintf(cmd, "unzip %s -d ~/tmp_doc", (char*) *$a_file_path);
				system (cmd);
			}"
		end

	parse
			-- Parse the xml content file to add bookmarks on title that does not contains ones
		deferred
		end

	analyze
	-- Add bookmarks to the file
		require
			file_path.ends_with(".docx") or file_path.ends_with(".odt")
		do
			unzip
			parse
			zip
		ensure
			file_path = old file_path
		end

feature
	file_path: STRING
	-- Path of file to analyze

	content_file_path: STRING deferred end
	-- Relative path of content file into compressed archive

;note
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
