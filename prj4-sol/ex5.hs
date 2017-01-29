type Name = String
type Grade = Float
type NameGrade = (Name, Grade)




data Tree a b
        = Empty
          | Leaf a b
          | Node (Tree a b) a (Tree a b)
		deriving (Show)

addGrade Empty NameGrade = Node (Leaf Name) Name (Leaf Grade)

