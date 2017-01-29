
type Grade = Float
type Name = String
type NameGrade = (Name, Grade)
data Tree a b = Empty | Leaf a b | Node (Tree a b) a (Tree a b) deriving (Show)  



addGrade :: Tree Name Grade -> NameGrade -> Tree Name Grade
addGrade Empty nameGrade = Node (Leaf (fst nameGrade) (snd nameGrade)) (fst nameGrade) Empty                  
addGrade a nameGrade = Node (Leaf (fst nameGrade) (snd nameGrade)) (fst nameGrade) a 
addGrade (Node left a right) nameGrade
    | (fst nameGrade) == a = Node left (fst nameGrade) right 
    | (fst nameGrade) < a  = Node (addGrade right nameGrade) (fst nameGrade) (Node left a right) 
    | (fst nameGrade) > a  = Node (Node left a right) a (addGrade right nameGrade)







