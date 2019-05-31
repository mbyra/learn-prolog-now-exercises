%% Chapter 1 Exercises

%% Exercise 1.1 
%% Which of the following sequences of characters are atoms, which are variables, and which are 
%% neither?

%% vINCENT               % atom
%% Footmassage           % variable
%% variable23            % atom
%% Variable2000          % variable
%% big_kahuna_burger     % atom
%% ’big  kahuna  burger’ % atom
%% big  kahuna  burger   % neither
%% ’Jules’               % atom
%% _Jules                % variable
%% ’_Jules’              % atom

%% Exercise 1.2 
%% Which of the following sequences of characters are atoms, which are variables, which are complex 
%% terms, and which are not terms at all? Give the functor and arity of each complex term.

%% loves(Vincent,mia)               % complex term, functor: loves, arity: 2
%% ’loves(Vincent,mia)’             % atom
%% Butch(boxer)                     % neither
%% boxer(Butch)                     % complex term, functor: boxer, arity: 1
%% and(big(burger),kahuna(burger))  % complex term, functor: and, arity: 2
%% and(big(X),kahuna(X))            % complex term, functor: _and, arity: 2
%% _and(big(X),kahuna(X))           % neither
%% (Butch  kills  Vincent)          % neither
%% kills(Butch  Vincent)            % complex term, functor: kills, arity: 2
%% kills(Butch,Vincent              % neither

%% Exercise 1.3 
%% How many facts, rules, clauses, and predicates are there in the following knowledge base? What 
%% are the heads of the rules, and what are the goals they contain?

   woman(vincent). 
   woman(mia). 
   man(jules). 
   person(X):-  man(X);  woman(X). 
   loves(X,Y):-  father(X,Y). 
   father(Y,Z):-  man(Y),  son(Z,Y). 
   father(Y,Z):-  man(Y),  daughter(Z,Y).

   %% 3 facts, 4 rules, 7 clauses, 5 pedicates


%% Exercise 1.4 
%% Represent the following in Prolog:

%% Butch is a killer.
%% Mia and Marsellus are married.
%% Zed is dead.
%% Marsellus kills everyone who gives Mia a footmassage.
%% Mia loves everyone who is a good dancer.
%% Jules eats anything that is nutritious or tasty.
killer(butch).
married(mia, marsellus).
dead(zed).
kills(marsellus, footmassages(X, mia)).
loves(mia, X) :- dancer(X).
eats(jules, X) :- nutritious(X); tasty(X).


%% Exercise 1.5 
%% Suppose we are working with the following knowledge base:

   wizard(ron). 
   hasWand(harry). 
   quidditchPlayer(harry). 
   wizard(X):-  hasBroom(X),  hasWand(X). 
   hasBroom(X):-  quidditchPlayer(X).

%% How does Prolog respond to the following queries?

%% wizard(ron).       % true
%% witch(ron).        % undefiened procedure
%% wizard(hermione).  % false
%% witch(hermione).   % undefiened procedure
%% wizard(harry).     % true
%% wizard(Y).         % Y=ron; Y=harry
%% witch(Y).          % undefiened procedure





%% Chapter 1 Practical session

%% no tasks.