

data VTree a =
        VLeaf a |
        VNode (VTree a) a (VTree a)
        deriving (Eq, Show)


treeToList :: (Ord a) => VTree a -> (a -> b) -> (b -> a -> b -> b) -> b   
treeToList VLeaf a = a
treeToList (VNode VTree left right) = treeToList left ++ [root] ++ treeToList right
