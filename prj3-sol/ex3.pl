transpose(M, T):-
  transpose(M, [], T).

transpose([], [], []).
transpose([], S, [[]|T]):-
  S \= [] ->
   (reverse(S, M), transpose(M, [], T)).
transpose([[]|MTail], S, T):-
  transpose(MTail, S, T).
transpose([[Item|Tail]|MTail], S, [[Item|NTail]|T]):-
  transpose(MTail, [Tail|S], [NTail|T]).

