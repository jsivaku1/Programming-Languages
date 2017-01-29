create_tree(Niltree) :- var(Niltree). % Note: Nil is a variable

inserted_in_is(Item,btree(Item,L_T,R_T)).
     
inserted_in_is(Item,btree(ItemI,L_T,R_T)) :- 
    Item @< ItemI,
    inserted_in_is(Item,L_T).

inserted_in_is(Item, btree(ItemI,L_T,R_T)) :- 
    Item @> ItemI,
    inserted_in_is(Item,R_T).

inorder(Niltree,[ ]) :- var(Niltree).
inorder(btree(Item,L_T,R_T),Inorder) :- 
          inorder(L_T,Left),
          inorder(R_T,Right),
          append(Left,[Item|Right],Inorder).
