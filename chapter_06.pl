%% Chapter 6

append([],L,L). 
append([H|T],L2,[H|L3])  :-  append(T,L2,L3).

prefix(P,L):-  append(P,_,L).
suffix(S,L):-  append(_,S,L).

sublist(SubL,L):-  suffix(S,L),  prefix(SubL,S).

naiverev([],[]). 
naiverev([H|T],R):-  naiverev(T,RevT),  append(RevT,[H],R).

accRev([H|T],A,R):-  accRev(T,[H|A],R). 
accRev([],A,A).

rev(L,R):-  accRev(L,[],R).

sublist(SubL,L):-  suffix(S,L),  prefix(SubL,S).

%% Chapter 6 Exercises
%% Exercise 6.1 
%% Let’s call a list doubled if it is made of two consecutive blocks of elements that are exactly 
%% the same. For example, [a,b,c,a,b,c] is doubled (it’s made up of [a,b,c] followed by [a,b,c]) and
%% so is [foo,gubble,foo,gubble] . On the other hand, [foo,gubble,foo] is not doubled. Write a 
%% predicate doubled(List) which succeeds when List is a doubled list.
doubled(List) :- append(Half, Half, List).

%% Exercise 6.2 
%% A palindrome is a word or phrase that spells the same forwards and backwards. For example, 
%% ‘rotator’, ‘eve’, and ‘nurses run’ are all palindromes. Write a predicate palindrome(List), which
%% checks whether List is a palindrome. For example, to the queries
%% ?-  palindrome([r,o,t,a,t,o,r]).
%% and
%% ?-  palindrome([n,u,r,s,e,s,r,u,n]).
%% Prolog should respond yes, but to the query
%% ?-  palindrome([n,o,t,h,i,s]).
%% it should respond no.
palindrome(List) :- rev(List, List).

%% Exercise 6.3 
%% Write a predicate toptail(InList,OutList) which says no if InList is a list containing fewer than
%% 2 elements, and which deletes the first and the last elements of InList and returns the result as
%% OutList, when InList is a list containing at least 2 elements. For example:
%% toptail([a],T). 
%% no 
%% toptail([a,b],T). 
%% T=[] 
%% toptail([a,b,c],T). 
%% T=[b]
%% (Hint: here’s where append/3 comes in useful.)
toptail(InList, OutList):- append([_|OutList],[_], InList).

toptail2([_|InTail], OutList) :- rev(InTail, [_|InTailReversed]), rev(InTailReversed, OutList). 

%% Exercise 6.4 
%% Write a predicate last(List,X) which is true only when List is a list that contains at least one 
%% element and X is the last element of that list. Do this in two different ways:

%% 1. Define last/2 using the predicate rev/2 discussed in the text.
last(List, X) :- rev(List, [X|_]).
%% 2. Define last/2 using recursion.
last2([X], X).
last2([_|Ys], X) :- last2(Ys, X). 

%% Exercise 6.5 
%% Write a predicate swapfl(List1,List2) which checks whether List1 is identical to List2, except 
%% that the first and last elements are exchanged. Here’s where append/3 could come in useful again,
%% but it is also possible to write a recursive definition without appealing to append/3 (or any 
%% other) predicates.

%% TODO wrong answer.
%% swapfl([First1|L1s], [First2|L2s]) :- 
%% 	rev(L1s, [Last1|ReversedL1s]), 
%% 	rev(L2s, [Last2|ReversedL2s]), 
%% 	ReversedL1s = ReversedL2s,
%% 	First1 = Last2,
%% 	First2 = Last1.


%% Exercise 6.6 
%% Here is an exercise for those of you who like logic puzzles.

%% There is a street with three neighbouring houses that all have a different colour, namely red, 
%% blue, and green. People of different nationalities live in the different houses and they all have
%% a different pet. Here are some more facts about them:

%% The Englishman lives in the red house.
%% The jaguar is the pet of the Spanish family.
%% The Japanese lives to the right of the snail keeper.
%% The snail keeper lives to the left of the blue house.
%% Who keeps the zebra? Don’t work it out for yourself: define a predicate zebra/1 that tells you 
%% the nationality of the owner of the zebra!

%% (Hint: Think of a representation for the houses and the street. Code the four constraints in 
%% Prolog. You may find member/2 and sublist/2 useful.)

%% red, blue and green should be on a list with some order
%% house(color, owner, pet) is an item on a 3 - element list street
zebra(ZebraOwner) :-
	Street = [_, _, _],
	member(house(_, ZebraOwner, zebra), Street),
	member(house(red, englishman, _), Street),
	member(house(_, spanish, jaguar), Street),
	sublist([house(_, _, snail), house(_, japanese, _)], Street),
	sublist([house(_, _, snail), house(blue, _, _)], Street).




%% Chapter 6 Practical session
%% The purpose of Practical Session 6 is to help you get more experience with list manipulation. 
%% We first suggest some traces for you to carry out, and then some programming exercises.

%% The following traces will help you get to grips with the predicates discussed in the text:

