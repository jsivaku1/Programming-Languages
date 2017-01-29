take1 a (x:xs) = 
	if a /= 0
	then x : take1 (a-1) (xs)
	else []
--ex1	
map_ints_from x [] = x: map_ints_from (x+1) []
--ex2
constant_list x = x : constant_list x	

--ex3
multiples x = 
	multiples1 x (map_ints_from ((x+1)-x) [])
multiples1 x (n:ns) = 
	x*n : multiples1 x ns 

id = []
--ex4

zapWith :: (a -> a -> a) -> [a] -> [a] -> [a]
zapWith f xs [] = xs
zapWith f [] ys = ys
zapWith f (x:xs) (y:ys) = f x y : zapWith f xs ys

extendWith f [] = []
extendWith f xs@(x:ys) = x : zapWith f xs ys

pascal = iterate (extendWith (+)) [1]


-- generate next row from current row
--nextRow row = zipWith (+) ([0] ++ row) (row ++ [0])
 
-- returns the first n rows
--pascal = iterate nextRow [1]
--ex5
type Grade = Float
type Name = String
type NameGrade = (Name, Grade)
data Tree a b = Empty | Leaf a b | Node (Tree a b) a (Tree a b) deriving (Show)



addGrade :: Tree Name Grade -> NameGrade -> Tree Name Grade
addGrade Empty (name,grade) = (Leaf name grade)
addGrade (Leaf a b) (name,grade) 
	| name>a = Node (Leaf a b) a (Leaf name grade)
	| name<a = Node (Leaf name grade) name (Leaf a b)
	| name==a = (Leaf name grade)
addGrade (Node left a right) (name,grade)
    | name < a  = (Node left a (addGrade right (name,grade)))
    | otherwise  = (Node (addGrade left (name,grade)) a right)




--ex6
my_map op xs = foldr (\x acc -> op x : acc) [] xs 


--ex7

data VTree a =
        VLeaf a |
        VNode (VTree a) a (VTree a)
        deriving (Eq, Show)


reduce_tree1 ::  VTree a -> [a]
reduce_tree1 (VLeaf a) = [a] 
reduce_tree1 (VNode a left right) = reduce_tree1 a ++ [left] ++ reduce_tree1 right

reduce_tree tree f1 f2 = f2 (reduce_tree1 tree) [] []


--ex8.hs
map_tree op (VNode a left right) = treeFromList (my_map op (reduce_tree1 (VNode a left right))) 


treeFromList :: (Ord a) => [a] -> VTree a
treeFromList [a] = (VLeaf a)
treeFromList (a:as) = VNode (treeFromList [a]) (head as) (treeFromList (tail as))


--ex9.hs
tree_to_list (VNode a left right) = reduce_tree1 (VNode a left right)

