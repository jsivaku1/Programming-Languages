

name_grade(Name, Grade).

add_grade([], name_grade(N, G), tree(name_grade(N, G), [], [])).
add_grade(tree(name_grade(Newname, Newgrade), L, R), name_grade(Newname, Newgrade1), tree(name_grade(Newname, Newgrade1), L, R)).
add_grade(tree(name_grade(Newname, Newgrade), L, R), name_grade(Newname1, Newgrade1), Z):-
			Newname1 @< Newname -> Z = tree(name_grade(Newname, Newgrade), tree(name_grade(Newname1, Newgrade1),[],[]), R);
			Newname1 @> Newname -> Z = tree(name_grade(Newname, Newgrade), L, tree(name_grade(Newname1, Newgrade1),[],[])).

get_grade(tree(name_grade(Newname, Newgrade), L, R), Newname, Newgrade).
get_grade(tree(name_grade(Newname,Newgrade), L, R), Name, Grade):-

			L=tree(name_grade(Name, G), LL, LR),
			Grade=G;
			R=tree(name_grade(Name, G), RL, RR),
			Grade=G.

			