%% 1. Carry out traces of append/3 with the first two arguments instantiated, and the third argument 
%% 	  uninstantiated. For example, append([a,b,c],[[],[2,3],b],X). Make sure the basic pattern is 
%%    clear.
%% 		Call: (8) append([a, b, c], [[], [2, 3], b], _5682) ? creep % X = _5682 = [a | _5940]
%% 		Call: (9) append([b, c], [[], [2, 3], b], _5940) ? creep % [a | _5940] = [a, b | _5946]
%% 		Call: (10) append([c], [[], [2, 3], b], _5946) ? creep % [a, b | _5946] = [a, b, c | _5952]
%% 		Call: (11) append([], [[], [2, 3], b], _5952) ? creep % _5952 = [[], [2, 3], b]
%% 		Exit: (11) append([], [[], [2, 3], b], [[], [2, 3], b]) ? creep
%% 		Exit: (10) append([c], [[], [2, 3], b], [c, [], [2, 3], b]) ? creep
%% 		Exit: (9) append([b, c], [[], [2, 3], b], [b, c, [], [2, 3], b]) ? creep
%% 		Exit: (8) append([a, b, c], [[], [2, 3], b], [a, b, c, [], [2, 3], b]) ? creep
%% 
%% 2. Next, carry out traces on append/3 as used to split up a list, that is, with the first two 
%%    arguments given as variables, and the last argument instantiated. For example, 
%%    append(L,R,[foo,wee,blup]).
%% 
%%    Answer:
%% 		[trace]  ?- append(L,R,[foo,wee,blup]).
%% 		   Call: (8) append(_3788, _3790, [foo, wee, blup]) ? creep
%% 		   Exit: (8) append([], [foo, wee, blup], [foo, wee, blup]) ? creep
%% 		L = [],
%% 		R = [foo, wee, blup] ;
%% 		   Redo: (8) append(_3788, _3790, [foo, wee, blup]) ? creep
%% 		   Call: (9) append(_4062, _3790, [wee, blup]) ? creep
%% 		   Exit: (9) append([], [wee, blup], [wee, blup]) ? creep
%% 		   Exit: (8) append([foo], [wee, blup], [foo, wee, blup]) ? creep
%% 		L = [foo],
%% 		R = [wee, blup] ;
%% 		   Redo: (9) append(_4062, _3790, [wee, blup]) ? creep
%% 		   Call: (10) append(_4068, _3790, [blup]) ? creep
%% 		   Exit: (10) append([], [blup], [blup]) ? creep
%% 		   Exit: (9) append([wee], [blup], [wee, blup]) ? creep
%% 		   Exit: (8) append([foo, wee], [blup], [foo, wee, blup]) ? creep
%% 		L = [foo, wee],
%% 		R = [blup] ;
%% 		   Redo: (10) append(_4068, _3790, [blup]) ? creep
%% 		   Call: (11) append(_4074, _3790, []) ? creep
%% 		   Exit: (11) append([], [], []) ? creep
%% 		   Exit: (10) append([blup], [], [blup]) ? creep
%% 		   Exit: (9) append([wee, blup], [], [wee, blup]) ? creep
%% 		   Exit: (8) append([foo, wee, blup], [], [foo, wee, blup]) ? creep
%% 		L = [foo, wee, blup],
%% 		R = [] ;
%% 		   Redo: (11) append(_4074, _3790, []) ? creep
%% 		   Fail: (11) append(_4074, _3790, []) ? creep
%% 		   Fail: (10) append(_4068, _3790, [blup]) ? creep
%% 		   Fail: (9) append(_4062, _3790, [wee, blup]) ? creep
%% 		   Fail: (8) append(_3788, _3790, [foo, wee, blup]) ? creep
%% 		false.
%% 
%% 3. Carry out some traces on prefix/2 and suffix/2 . Why does prefix/2 find shorter lists first, 
%%    and suffix/2 longer lists first?
%% 
%%    Answer:
%%    Because of append implementation: append([H|T],L2,[H|L3])  :-  append(T,L2,L3).
%%    When finding suffixes, we start with empty list and our list, print our list, then we pop 
%%    front our list.
%%    When finding prefixes, we pass our list as first argument and "recurse down" until our list is
%%    empty, then we start to print out possibilities.
%% 
%% 4. Carry out some traces on sublist/2 . As we said in the text, via backtracking this predicate 
%%    generates all possible sublists, but as you’ll see, it generates several sublists more than 
%%    once. Do you understand why?
%% 
%%    Answer:
%%    All possible suffixes of list are considered and we take their prefixes. The subsequent 
%%    suffixes have non-empty intersections, so they share some common prefixes.
%% 
%% 5. Carry out traces on both naiverev/2 and rev/2 , and compare their behaviour.
%% 		[trace]  ?- naiverev([1,2,3],R).
%% 		   Call: (8) naiverev([1, 2, 3], _5284) ? creep
%% 		   Call: (9) naiverev([2, 3], _5526) ? creep
%% 		   Call: (10) naiverev([3], _5526) ? creep
%% 		   Call: (11) naiverev([], _5526) ? creep
%% 		   Exit: (11) naiverev([], []) ? creep
%% 		   Call: (11) append([], [3], _5534) ? creep
%% 		   Exit: (11) append([], [3], [3]) ? creep
%% 		   Exit: (10) naiverev([3], [3]) ? creep
%% 		   Call: (10) append([3], [2], _5540) ? creep
%% 		   Call: (11) append([], [2], _5524) ? creep
%% 		   Exit: (11) append([], [2], [2]) ? creep
%% 		   Exit: (10) append([3], [2], [3, 2]) ? creep
%% 		   Exit: (9) naiverev([2, 3], [3, 2]) ? creep
%% 		   Call: (9) append([3, 2], [1], _5284) ? creep
%% 		   Call: (10) append([2], [1], _5536) ? creep
%% 		   Call: (11) append([], [1], _5542) ? creep
%% 		   Exit: (11) append([], [1], [1]) ? creep
%% 		   Exit: (10) append([2], [1], [2, 1]) ? creep
%% 		   Exit: (9) append([3, 2], [1], [3, 2, 1]) ? creep
%% 		   Exit: (8) naiverev([1, 2, 3], [3, 2, 1]) ? creep
%% 		R = [3, 2, 1].
%%
%% 		[trace]  ?- rev([1,2,3],R).
%% 		   Call: (8) rev([1, 2, 3], _4638) ? creep
%% 		   Call: (9) accRev([1, 2, 3], [], _4638) ? creep
%% 		   Call: (10) accRev([2, 3], [1], _4638) ? creep
%% 		   Call: (11) accRev([3], [2, 1], _4638) ? creep
%% 		   Call: (12) accRev([], [3, 2, 1], _4638) ? creep
%% 		   Exit: (12) accRev([], [3, 2, 1], [3, 2, 1]) ? creep
%% 		   Exit: (11) accRev([3], [2, 1], [3, 2, 1]) ? creep
%% 		   Exit: (10) accRev([2, 3], [1], [3, 2, 1]) ? creep
%% 		   Exit: (9) accRev([1, 2, 3], [], [3, 2, 1]) ? creep
%% 		   Exit: (8) rev([1, 2, 3], [3, 2, 1]) ? creep
%% 		R = [3, 2, 1].


