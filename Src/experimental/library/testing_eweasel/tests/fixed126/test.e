class	TEST

create
	make

feature -- Initialization

	make is
		local
			child: CHILD [COMPARABLE]
--			child2: CHILD [INTEGER]
		do
			create child
			child.failure (0, 0)
--			create child2
--			child2.failure (0, 0)
		end

end -- class TEST
