take1 a (x:xs) = 
	if a /= 0
	then x : take1 (a-1) (xs)
	else []
	
map_ints_from x [] = x : map_ints_from (x+1) []  

constant_list x = x : constant_list x	


multiples x = 
	multiples1 x (map_ints_from ((x+1)-x) [])
multiples1 x (n:ns) = 
	x*n : multiples1 x ns 
	
id = []

	
