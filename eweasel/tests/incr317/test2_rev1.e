
class TEST2
inherit
	ANY
		rename 
			default_create as make
		redefine
			make
		end
convert
	make_from_integer_8 ({INTEGER_8})

feature
	make
		do
			print ("In make%N")
		end
	
	make_from_integer_8 (n: INTEGER_8)
		do
			print ("In make_from_integer_8%N")
		end
	
end
