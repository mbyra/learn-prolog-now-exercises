dziecko(jasio, ewa, jan).
dziecko(stasio, ewa, jan).
dziecko(basia, anna, piotr).
dziecko(jan, ela, jakub).

wnuczek(X, Y) :- dziecko(X, Z, _), dziecko(Z, Y, _).
wnuczek(X, Y) :- dziecko(X, _, U), dziecko(U, Y, _).
wnuczek(X, Y) :- dziecko(X, Z, _), dziecko(Z, _, Y).
wnuczek(X, Y) :- dziecko(X, _, U), dziecko(U, _, Y).

%% Predykaty z symbolami funkcyjnymi
%% dziecko(jakasnazwa(X), ela, jakub) :- dziecko(X, ela, jakub).

woman(mia). 
woman(jody). 
woman(yolanda). 

loves(vincent,mia). 
loves(marsellus,mia). 
loves(pumpkin,honey_bunny). 
loves(honey_bunny,pumpkin).

jealous(X,Y):-  loves(X,Z),  loves(Y,Z).

%% and(big(burger),kahuna(burger))

wizard(ron). 
hasWand(harry). 
quidditchPlayer(harry). 
wizard(X):-  hasBroom(X),  hasWand(X). 
hasBroom(X):-  quidditchPlayer(X).

word(determiner,a). 
word(determiner,every). 
word(noun,criminal). 
word(noun, 'big  kahuna  burger'). 
word(verb,eats). 
word(verb,likes). 

sentence(Word1,Word2,Word3,Word4,Word5):- 
     word(determiner,Word1), 
     word(noun,Word2), 
     word(verb,Word3), 
     word(determiner,Word4), 
     word(noun,Word5).



word(astante,  a,s,t,a,n,t,e). 
word(astoria,  a,s,t,o,r,i,a). 
word(baratto,  b,a,r,a,t,t,o). 
word(cobalto,  c,o,b,a,l,t,o). 
word(pistola,  p,i,s,t,o,l,a). 
word(statale,  s,t,a,t,a,l,e).


crossword(
	word(V1, V11, V12, V13, V14, V15, V16, V17),
	word(V2, V21, V22, V23, V24, V25, V26, V27),
	word(V3, V31, V32, V33, V34, V35, V36, V37),
	word(H1, H11, V12, H13, V22, H15, V32, H17),
	word(H2, H21, V14, H23, V24, H25, V34, H27),
	word(H3, H31, V16, H33, V26, H35, V36, H37)).

f(a). 
f(b). 

g(a). 
g(b). 

h(b). 

k(X):-  f(X),  g(X),  h(X).


p :- p.

directlyIn(irina, natasha).
directlyIn(natasha, olga).
directlyIn(olga, katarina).

in(X, Y) :- directlyIn(X,Y).
in(X, Y) :- directlyIn(X, Z), in(Z, Y).

directTrain(saarbruecken,dudweiler). 
directTrain(forbach,saarbruecken). 
directTrain(freyming,forbach). 
directTrain(stAvold,freyming). 
directTrain(fahlquemont,stAvold). 
directTrain(metz,fahlquemont). 
directTrain(nancy,metz).

travelFromTo(From, To) :- directTrain(From, To).
travelFromTo(From, To) :- directTrain(From, Mid), travelFromTo(Mid, To).

numeral(0).  
numeral(succ(X))  :-  numeral(X).

greater_than(succ(X), 0).
greater_than(succ(X), succ(Y)) :- greater_than(X, Y).

%% leaf(X).
%% tree(leaf(X), leaf(Y)).
%% tree(leaf(X), tree(Y)).
%% tree(tree(Y))

%% swap(leaf(X), leaf(X)).
swap(leaf(X), leaf(X)).
swap(tree(X,Y), tree(Y1,X1)) :-
    swap(X,X1),
    swap(Y,Y1).



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

path(X,Y) :- connected(X,Y).
path(X,Y) :- connected(X,Z), path(Z, Y).


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

%% travel(From, To) :- byCar(From, To) ; byTrain(From, To); byPlane(From, To).
%% travel(From, To) :- (byCar(From, Mid); byTrain(From, Mid); byPlane(From, Mid)), travel(Mid, To).

%% travel(From, To, go(From, To)) :- byCar(From, To) ; byTrain(From, To); byPlane(From, To).
%% travel(From, To, go(From, Mid, G)) :- 
%% 	(byCar(From, Mid) ; byTrain(From, Mid); byPlane(From, Mid)), 
%% 	travel(Mid, To, G).


travel(From, To, go(byCar(From, To))) :- byCar(From, To).
travel(From, To, go(byTrain(From, To))) :- byTrain(From, To).
travel(From, To, go(byPlane(From, To))) :- byPlane(From, To).

travel(From, To, go(byCar(From, Mid), G)) :- byCar(From, Mid), travel(Mid, To, G).
travel(From, To, go(byTrain(From, Mid), G)) :- byTrain(From, Mid), travel(Mid, To, G).
travel(From, To, go(byPlane(From, Mid), G)) :- byPlane(From, Mid), travel(Mid, To, G).

a2b([],[]).
a2b([a|Ta],[b|Tb])  :-  a2b(Ta,Tb).

second(X,[_,X|_]).

swap([X1,X2|R],[X2,X1|R]).

tran(eins,one). 
tran(zwei,two). 
tran(drei,three). 
tran(vier,four). 
tran(fuenf,five). 
tran(sechs,six). 
tran(sieben,seven). 
tran(acht,eight). 
tran(neun,nine). 

listtran([],[]).
listtran([X|XS],[Y|YS]) :- tran(X,Y), listtran(XS,YS).
%% listtran([eins,neun,zwei],X).

twice([],[]).
twice([X|Xs], [X,X|Ys]) :- twice(Xs,Ys).

member2(X,[X|_]). 
member2(X,[_|T])  :-  member2(X,T).




