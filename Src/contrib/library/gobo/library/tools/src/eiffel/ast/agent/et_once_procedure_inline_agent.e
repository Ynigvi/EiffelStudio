note

	description:

		"Eiffel inline agents with a once-procedure as associated feature"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2007-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ONCE_PROCEDURE_INLINE_AGENT

inherit

	ET_INTERNAL_PROCEDURE_INLINE_AGENT

	ET_ONCE_ROUTINE_INLINE_AGENT
		rename
			make as make_inline_agent
		end

create

	make

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_once_procedure_inline_agent (Current)
		end

end