%% Now for some programming work:

%% 1. It is possible to write a one line definition of the member predicate by making use of 
%%    append/3 . Do so. How does this new version of member compare in efficiency with the standard 
%%    one? Write a predicate set(InList,OutList) which takes as input an arbitrary list, and returns
%%    a list in which each element of the input list appears only once. For example, the query 
%%    set([2,2,foo,1,foo,  [],[]],X).
%%    should yield the result
%%    X  =  [2,foo,1,[]].
%%    (Hint: use the member predicate to test for repetitions of items you have already found.)
member2(X, List) :- append(_, [X|_], List).


%% Acc is a list where we gather not repeating elements
%% Result is just to copy Acc at the end

setHelper([], Acc, Acc).

setHelper([X|Inlist], Acc, Result) :-
  member(X,Acc),
  setHelper(Inlist,Acc,Result).

setHelper([X|Inlist], Acc, Result) :-
  not(member(X,Acc)),
  setHelper(Inlist,[X|Acc],Result).

% result is reversed because we are prepending new not repeated elements
set(Inlist,Result) :-
  setHelper(Inlist,[], ReversedResult), 
  rev(ReversedResult, Result).



%% 2. We ‘flatten’ a list by removing all the square brackets around any lists it contains as 
%%    elements, and around any lists that its elements contain as elements, and so on, for all 
%%    nested lists. For example, when we flatten the list
%%    [a,b,[c,d],[[1,2]],foo]
%%    we get the list
%%    [a,b,c,d,1,2,foo]
%%    and when we flatten the list
%%    [a,b,[[[[[[[c,d]]]]]]],[[1,2]],foo,[]]
%%    we also get
%%    [a,b,c,d,1,2,foo].
%%    Write a predicate flatten(List,Flat) that holds when the first argument List flattens to the 
%%    second argument Flat . This should be done without making use of append/3 .

flattenHelper([], Acc, Acc).

%% Here we assume X is a list. We flatten the rest of InList, then flatten the X itself.
flattenHelper([X|InList], Acc, Result) :-
	flattenHelper(InList, Acc, TempResult),
	flattenHelper(X, TempResult, Result). %calls this or next case, based on X being a list or not 

%% Here we assume X is not a list so we just prepend it to the result.
flattenHelper(X, Acc, Result) :- 
	X \= [], 
	X \= [_|_], 
	Result = [X|Acc].

flatten(InList, OutList) :- flattenHelper(InList, [], OutList).


%% Ok, we’re now halfway through the book. And flattening a list is the Pons Asinorum of Prolog 
%% programming. Did you cross it ok? If so, great. Time to move on





