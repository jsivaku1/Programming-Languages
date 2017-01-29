
/*Question 1. Maximum of two numbers..*/
max_list([Z], Z).
max_list([X|Xs], Z):-
	max_list(Xs, T), (X > T -> Z = X ; Z = T).
	




/*Question 2. */
name_grade(Name, Grade).
add_grade([], name_grade(N, G), tree(name_grade(N, G), [], [])).
add_grade(tree(name_grade(Newname, Newgrade), L, R), name_grade(Newname, Newgrade1), Z):-
			Z= tree(name_grade(Newname1, Newgrade1), L, R).
			
add_grade(tree(name_grade(Newname, Newgrade), L, R), name_grade(Newname1, Newgrade1), Z):-
                        Newname1 @< Newname -> Z = tree(name_grade(Newname, Newgrade), tree(name_grade(Newname1, Newgrade1),[],[]), R);
                        Newname1 @> Newname -> Z = tree(name_grade(Newname, Newgrade), L, tree(name_grade(Newname1, Newgrade1),[],[])).

get_grade(tree(name_grade(Newname, Newgrade), L, R), Newname, Grade):-
			Grade= Newgrade.
			
get_grade(tree(name_grade(Newname,Newgrade), L, R), Name, Grade):-
                        L=tree(name_grade(Name, G), LL, LR),
                        Grade=G;
                        R=tree(name_grade(Name, G), RL, RR),
                        Grade=G.





/*Question 3. Transpose the list..*/

list_tuples(M, T):-
  list_tuples(M, [], T).

list_tuples([], [], []).
list_tuples([], S, [[]|T]):-
  S \= [] ->
   (reverse(S, M), list_tuples(M, [], T)).
list_tuples([[]|MTail], S, T):-
  list_tuples(MTail, S, T).
list_tuples([[Item|Tail]|MTail], S, [[Item|NTail]|T]):-
  list_tuples(MTail, [Tail|S], [NTail|T]).




/*Question 4. Regex parsing of re_match re_find..*/

/* 
Parser for regex's based approximately on the following grammar:

re_exp
  : re_exp '|' re_term
  | re_term
  ;

re_term
  : re_term re_factor
  | re_factor
  ;

re_factor
  : re_factor '*'
  | '(' re_exp ')'
  | '\' CHAR
  | NON_META_CHAR
  | char_class
  ;
char_class
  : '[' CLASS_FIRST_CHAR? char_class_contents ']'
  ;
char_class_contents
  : char_class_content char_class_contents
  | char_class_content
  ;
char_class_content
  : char_class_char
  | char_class_char '-' char_class_char
  ;
char_class_char
  : '\' CHAR
  | CHAR_CLASS_CHAR
  ;

CHAR is any character.  NON_META_CHAR is any char other than \, |, [, *. (, ).
CHAR_CLASS_CHAR is any char other than \, -, ].
  
*/

re_parse(String, Ast) :-
  re_exp(Ast, String, []).

re_exp(Z) -->
  re_term(T) , re_exp_rest(T, Z).
re_exp_rest(Acc, Z) -->
  "|" , re_term(T) , re_exp_rest(alt(Acc, T), Z).
re_exp_rest(Acc, Acc) -->
  [].

re_term(Z) -->
  re_factor(F) , re_term_rest(F, Z).
re_term_rest(Acc, Z) -->
  re_factor(F) , re_term_rest(conc(Acc, F), Z).
re_term_rest(Acc, Acc) -->
  [].

re_factor(Z) -->
  "(" , re_exp(E) , ")" , re_factor_rest(E, Z).
re_factor(Z) -->
  "\\" , [X] , re_factor_rest(class(X, X), Z).
re_factor(Z) -->
  non_meta_char(X) , re_factor_rest(class(X, X), Z).
re_factor(Z) -->
  char_class(C) , re_factor_rest(C, Z).

re_factor_rest(Acc, Z) -->
  "*" , re_factor_rest(closure(Acc), Z).
re_factor_rest(Acc, Acc) -->
  [].

char_class(Z) -->
  "[", 
   (   "^" -> char_class_content([], C) , char_class_contents(C, X1) ,  
	      { sort(X1, X2) , negate_sequence(0, X2, X3) , 
	        sequence_to_char_classes(X3, Z) }
     ; "-" -> char_class_contents([0'-], X1) , 
	      { sort(X1, X2) , sequence_to_char_classes(X2, Z) }
     ;        char_class_content([], C) , char_class_contents(C, X1) ,
	      { sort(X1, X2) , sequence_to_char_classes(X2, Z) }
   ) ,
  "]".
char_class_contents(Acc, Z) -->
  char_class_content(Acc, Acc1) ,
  char_class_contents(Acc1, Z).
char_class_contents(Acc, Acc) -->
  "".

char_class_content(Acc, Z) -->
  char_class_char(C1) ,
  ( "-" -> char_class_char(C2) , { seq_add(C1, C2, Acc, Z) }
        ;  { Z = [C1|Acc] }
  ).

non_meta_char(X) -->
  [X] ,
  { X =\= 0'\\ , X =\= 0'| , X =\= 0'[ , X =\= 0'* ,X =\= 0'( ,X =\= 0')  }.

char_class_char(X) -->
  [X] ,
  { X =\= 0'\\ , X =\= 0'- , X =\= 0'] }.

seq_add(Lo, Hi, Acc, Z):-
  Lo =< Hi ,
  Lo1 is Lo + 1 ,
  seq_add(Lo1, Hi, [Lo|Acc], Z).
seq_add(Lo, Hi, Acc, Acc) :-
  Lo > Hi.	

negate_sequence(C, [], Z) :-
  add_hi(C, Z).
negate_sequence(C, [X|Xs], Zs) :-
  C =:= X ,
  C1 is C + 1 ,
  negate_sequence(C1, Xs, Zs).
negate_sequence(C, [X|Xs], [C|Zs]) :-
  C < X ,
  C1 is C + 1 ,
  negate_sequence(C1, [X|Xs], Zs).

add_hi(C, []) :-
  C > 255.
add_hi(C, [C|Zs]) :-
  C =< 255 ,
  C1 is C + 1 ,
  add_hi(C1, Zs).

sequence_to_char_classes([], class(255, 0)).
sequence_to_char_classes([C|Cs], Zs):-
  sequence_to_char_classes(C, C, Cs, Zs).

sequence_to_char_classes(Lo, Hi, [], class(Lo, Hi)).
sequence_to_char_classes(Lo, Hi, [C|Cs], Zs) :-
  C =:= Hi + 1 ,
  sequence_to_char_classes(Lo, C, Cs, Zs).
sequence_to_char_classes(Lo, Hi, [C|Cs], alt(class(Lo, Hi), Zs)) :-
  C =\= Hi + 1 ,
  sequence_to_char_classes(C, C, Cs, Zs).

re_match(Ast, [String|ST], Rest):-
        Rest=[]; re_match1(Ast, ST, Rest).

re_match1(Ast, [String|ST], Rest):-
        re_match1(Ast, ST, Rest); String \= 97 -> Rest = [String|ST].

