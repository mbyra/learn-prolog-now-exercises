%% Chapter 4


%% Chapter 4 Exercises


%% Exercise 4.1 
%% How does Prolog respond to the following queries?

%% [a,b,c,d]  =  [a,[b,c,d]].  %% false
%% [a,b,c,d]  =  [a|[b,c,d]].  %% true
%% [a,b,c,d]  =  [a,b,[c,d]].  %% false
%% [a,b,c,d]  =  [a,b|[c,d]].  %% true
%% [a,b,c,d]  =  [a,b,c,[d]].  %% false
%% [a,b,c,d]  =  [a,b,c|[d]].  %% true
%% [a,b,c,d]  =  [a,b,c,d,[]]. %% false
%% [a,b,c,d]  =  [a,b,c,d|[]]. %% true
%% []  =  _.      % true
%% []  =  [_].    % false
%% []  =  [_|[]]. % false


%% Exercise 4.2 
%% Which of the following are syntactically correct lists? If the representation is correct, how 
%% many elements does the list have?

%% [1|[2,3,4]] % correct, 4 
%% [1,2,3|[]] % correct, 3
%% [1|2,3,4] % not correct
%% [1|[2|[3|[4]]]] % correct, 4
%% [1,2,3,4|[]] % correct, 4
%% [[]|[]] % corrrect, 1
%% [[1,2]|4] % not correct
%% [[1,2],[3,4]|[5,6,7]] % correct, 5


%% Exercise 4.3 
%% Write a predicate second(X,List) which checks whether X is the second element of List .
second(X, [_, X | _]).


%% Exercise 4.4 
%% Write a predicate swap12(List1,List2) which checks whether List1 is identical to List2 , except 
%% that the first two elements are exchanged.
swap12([X, Y | Rest], [Y, X | Rest]).


%% Exercise 4.5 
%% Suppose we are given a knowledge base with the following facts:
   tran(eins,one). 
   tran(zwei,two). 
   tran(drei,three). 
   tran(vier,four). 
   tran(fuenf,five). 
   tran(sechs,six). 
   tran(sieben,seven). 
   tran(acht,eight). 
   tran(neun,nine).
%% Write a predicate listtran(G,E) which translates a list of German number words to the 
%% corresponding list of English number words. For example:
%%    listtran([eins,neun,zwei],X).
%% should give:
%%    X  =  [one,nine,two].
%% Your program should also work in the other direction. For example, if you give it the query
%%    listtran(X,[one,seven,six,two]).
%% it should return:
%%    X  =  [eins,sieben,sechs,zwei].
%% (Hint: to answer this question, first ask yourself “How do I translate the empty list of number 
%% words?”. That’s the base case. For non-empty lists, first translate the head of the list, then 
%% use recursion to translate the tail.)
listtran([], []).
listtran([WG | RestGerman], [WE | RestEnglish]) :- tran(WG, WE), listtran(RestGerman, RestEnglish).


%% Exercise 4.6 
%% Write a predicate twice(In,Out) whose left argument is a list, and whose right argument is a list
%% consisting of every element in the left list written twice. For example, the query
%%    twice([a,4,buggle],X).
%% should return
%%    X  =  [a,a,4,4,buggle,buggle]).
%% And the query
%%    twice([1,2,1,1],X).
%% should return
%%    X  =  [1,1,2,2,1,1,1,1].
%% (Hint: to answer this question, first ask yourself “What should happen when the first argument is
%% the empty list?”. That’s the base case. For non-empty lists, think about what you should do with 
%% the head, and use recursion to handle the tail.)
twice([], []).
twice([X | Xs], [X, X | Ys]) :- twice(Xs, Ys).


%% Exercise 4.7 
%% Draw the search trees for the following three queries:
%%    ?-  member(a,[c,b,a,y]). 
%%    ?-  member(x,[a,b,c]). 
%%    ?-  member(X,[a,b,c]). 



%% Chapter 4 Practical session


%% 1. Trace some examples, not involving variables, that succeed. For example, trace the query 
%%    a2b([a,a,a,a],[b,b,b,b]) and relate the output to the discussion in the text.
%% 2. Trace some simple examples that fail. Try examples involving lists of different lengths (such 
%%    as a2b([a,a,a,a],[b,b,b]) ) and examples involving symbols other than a and b (such as 
%%    a2b([a,c,a,a],[b,b,5,4]) ).
%% 3. Trace some examples involving variables. For example, try tracing a2b([a,a,a,a],X) and 
%%    a2b(X,[b,b,b,b]) .
%% 4. Make sure you understand what happens when both arguments in the query are variables. 
%%    For example, carry out a trace on the query a2b(X,Y) .
%% 5. Carry out a series of similar traces involving member2/2 . That is, carry out traces involving 
%%    simple queries that succeed (such as member2(a,[1,2,a,b]) ), simple queries that fail (such as 
%%    member2(z,[1,2,a,b]) ), and queries involving variables (such as member2(X,[1,2,a,b]) ). 
%%    In all cases, make sure that you understand why the recursion halts.
%% 
%% Tasks:
%% 1. Write a 3-place predicate combine1 which takes three lists as arguments and combines the 
%%    elements of the first two lists into the third as follows:
%%    ?-  combine1([a,b,c],[1,2,3],X). 
%%    X  =  [a,1,b,2,c,3] 
%%    ?-  combine1([f,b,yip,yup],[glu,gla,gli,glo],Result).   
%%    Result  =  [f,glu,b,gla,yip,gli,yup,glo]

combine1([], [], []).
combine1([X|Xs], [Y|Ys], [X,Y|RestResult]) :- combine1(Xs, Ys, RestResult).

%% 2. Now write a 3-place predicate combine2 which takes three lists as arguments and combines the 
%%    elements of the first two lists into the third as follows:
%%    ?-  combine2([a,b,c],[1,2,3],X).    
%%    X  =  [[a,1],[b,2],[c,3]]     
%%    ?-  combine2([f,b,yip,yup],[glu,gla,gli,glo],Result). 

combine2([], [], []).
combine2([X|Xs], [Y|Ys], [[X,Y]|RestResult]) :- combine2(Xs, Ys, RestResult).

%% 3. Finally, write a 3-place predicate combine3 which takes three lists as arguments and combines 
%%    the elements of the first two lists into the third as follows:
%%   ?-  combine3([a,b,c],[1,2,3],X).     
%%   X  =  [j(a,1),j(b,2),j(c,3)]    
%%   ?-  combine3([f,b,yip,yup],[glu,gla,gli,glo],R).     
%%   R  =  [j(f,glu),j(b,gla),j(yip,gli),j(yup,glo)]

combine3([], [], []).
combine3([X|Xs], [Y|Ys], [j(X,Y)|RestResult]) :- combine3(Xs, Ys, RestResult).