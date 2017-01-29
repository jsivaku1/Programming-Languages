create_tree(niltree).

inserted_in_is(Item,niltree, btree(Item,niltree,niltree)).

inserted_in_is(Item,btree(ItemI,L_T,R_T),Result_Tree) :- 
    Item @< ItemI,
    inserted_in_is(Item,L_Tree,Result_Tree).

inserted_in_is(Item,btree(ItemI,L_T,R_T),Result_Tree) :- 
    Item @> ItemI,
    inserted_in_is(Item,R_Tree,Result_Tree).

inorder(niltree,[ ]).
inorder(btree(Item,L_T,R_T),Inorder) :- 
          inorder(L_T,Left),
          inorder(R_T,Right),
          append(Left,[Item|Right],Inorder).

