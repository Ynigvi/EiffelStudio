-- System level server file counter.

class
	FILE_COUNTER

inherit
	COMPILER_COUNTER
		redefine
			append
		end

creation
	make

feature -- Initialization

	append (other: like Current) is
			-- Append ids generated by `other' to `Current' and
			-- renumber the resulting set of ids.
		do
			Precursor {COMPILER_COUNTER} (other)
			if other.precompiled_offsets = Void then
				create precompiled_offsets.make (1,1)
				precompiled_offsets.put (precompiled_offset, 1)
			else
				increase_precompiled_offsets (other.precompiled_offsets)
			end
		end

feature -- Access

	compilation_id (id: INTEGER): INTEGER is
			-- Compilation_id corresponding to `id'.
		require
			precompiled_offsets_set: precompiled_offsets /= Void
		local
			i, nb: INTEGER
			found: BOOLEAN
		do
			from
				i := precompiled_offsets.lower
				nb := precompiled_offsets.upper
			until
				i > nb or found
			loop
				found := id <= precompiled_offsets.item (i)
				if found then
					Result := i
				end
				i := i + 1
			end
		ensure
			found: Result > 0
		end

feature -- Precompiled_offsets

	precompiled_offsets: ARRAY [INTEGER]
			-- Offset for each precompiled library.

feature {NONE} -- Implementation

	increase_precompiled_offsets (other: like precompiled_offsets) is
			-- Reset `precompiled_offsets' with new values.
		local
			i, nb: INTEGER
		do
			from
				create precompiled_offsets.make (1, other.count + 1)
				i := other.lower
				nb := other.upper
			until
				i > nb
			loop
				precompiled_offsets.put (other.item (i), i)
				i := i + 1
			end
			precompiled_offsets.put (precompiled_offset, nb + 1)
		end

end -- class FILE_COUNTER
