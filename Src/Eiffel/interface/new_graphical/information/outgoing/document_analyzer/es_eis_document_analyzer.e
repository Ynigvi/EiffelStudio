note
	description: "Analyze the file given at creation to add bookmarks to titles' style."
	date: "$Date: 2017-08-30 10:00:30 +0200 (Wed, 30 Aug 2017) $"
	revision: "$Revision: $"

deferred class
	ES_EIS_DOCUMENT_ANALYZER

feature {NONE} -- Initialization

	make (a_file_path: STRING)
			-- Initialize the object with the file to analyze
		local
			i: INTEGER
			l_path: STRING
			l_file: STRING
		do
			file_path := a_file_path
			i := file_path.last_index_of ('/', file_path.count)
			if i = 0 then
				i := file_path.last_index_of ('\', file_path.count)
			end
			l_path := file_path.substring (1, i)
			l_file := file_path.substring (i+1, file_path.count)
			l_file.replace_substring_all (".", "_")
			l_file.replace_substring_all (" ", "_")
			tmp_directory_path := l_path+l_file
		end

feature -- Compressed files manipulations

	zip
			-- Compress a file and rename it
		local
			l_directory: DIRECTORY
		do
			zip_call (tmp_directory_path.to_c, file_path.to_c)
			create l_directory.make_with_name (tmp_directory_path)
			if l_directory.exists then
				l_directory.recursive_delete
			end
		end

	zip_call (a_directory_path: ANY; a_zip_file_path: ANY)
			-- External call to library zip command.
		external
			"C inline use %"minizip.h%""
		alias
			"{
				zip_folder((char*) *$a_directory_path, (char*) *$a_zip_file_path);
			 }"
		end

	unzip
			-- Uncompress a file in order to be able to parse it
		local
			l_directory: DIRECTORY
		do
			create l_directory.make_with_name (tmp_directory_path)
			if l_directory.exists then
				l_directory.recursive_delete
			end
			l_directory.create_dir
			unzip_call (file_path.to_c, tmp_directory_path.to_c)
		end

	unzip_call (a_zip_file_path: ANY; a_directory_path: ANY)
			-- External call to library unzip command.
		external
			"C inline use %"miniunz.h%""
		alias
			"{
				unzip_folder((char*) *$a_zip_file_path, (char*) *$a_directory_path);
			}"
		end

feature -- File analysis

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

	tmp_directory_path: STRING
		-- Path to temporary directory where to extract zip

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
