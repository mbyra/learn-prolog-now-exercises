%% Chapter 2 Exercises

%% Exercise 2.1 
%% Which of the following pairs of terms unify? Where relevant, give the variable instantiations 
%% that lead to successful unification.

%% bread = bread           % true
%% ’Bread’ = bread         % false
%% ’bread’ = bread         % true
%% Bread = bread           % true
%% bread = sausage         % false
%% food(bread) = bread     % false
%% food(bread)  =  X       % true
%% food(X)  =  food(bread) % true
%% food(bread,X)  =  food(Y,sausage)            % true
%% food(bread,X,beer)  =  food(Y,sausage,X)     % false
%% food(bread,X,beer)  =  food(Y,kahuna_burger) % false
%% food(X)  =  X                                % true
%% meal(food(bread),drink(beer))  =  meal(X,Y)  % true
%% meal(food(bread),X)  =  meal(X,drink(beer))  % false


%% Exercise 2.2 
%% We are working with the following knowledge base:
   house_elf(dobby). 
   witch(hermione). 
   witch('McGonagall'). 
   witch(rita_skeeter). 
   magic(X):-  house_elf(X). 
   magic(X):-  wizard(X). 
   magic(X):-  witch(X).
%% Which of the following queries are satisfied? Where relevant, give all the variable 
%% instantiations that lead to success.

%% ?-  magic(house_elf).    % true, X = dobby
%% ?-  wizard(harry).       % false
%% ?-  magic(wizard).       % false
%% ?-  magic(’McGonagall’). % X = 'McGonagall'
%% ?-  magic(Hermione).     % Hermione = hermione

%% Draw the search tree for the query magic(Hermione) .

%% Exercise 2.3 
%% Here is a tiny lexicon (that is, information about individual words) and a mini grammar 
%% consisting of one syntactic rule (which defines a sentence to be an entity consisting of five 
%% words in the following order: a determiner, a noun, a verb, a determiner, a noun).

   word(determiner,a). 
   word(determiner,every). 
   word(noun,criminal). 
   word(noun,'big  kahuna  burger'). 
   word(verb,eats). 
   word(verb,likes). 
    
   sentence(Word1,Word2,Word3,Word4,Word5):- 
         word(determiner,Word1), 
         word(noun,Word2), 
         word(verb,Word3), 
         word(determiner,Word4), 
         word(noun,Word5).

%% What query do you have to pose in order to find out which sentences the grammar can generate? 
%% List all sentences that this grammar can generate in the order that Prolog will generate them in.

%% sentence(Word1,Word2,Word3,Word4,Word5).



%% Exercise 2.4 
%% Here are six Italian words:

%% astante , astoria , baratto , cobalto , pistola , statale .

%% They are to be arranged, crossword puzzle fashion, in the following grid:

%%    V1 V2 V3
%%    _  _  _
%% H1__________
%%    _  _  _  
%% H2__________
%%    _  _  _
%% H3__________
%%    _  _  _  

%% The following knowledge base represents a lexicon containing these words:
   word(astante,  a,s,t,a,n,t,e). 
   word(astoria,  a,s,t,o,r,i,a). 
   word(baratto,  b,a,r,a,t,t,o). 
   word(cobalto,  c,o,b,a,l,t,o). 
   word(pistola,  p,i,s,t,o,l,a). 
   word(statale,  s,t,a,t,a,l,e).
%% Write a predicate crossword/6 that tells us how to fill in the grid. The first three arguments 
%% should be the vertical words from left to right, and the last three arguments the horizontal 
%% words from top to bottom.

crossword(
   word(V1, V11, V12, V13, V14, V15, V16, V17),
   word(V2, V21, V22, V23, V24, V25, V26, V27),
   word(V3, V31, V32, V33, V34, V35, V36, V37),
   word(H1, H11, V12, H13, V22, H15, V32, H17),
   word(H2, H21, V14, H23, V24, H25, V34, H27),
   word(H3, H31, V16, H33, V26, H35, V36, H37)).




%% Chapter 2 Practical session

%% By this stage, you should have had your first taste of running Prolog programs. The purpose of 
%% the second practical session is to suggest two sets of keyboard exercises which will help you get
%% familiar with the way Prolog works. The first set has to do with unification, the second with 
%% proof search.

%% First of all, start up your Prolog interpreter. That is, get a screen displaying the usual 
%% “I’m ready to start” prompt, which probably looks something like:
%%    ?-
%% Verify your answers to Exercise 2.1, the unification examples. You don’t need to consult any 
%% knowledge bases, simply ask Prolog directly whether it is possible to unify the terms by using 
%% the built-in =/2 predicate. For example, to test whether food(bread,X) and food(Y,sausage) unify,
%% just type in
%%    food(bread,X)  =  food(Y,sausage).
%% and hit return.

