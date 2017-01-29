add_grade(GradeTree, NameGrade, GradeTreez):- 
	name_grade(Name, Grade) = NameGrade,
	N=Name,
	GradeTree = [] -> inserting(NameGrade, LT, GradeTreez) ; inserting(NameGrade, LT, GradeTreez).
	

get_grade(GradeTree, Name, Grade):-
	name_grade(Name, Grade)=GradeTree.	

inserting(Key,null,tree(Key,[],[])).
inserting(Key,tree(Root,LeftSubTree,RightSubTree),tree(Root,NewLeftSubTree,RightSubTree)) :-
    Key @< Root,
	write('if part'),
    inserting(Key,LeftSubTree,NewLeftSubTree).
inserting(Key,tree(Root,LeftSubTree,RightSubTree),tree(Root,LeftSubTree,NewRightSubTree)) :-
    Key @> Root,
	write('else part'),
    inserting(Key,RightSubTree,NewRightSubTree).


	
	



