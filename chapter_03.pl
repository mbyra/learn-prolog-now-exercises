%% Chapter 3 Exercises

%% Exercise 3.1 
%% In the text, we discussed the predicate
  descend(X,Y)  :-  child(X,Y). 
  descend(X,Y)  :-  child(X,Z), descend(Z,Y).
%% Suppose we reformulated this predicate as follows:

child(anna, maria).
child(maria, jasia).
child(jasia, oleksa).

   %% descend(X,Y)  :-  child(X,Y). 
   %% descend(X,Y)  :-  descend(X,Z), descend(Z,Y).
%% Would this be problematic?
%% 
%% Answer:
%% yes - infinite recursion.


%% Exercise 3.2 
%% Do you know these wooden Russian dolls (Matryoshka dolls) where the smaller ones are contained in
%% bigger ones? Here is a schematic picture:

%% |-------------katarina-----|
%% ||---------------olga-----||
%% |||-------------natasha--|||
%% ||||--------------irina-||||
%% ||||                    ||||
%% ||||                    ||||
%% ||||--------------------||||
%% |||----------------------|||
%% ||------------------------||
%% |--------------------------|

%% First, write a knowledge base using the predicate directlyIn/2 which encodes which doll is 
%% directly contained in which other doll. Then, define a recursive predicate in/2 , that tells us 
%% which doll is (directly or indirectly) contained in which other dolls. For example, the query 
%% in(katarina,natasha) should evaluate to true, while in(olga,  katarina) should fail.
directlyIn(irina, natasha).
directlyIn(natasha, olga).
directlyIn(olga, katarina).

in(X, Y) :- directlyIn(X,Y).
in(X, Y) :- directlyIn(X, Z), in(Z, Y).


%% Exercise 3.3 
%% We have the following knowledge base:
   directTrain(saarbruecken,dudweiler). 
   directTrain(forbach,saarbruecken). 
   directTrain(freyming,forbach). 
   directTrain(stAvold,freyming). 
   directTrain(fahlquemont,stAvold). 
   directTrain(metz,fahlquemont). 
   directTrain(nancy,metz).
%% That is, this knowledge base holds facts about towns it is possible to travel between by taking 
%% a direct train. But of course, we can travel further by chaining together direct train journeys. 
%% Write a recursive predicate travelFromTo/2 that tells us when we can travel by train between two 
%% towns. For example, when given the query
   %% travelFromTo(nancy,saarbruecken).
%% it should reply yes.

travelFromTo(From, To) :- directTrain(From, To).
travelFromTo(From, To) :- directTrain(From, Mid), travelFromTo(Mid, To).


%% Exercise 3.4 
%% Define a predicate greater_than/2 that takes two numerals in the notation that we introduced in 
%% the text (that is, 0, succ(0), succ(succ(0)), and so on) as arguments and decides whether the 
%% first one is greater than the second one. For example:
   %% ?-  greater_than(succ(succ(succ(0))),succ(0)). 
   %% yes 
   %% ?-  greater_than(succ(succ(0)),succ(succ(succ(0)))). 
   %% no

numeral(0).  
numeral(succ(X))  :-  numeral(X).

greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :- greater_than(X, Y).


%% Exercise 3.5 
%% Binary trees are trees where all internal nodes have exactly two children. The smallest binary 
%% trees consist of only one leaf node. We will represent leaf nodes as leaf(Label). For instance, 
%% leaf(3) and leaf(7) are leaf nodes, and therefore small binary trees. Given two binary trees B1 
%% and B2 we can combine them into one binary tree using the functor tree/2 as follows: tree(B1,B2).
%% So, from the leaves leaf(1) and leaf(2) we can build the binary tree tree(leaf(1),leaf(2)). And 
%% from the binary trees tree(leaf(1),leaf(2)) and leaf(4) we can build the binary tree 
%% tree(tree(leaf(1),  leaf(2)),leaf(4)).
%% 
%% Now, define a predicate swap/2 , which produces the mirror image of the binary tree that is its 
%% first argument. For example:
   %% ?-  swap(tree(tree(leaf(1),  leaf(2)),  leaf(4)),T). 
   %% T  =  tree(leaf(4),  tree(leaf(2),  leaf(1))). 
   %% yes

swap(leaf(X), leaf(X)).
swap(tree(X,Y), tree(Y1,X1)) :-
    swap(X,X1),
    swap(Y,Y1).



%% Chapter 3 Practical session
%% By now, you should feel more at home with writing and running basic Prolog programs. In this 
%% practical session we first suggest two series of keyboard exercises which will help you get 
%% familiar with recursive definitions in Prolog, and then give you some programming problems to 
%% solve.

%% First the keyboard exercises. As recursive programming is so fundamental to Prolog, it is 
%% important that you have a firm grasp of what it involves. In particular, it is important that you
%% understand the process of variable instantiation when recursive definitions are used, and that 
%% you understand why the order of goals in rules can make the difference between termination and 
%% non-termination. So:

%% 1. Load descend1.pl , turn on trace , and pose the query descend(anne,emily) . Count how many 
%%    steps it takes Prolog to work out the answer (that is, how many times do you have to hit the 
%%    return key). Now turn trace off and pose the query descend(X,Y) . How many answers are there?
%% 2. Load descend2.pl . This is the variant of descend1.pl with the rule order reversed. Repeat the
%%    traces you have carried out for descend1.pl , and compare the results.
%% 3. Load descend3.pl . This is the variant of descend2.pl in which the goal order within the 
%%    recursive rule is switched, resulting in a left recursive rule. Because of this, even for such
%%    simple queries as descend(anne,bridget) , Prolog will not terminate. Step through an example, 
%%    using trace , to confirm this.
%% 4. Load descend4.pl . This is the variant of descend3.pl obtained by switching the rule order. 
%%    So descend4.pl also contains a left recursive rule, and does not terminate on all input. But 
%%    it does terminate on some input where descend3.pl does not. Which extra solutions does it find?