%% You should also look at what happens when your Prolog implementation attempts to unify terms 
%% that can’t be unified because it doesn’t carry out an occurs check. For example, see what happens
%% when you give it the following query:
%%    g(X,Y)  =  Y.
%% If it handles such examples, try the trickier one mentioned in the text:
%%    X  =  f(X),  Y  =  f(Y),  X  =  Y.

%% Once you’ve experimented with that, it’s time to move on to something new. There is another 
%% built-in Prolog predicate for answering queries about unification, namely \=/2 (that is: the 
%% 2-place predicate \= ). This works in the opposite way to the =/2 predicate: it succeeds when its
%% two arguments do not unify. For example, the terms a and b do not unify, which explains the 
%% following dialogue:
%%    ?-  a  \=  b. 
%%    yes
%% Make sure you understand how \=/2 works by trying it out on (at least) the following examples. 
%% But do this actively, not passively. That is, after you type in an example, pause, and try to 
%% work out for yourself what Prolog is going to respond. Only then hit return to see if you are 
%% right.

%% a  \=  a                % false
%% ’a’  \=  a              % false
%% A  \=  a                % false
%% f(a)  \=  a             % true
%% f(a)  \=  A             % false
%% f(A)  \=  f(a)          % false
%% g(a,B,c)  \=  g(A,b,C)  % false
%% g(a,b,c)  \=  g(A,C)    % true
%% f(X)  \=  X             % false

%% Thus the \=/2 predicate is (essentially) the negation of the =/2 predicate: a query involving one
%% of these predicates will be satisfied when the corresponding query involving the other is not, 
%% and vice versa. This is the first example we have seen of a Prolog mechanism for handling 
%% negation. We discuss Prolog negation (and its peculiarities) in Chapter  10 .


%% It’s time to move on and introduce one of the most helpful tools in Prolog: trace . This is a 
%% built-in Prolog predicate that changes the way Prolog runs: it forces Prolog to evaluate queries 
%% one step at a time, indicating what it is doing at each step. Prolog waits for you to press 
%% return before it moves to the next step, so that you can see exactly what is going on. It was 
%% really designed to be used as a debugging tool, but it’s also helpful when you’re learning 
%% Prolog: stepping through programs using trace is an excellent way of learning how Prolog proof 
%% search works.

%% Let’s look at an example. In the text, we looked at the proof search involved when we made the 
%% query k(Y) to the following knowledge base:
   f(a). 
   f(b). 
    
   g(a). 
   g(b). 
    
   h(b). 
    
   k(X):-  f(X),  g(X),  h(X).

%% Suppose this knowledge base is in file proof.pl . We first consult it:
%%   ?-  [proof]. 
%%   yes
%% We then type trace , followed by a full stop, and hit return:
%%    ?-  trace. 
%%    yes
%% Prolog is now in trace mode, and will evaluate all queries step by step. For example, if we pose 
%% the query k(X) , and then hit return every time Prolog comes back with a ? , we obtain (something
%% like) the following:

%%    [trace]  2  ?-  k(X). 
%%          Call:  (6)  k(_G34)  ? 
%%          Call:  (7)  f(_G34)  ? 
%%          Exit:  (7)  f(a)  ? 
%%          Call:  (7)  g(a)  ? 
%%          Exit:  (7)  g(a)  ? 
%%          Call:  (7)  h(a)  ? 
%%          Fail:  (7)  h(a)  ? 
%%          Fail:  (7)  g(a)  ? 
%%          Redo:  (7)  f(_G34)  ? 
%%          Exit:  (7)  f(b)  ? 
%%          Call:  (7)  g(b)  ? 
%%          Exit:  (7)  g(b)  ? 
%%          Call:  (7)  h(b)  ? 
%%          Exit:  (7)  h(b)  ? 
%%          Exit:  (6)  k(b)  ? 
    
%%    X  =  b 
%%    yes
%% Study this carefully. That is, try doing the same thing yourself, and relate this output to the 
%% discussion of the example in the text, and in particular, to the nodes in the search tree. To get
%% you started, we’ll remark that the third line is where the variable in the query is (wrongly) 
%% instantiated to a . The first line marked fail is where Prolog realises it’s taken the wrong path
%% and starts to backtrack, and the line marked redo is where it tries alternatives for the goal 
%% f(_G34) .

%% While learning Prolog, use trace, and use it heavily. It’s a great way to learn. Oh yes: you also
%% need to know how to turn trace off. Simply type notrace (followed by a full stop) and hit return:
%%   ?-  notrace. 
%%   yes
