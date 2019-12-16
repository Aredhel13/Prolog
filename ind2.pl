member(X,[X|_]).
member(X,[_|Y]):- member(X,Y).


append([],X,X):-!.
append([X1|Y1],Z,[X1|Y2]):-append(Y1,Z,Y2).

left(X,Y,T):-append(_,[X,Y|_],T).

right(X,Y,T):-left(Y,X,T).

opposite(X,Y,[_,X,_,Y]).
opposite(X,Y,[X,_,Y,_]).
opposite(X,Y,[_,Y,_,X]).
opposite(X,Y,[Y,_,X,_]).

insert1(X,[],[X]).
insert1(X,[Y|Z],[X,Y|Z]).
insert1(X,[Y|Z],[Y|Z1]):-insert1(X,Z,Z1).


logic(A):- A=[[_,_],[_,_],[_,_],[_,_]],
    member([kuznecov,_],A),
    member([rezchikov,_],A),
    member([slesarev,_],A),
    member([tokarev,_],A),
    member([X1,slesar],A), not(X1=slesarev),
    member([X2,tokar],A),not(X2=tokarev),
    member([X3,rezchik],A),not(X3=rezchikov),
    member([X4,kuznec],A),not(X4=kuznecov),
    opposite([kuznecov,_],[_,slesar],A),
    opposite([rezchikov,_],[_,rezchik],A),
    right([_,tokar],[slesarev,_],A).


