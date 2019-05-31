%% Chapter 4

%% Chapter 4 Exercises

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