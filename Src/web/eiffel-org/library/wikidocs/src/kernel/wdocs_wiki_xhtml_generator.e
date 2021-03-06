note
	description: "Summary description for {WDOCS_WIKI_XHTML_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WIKI_XHTML_GENERATOR

inherit
	WIKI_XHTML_GENERATOR
		redefine
			make,
			page_title,
			visit_page,
			visit_link,
			visit_missing_link,
			is_newline_required_after_code_block
		end

create
	make

feature {NONE} -- Initialization

	make (b: like buffer)
		do
			Precursor (b)
			create interwiki_mappings.make (0)
			set_is_auto_toc_enabled (True)
		end

feature -- Setting

	overridden_title: detachable READABLE_STRING_8

	interwiki_mappings: STRING_TABLE [READABLE_STRING_8]
			-- handling of interwiki links indexed by name.
			-- For example [[wp:Name]] .
			--| examples:
			--|		Wikipedia: wp   | http://en.wikipedia.org/wiki/$1
			--|		DevEiffelCom: dev | http://dev.eiffel.com/$1
			--|		StaticReference: ref | isedoc/static/$1
			--|		UuidReference: uuid | isedoc/uuid/$1
			--|		Local file: file | sites/default/files/$1


feature -- Page processing

	visit_page_with_title (a_page: WIKI_PAGE; a_title: READABLE_STRING_8)
		do
			overridden_title := a_title
			visit_page (a_page)
			overridden_title := Void
		end

	visit_page (a_page: WIKI_PAGE)
		local
			utf: UTF_CONVERTER
			b: like is_html_encoded_output
		do
			current_page := a_page
			if attached a_page.structure as st then
				output ("<div class=%"wikipage%">")

				output ("<h1 class=%"wikititle%">")
				b := is_html_encoded_output
				set_html_encoded_output (True)
				output (page_title (a_page))
				set_html_encoded_output (b)
				output ("</h1>%N")

				if is_auto_toc_enabled then
					output_toc (Void, True)
				end
				st.process (Current)
				output ("</div>%N")
			end
			current_page := Void
		end		

	visit_link (a_link: WIKI_LINK)
			-- <Precursor>
		local
			l_css_class: STRING
			l_url: STRING

			l_link_name: READABLE_STRING_8
			l_link_arg: READABLE_STRING_8
			l_interwiki_location: detachable STRING_8
		do
			l_link_name := a_link.name
			if l_link_name.has (':') then
				across
					interwiki_mappings as ic
				until
					l_interwiki_location /= Void
				loop
					if l_link_name.starts_with_general (ic.key.as_string_8 + ":") then
						create l_interwiki_location.make_from_string (ic.item)
						l_link_arg := l_link_name.substring (ic.key.count + 2, l_link_name.count)
						l_interwiki_location.replace_substring_all ("$1", l_link_arg)
					end
				end
			end
			if l_interwiki_location /= Void then
				create l_css_class.make_from_string ("wiki_external") -- TODO: "wiki_link")
				if attached a_link.fragment as l_fragment then
					l_url := l_interwiki_location + "#" + l_fragment
				else
					l_url := l_interwiki_location
				end
				output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%">")
				a_link.text.process (Current)
				output ("</a>")
			else
				Precursor (a_link)
			end
		end

	visit_missing_link (a_link: WIKI_LINK)
			-- <Precursor>
		do
			Precursor (a_link)
		end

feature -- Settings

	is_newline_required_after_code_block: BOOLEAN = False
		-- <Precursor>
		-- should be handled by css style.

feature -- Helper

	page_title (a_page: WIKI_PAGE): STRING_8
			-- Title for page `a_page'.
		do
			if attached overridden_title as t then
				Result := t
			else
				Result := a_page.title
			end
		end

end
