%% Chapter 7 Exercises

%% Exercise 7.1 
%% Suppose we are working with the following DCG:
%% s --> foo,bar,wiggle. 
%% foo --> [choo].
%% foo --> foo,foo.
%% bar --> mar,zar.
%% mar --> me,my.
%% me --> [i].
%% my --> [am].
%% zar --> blar,car.
%% blar --> [a].
%% car --> [train].
%% wiggle --> [toot]. 
%% wiggle --> wiggle,wiggle.
%% Write down the ordinary Prolog rules that correspond to these DCG rules. What are the first three
%% responses that Prolog gives to the query s(X,[])?

s1(A, B) :- foo(A, C), bar(C, D), wiggle(D, B).
foo([choo | W], W).
foo(A, B) :- foo(A, C), foo(C, B).
bar(A, B) :- mar(A, C), zar(C, B).
mar(A, B) :- me(A, C), my(C, B).
me([i | W], W).
my([am | W], W).
zar(A, B) :- blar(A, C), car(C, B).
blar([a | W], W).
car([train | W], W).
wiggle([toot | W], W).
wiggle(A, B) :- wiggle(A, C), wiggle(C, B).

%% ?- s1(X,[]).
%% X = [choo, i, am, a, train, toot] ;
%% X = [choo, i, am, a, train, toot, toot] ;
%% X = [choo, i, am, a, train, toot, toot, toot] ;

%% Exercise 7.2 
%% The formal language a^n b^n 􏰄- 􏰉ε􏰊 consists of all the strings in a^n b^n except the empty string. 
%% Write a DCG that generates this language.

s2 --> l2, sEps, r2.
sEps --> [].
sEps --> l2, sEps, r2.
l2 --> [a].
r2 --> [b].

%% ?- s2(X,[]).
%% X = [a, b] ;
%% X = [a, a, b, b] ;
%% X = [a, a, a, b, b, b] ;

%% Exercise 7.3 
%% Let a^n b^2n be the formal language which contains all strings of the following form: an unbroken 
%% block of as of length n followed by an unbroken block of bs of length 2n, and nothing else. 
%% For example, abb, aabbbb, and aaabbbbbb belong to a^n b^2n, and so does the empty string. 
%% Write a DCG that generates this language.

s3 --> [].
s3 --> l3, s3, r3, r3.
l3  --> [a].
r3 --> [b].

%% ?- s3(X,[]).
%% X = [] ;
%% X = [a, b, b] ;
%% X = [a, a, b, b, b, b] ;


%% Chapter 7 Practical session

%% The purpose of Practical Session 7 is to help you get familiar with the DCGs, difference lists, 
%% and the relation between them, and to give you some experience in writing basic DCGs. As you will
%% learn next week, there is more to DCGs than the ideas just discussed. Nonetheless, what you have 
%% learned so far is certainly the core, and it is important that you are comfortable with the basic
%% ideas before moving on.
%% First some keyboard exercises:
%% 
%% 1. First, type in or download the simple append based recognizer discussed in the text, and then 
%%    run some traces. As you will see, we were not exaggerating when we said that the performance 
%%    of the append based grammar was very poor. Even for such simple sentences as 'The woman shot a
%%    man' you will see that the trace is very long, and very difficult to follow.
s4(Z) :- append(X,Y,Z), np4(X), vp4(Y).
np4(Z) :- append(X,Y,Z), det4(X), n4(Y).
vp4(Z) :- append(X,Y,Z), v4(X), np4(Y).
vp4(Z) :- v4(Z).
det4([the]).
det4([a]).
n4([woman]).
n4([man]).
v4([shoots]).

%% 2. Next, type in or download our second recognizer, the one based on difference lists, and run 
%%    more traces. As you will see, there is a dramatic gain in efficiency. Moreover, even if you 
%%    find the idea of difference lists a bit hard to follow, you will see that the traces are very 
%%    simple to understand, especially when compared with the monsters produced by the append based 
%%    implementation!