%% As we said in the text, goal ordering, not rule ordering is what is truly procedurally 
%% significant. But with non-terminating programs, rule ordering changes can have unexpected effects.
%% Recall the successor program discussed in the text (let’s call it numeral1.pl ):

%%    numeral(0). 
%%    numeral(succ(X))  :-  numeral(X).
%% Let’s swap the order of the two clauses, and call the result numeral2.pl :

%%    numeral(succ(X))  :-  numeral(X). 
%%    numeral(0).
%% Clearly the declarative, or logical, content of this program is exactly the same as the earlier 
%% version. But what are the procedural differences, if any?

%% Create a file containing numeral2.pl , load it, and investigate what happens if we pose queries 
%% about specific numerals. For example, suppose we ask:
%%    numeral(succ(succ(succ(0)))).
%% Do numeral1.pl and numeral2.pl behave in the same way on such input?

%% Second, look at what happens if we try to generate numerals, that is, suppose we pose the query
%%    numeral(X).
%% Do the programs display identical behaviour?


%% Here are some programs for you to try your hand at.

%% 1. Imagine that the following knowledge base describes a maze. The facts determine which points 
%%    are connected, that is, from which points you can get to which other points in one step. 
%%    Furthermore, imagine that all paths are one-way streets, so that you can only walk them in one 
%%    direction. So, you can get from point 1 to point 2, but not the other way round.
   connected(1,2). 
   connected(3,4). 
   connected(5,6). 
   connected(7,8). 
   connected(9,10). 
   connected(12,13). 
   connected(13,14). 
   connected(15,16). 
   connected(17,18). 
   connected(19,20). 
   connected(4,1). 
   connected(6,3). 
   connected(4,7). 
   connected(6,11). 
   connected(14,9). 
   connected(11,15). 
   connected(16,12). 
   connected(14,17). 
   connected(16,19).
%% Write a predicate path/2 that tells you from which points in the maze you can get to which other 
%% points when chaining together connections given in the above knowledge base. Can you get from 
%% point 5 to point 10? Which other point can you get to when starting at point 1? And which points 
%% can be reached from point 13?

path(X,Y) :- connected(X,Y).
path(X,Y) :- connected(X,Z), path(Z, Y).

%% ?- path(5,10).
%% true

%% ?- path(1,X).
%% X = 2 ;
%% false.

%% ?- path(13,X).
%% X = 14 ;
%% X = 9 ;
%% X = 17 ;
%% X = 10 ;
%% X = 18 ;
%% false.

%% 2. We are given the following knowledge base of travel information:
   byCar(auckland,hamilton). 
   byCar(hamilton,raglan). 
   byCar(valmont,saarbruecken). 
   byCar(valmont,metz). 
    
   byTrain(metz,frankfurt). 
   byTrain(saarbruecken,frankfurt). 
   byTrain(metz,paris). 
   byTrain(saarbruecken,paris). 
    
   byPlane(frankfurt,bangkok). 
   byPlane(frankfurt,singapore). 
   byPlane(paris,losAngeles). 
   byPlane(bangkok,auckland). 
   byPlane(singapore,auckland). 
   byPlane(losAngeles,auckland).
%% Write a predicate travel/2 which determines whether it is possible to travel from one place to 
%% another by chaining together car, train, and plane journeys. For example, your program should 
%% answer yes to the query travel(valmont,raglan).

travel(From, To) :- byCar(From, To) ; byTrain(From, To); byPlane(From, To).
travel(From, To) :- (byCar(From, Mid); byTrain(From, Mid); byPlane(From, Mid)), travel(Mid, To).


%% 3. So, by using travel/2 to query the above database, you can find out that it is possible to go 
%%    from Valmont to Raglan. If you are planning such a voyage, that’s already something useful to 
%%    know, but you would probably prefer to have the precise route from Valmont to Raglan. Write a 
%%    predicate travel/3 which tells you which route to take when travelling from one place to 
%%    another.
%%    For example, the program should respond
%%    X  =  go(valmont,metz, 
%%                  go(metz,paris, 
%%                        go(paris,losAngeles)))
%%    to the query travel(valmont,losAngeles,X) .

travel(From, To, go(From, To)) :- byCar(From, To) ; byTrain(From, To); byPlane(From, To).
travel(From, To, go(From, Mid, G)) :- 
   (byCar(From, Mid) ; byTrain(From, Mid); byPlane(From, Mid)), 
   travel(Mid, To, G).

%% 4. Extend the predicate travel/3 so that it not only tells you the route to take to get from one 
%%    place to another, but also how you have to travel. That is, the new program should let us know,
%%    for each stage of the voyage, whether we need to travel by car, train, or plane.

travelVia(From, To, go(byCar(From, To))) :- byCar(From, To).
travelVia(From, To, go(byTrain(From, To))) :- byTrain(From, To).
travelVia(From, To, go(byPlane(From, To))) :- byPlane(From, To).

travelVia(From, To, go(byCar(From, Mid), G)) :- byCar(From, Mid), travelVia(Mid, To, G).
travelVia(From, To, go(byTrain(From, Mid), G)) :- byTrain(From, Mid), travelVia(Mid, To, G).
travelVia(From, To, go(byPlane(From, Mid), G)) :- byPlane(From, Mid), travelVia(Mid, To, G).




