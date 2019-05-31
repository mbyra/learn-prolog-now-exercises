%% Chapter 5
len([],0). 
len([_|T],N) :- len(T,X),  N  is  X+1.

accLen([_|T],A,L) :- Anew  is  A+1,  accLen(T,Anew,L). 
accLen([],A,A).
leng(List,Length)  :-  accLen(List,0,Length).

accMax([H|T],A,Max)  :- 
	H  >  A, 
	accMax(T,H,Max). 
    
accMax([H|T],A,Max)  :- 
	H  =<  A, 
	accMax(T,A,Max). 

accMax([],A,A).

max(List,Max)  :- 
	List  =  [H|_], 
	accMax(List,H,Max).

%% Chapter 5 Exercises 
%% Exercise 5.1 How does Prolog respond to the following queries?
	%% X  =  3*4.
	%% X  is  3*4.
	%% 4  is  X.
	%% X  =  Y.
	%% 3  is  1+2.
	%% 3  is  +(1,2).
	%% 3  is  X+2.
	%% X  is  1+2.
	%% 1+2  is  1+2.
	%% is(X,+(1,2)).
	%% 3+2  =  +(3,2).
	%% *(7,5)  =  7*5.
	%% *(7,+(3,2))  =  7*(3+2).
	%% *(7,(3+2))  =  7*(3+2).
	%% 7*3+2  =  *(7,+(3,2)).
	%% *(7,(3+2))  =  7*(+(3,2)).
%% Exercise 5.2
%% 1. Define a 2-place predicate increment that holds only when its second argument is an integer 
%%    one larger than its first argument. For example, increment(4,5) should hold, but 
%%    increment(4,6) should not.
increment(X, Y) :- Y is X+1.

%% 2. Define a 3-place predicate sum that holds only when its third argument is the sum of the first
%%    two arguments. For example, sum(4,5,9) should hold, but sum(4,6,12) should not.
sum(X, Y, Z) :- Z is X + Y.

%% Exercise 5.3 
%% Write a predicate addone/2 whose first argument is a list of integers, and whose second argument 
%% is the list of integers obtained by adding 1 to each integer in the first list. E.g., the query
%% ?-  addone([1,2,7,2],X).
%% should give
%% X  =  [2,3,8,3]. 
addone([],[]).
addone([X|Xs], [Y|Ys]) :- Y is X + 1, addone(Xs, Ys).

%% Chapter 5 Practical session
%% 1. In the text we discussed the 3-place predicate accMax which returned the maximum of a list of 
%%    integers. By changing the code slightly, turn this into a 3-place predicate accMin which 
%%    returns the minimum of a list of integers.
accMin([],A,A).

accMin([H|T],A,Min) :- 
	H < A, 
	accMin(T,H,Min). 
    
accMin([H|T],A,Min) :- 
	H >= A, 
	accMin(T,A,Min). 

min([H|_],Min) :- 
	List  =  [H|_], 
	accMin(List,H,Min).

%% 2. In mathematics, an n-dimensional vector is a list of numbers of length n. For example, 
%%    [2,5,12] is a 3-dimensional vector, and [45,27,3,-4,6] is a 5-dimensional vector. One of the 
%%    basic operations on vectors is scalar multiplication . In this operation, every element of a 
%%    vector is multiplied by some number. For example, if we scalar multiply the 3-dimensional 
%%    vector [2,7,4] by 3 the result is the 3-dimensional vector [6,21,12] .
%%    Write a 3-place predicate scalarMult whose first argument is an integer, whose second argument
%%    is a list of integers, and whose third argument is the result of scalar multiplying the second
%%    argument by the first. For example, the query   
%%    ?-  scalarMult(3,[2,7,4],Result).
%%    should yield
%%    Result  =  [6,21,12]
scalarMult(_, [], []).
scalarMult(M, [X|Xs], [Y|Ys]) :- Y is X*3, scalarMult(M, Xs, Ys).

%% 3. Another fundamental operation on vectors is the dot product. This operation combines two 
%%    vectors of the same dimension and yields a number as a result. The operation is carried out as
%%    follows: the corresponding elements of the two vectors are multiplied, and the results added. 
%%    For example, the dot product of [2,5,6] and [3,4,1] is 6+20+6 , that is, 32 . 
%%    Write a 3-place predicate dot whose first argument is a list of integers, whose second 
%%    argument is a list of integers of the same length as the first, and whose third argument is 
%%    the dot product of the first argument with the second. For example, the query
%%    ?-  dot([2,5,6],[3,4,1],Result).
%%    should yield
%%    Result  =  32
calcDot([], [], A, A).
calcDot([X|Xs], [Y|Ys], A, R) :- NewA is A + X * Y, calcDot(Xs, Ys, NewA, R).
dot(X, Y, R) :- calcDot(X, Y, 0, R).