s5(X,Z) :- np5(X,Y), vp5(Y,Z).
np5(X,Z) :- det5(X,Y), n5(Y,Z).
vp5(X,Z) :- v5(X,Y), np5(Y,Z).
vp5(X,Z) :- v5(X,Z).
det5([the|W],W).
det5([a|W],W).
n5([woman|W],W).
n5([man|W],W).
v5([shoots|W],W).

%% 3. Next, type in or download the DCG discussed in the text. Type listing so that you can see what
%%    Prolog translates the rules to. How does your system translate rules of the form Det -> [the]? 
%%    That is, does it translate them to rules like det([the|X],X), or does is make use of rules 
%%    containing the ’C’predicate?

s6 --> np6, vp6.
np6 --> det6, n6.
vp6 --> v6, np6.
vp6 --> v6.
det6 --> [the].
det6 --> [a].
n6 --> [woman].
n6 --> [man].
v6 --> [shoots].

%% ?- listing(det6).
%% det6([the|A], A).
%% det6([a|A], A).

%% 4. Now run some traces. Apart from variable names, the traces you observe here should be very 
%%    similar to the traces you observed when running the difference list recognizer. In fact, you 
%%    will only observe any real differences if your version of Prolog uses a ’C’ based translation.
%% 
%% SWI-Prolog version 8.0.2 - no differences



%% And now it’s time to write some DCGs:
%% 1. The formal language aEven is very simple: it consists of all strings containing an even number
%%    of as, and nothing else. Note that the empty string ε belongs to aEven. Write a DCG that 
%%    generates aEven.

aEven --> [].
aEven --> aa, aa, aEven.
aa    --> [a].

%% ?- aEven(X,[]).
%% X = [] ;
%% X = [a, a] ;
%% X = [a, a, a, a] ;

%% 2. The formal language a^n b^2m c^2m d^n consists of all strings of the following form: an 
%%    unbroken block of as followed by an unbroken block of bs followed by an unbroken block of cs 
%%    followed by an unbroken block of ds, such that the a and d blocks are exactly the same length,
%%    and the c and d blocks are also exactly the same length and furthermore consist of an even 
%%    number of cs and ds respectively. For example, ε, abbccd, and aaabbbbccccddd all belong to 
%%    a^n b^2m c^2m d^n. Write a DCG that generates this language.

second --> bbccs.
second --> as, second, ds.
bbccs  --> [].
bbccs  --> bs, bs, bbccs, cs, cs.
as     --> [a].
bs     --> [b].
cs     --> [c].
ds     --> [d].

%% ?- second(X,[]).
%% X = [] ;
%% X = [b, b, c, c] ;
%% X = [b, b, b, b, c, c, c, c] ;
%% ?- second([a,a,b,b,c,c,d,d],[]).
%% true 
%% ?- second([a,a,b,c,d,d],[]).
%% false.


%% 3. The language that logicians call ‘propositional logic over the propositional symbols p, q, 
%%    and r’ can be defined by the following context free grammar:
%% 	  prop -> p
%% 	  prop -> q
%%    prop -> r
%%    prop -> 􏰋~ prop 
%% 	  prop -> (prop A prop)
%%    prop -> (prop V prop)
%% 	  prop -> (prop 􏰎-> prop) 
%% 
%%    Write a DCG that generates this language. Actually, because we don’t know about Prolog 
%%    operators yet, you will have to make a few rather clumsy looking compromises. For example, 
%%    instead of getting it to recognize
%% 􏰋   ~(p 􏰎-> q)
%%    you will have to get it recognize things like
%%    [not, ’(’, p, implies, q, ’)’]
%%    instead. But we will learn later how to make the output nicer, so write the DCG that accepts 
%%    a clumsy looking version of this language. Use 'or' for 􏰍V, and 'and' for A.

prop --> [p].
prop --> [q].
prop --> [r].
prop --> [not], prop.
prop --> ['('], prop, conj, prop, [')'].
conj --> [and].
conj --> [or].
conj --> [implies].

%% ?- prop([not, '(', p, implies, q, ')'] ,[]).
%% true.


