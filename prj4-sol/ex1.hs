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

{-
zapWith :: (a -> a -> a) -> [a] -> [a] -> [a]
zapWith f xs [] = xs
zapWith f [] ys = ys
zapWith f (x:xs) (y:ys) = f x y : zapWith f xs ys

extendWith f [] = []
extendWith f xs@(x:ys) = x : zapWith f xs ys

pascal = iterate (extendWith (+)) [1]
-}

-- generate next row from current row
nextRow row = zipWith (+) ([0] ++ row) (row ++ [0])
 
-- returns the first n rows
pascal = iterate nextRow [1]
