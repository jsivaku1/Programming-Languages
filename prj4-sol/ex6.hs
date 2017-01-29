my_map op xs = foldr (\x acc -> op x : acc) [] xs 
