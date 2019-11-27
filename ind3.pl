append([],X,X):-!.
append([X1|Y1],Z,[X1|Y2]):-append(Y1,Z,Y2).

del_znak(X,Y,Z):-split_string(X,Y,Y,L), atomics_to_string(L,Z).

union1(X,Y,Z):-split_string(X,"","",L1),split_string(Y,"","",L2),
    append(L1,L2,L),atomics_to_string(L,Z).

Arifmetic(X):-string_length(X,P),P<1,!.

arifmetic(X):- S="+", sub_string(X,Y,1,_,S),Y1 is Y-1,Y1>=0,!,
    sub_string(X,Y1,1,_,S1), atom_number(S1,X1), X1>=0,X1=<9,!,
    Y2 is Y1+2, sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!,
    R is X1+X2, write(X1),write(S),write(X2),write("="),writeln(R),
    sub_string(X,0,Y2,_,Z1), del_znak(Z1,+,Z),sub_string(X,Y2,_,0,Z2),
    union1(Z,Z2,Z3),arifmetic(Z3).

arifmetic(X):- S="-", sub_string(X,Y,1,_,S),Y1 is Y-1,Y1>=0,!,
    sub_string(X,Y1,1,_,S1),atom_number(S1,X1), X1>=0,X1=<9,!,
    Y2 is Y1+2, sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!,
    R is X1-X2, write(X1),write(S),write(X2),write("="),writeln(R),
    sub_string(X,0,Y2,_,Z1), del_znak(Z1,-,Z),sub_string(X,Y2,_,0,Z2),
    union1(Z,Z2,Z3),arifmetic(Z3).


arifmetic(X):- S="*", sub_string(X,Y,1,_,S),Y1 is Y-1,Y1>=0,!,
    sub_string(X,Y1,1,_,S1),atom_number(S1,X1), X1>=0,X1=<9,!,
    Y2 is Y1+2, sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!,
    R is X1*X2, write(X1),write(S),write(X2),write("="),writeln(R),
    sub_string(X,0,Y2,_,Z1), del_znak(Z1,*,Z),sub_string(X,Y2,_,0,Z2),
    union1(Z,Z2,Z3),arifmetic(Z3).

arifmetic(X):- S="/", sub_string(X,Y,1,_,S),Y1 is Y-1,Y1>=0,!,
    sub_string(X,Y1,1,_,S1),atom_number(S1,X1), X1>=0,X1=<9,!,
    Y2 is Y1+2, sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!,
    R is X1/X2, write(X1),write(S),write(X2),write("="),writeln(R),
    sub_string(X,0,Y2,_,Z1), del_znak(Z1,/,Z),sub_string(X,Y2,_,0,Z2),
    union1(Z,Z2,Z3),arifmetic(Z3).

elem(S):- S>47,S<58.
% arifmetic(X):- S="-",
% sub_string(X,Y,1,_,S),string_length(X,P),Y+1<P,!,Y>0,!,Y1 is Y-1,
% sub_string(X,Y1,1,_,S1),
%    atom_number(S1,X1), X1>=0,X1=<9,!, Y2 is
%    Y1+2,sub_string(X,Y2,_,0,Z),
%    sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!, R is
%    X1-X2,
%    write(X1),write(S),write(X2),write("="),writeln(R),arifmetic(Z).

% arifmetic(X):- S="*",
% sub_string(X,Y,1,_,S),string_length(X,P),Y+1<P,!,Y>0,!,Y1 is Y-1,
% sub_string(X,Y1,1,_,S1),
%    atom_number(S1,X1),X1>=0,X1=<9,!, Y2 is
%    Y1+2,sub_string(X,Y2,_,0,Z),
%    sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!, R is
%    X1*X2,
%    write(X1),write(S),write(X2),write("="),writeln(R),arifmetic(Z).

% arifmetic(X):- S="/",
% sub_string(X,Y,1,_,S),string_length(X,P),Y+1<P,!,Y>0,!,Y1 is Y-1,
% sub_string(X,Y1,1,_,S1),
%    atom_number(S1,X1),X1>=0,X1=<9,!, Y2 is
%    Y1+2,sub_string(X,Y2,_,0,Z),
%    sub_string(X,Y2,1,_,S2),atom_number(S2,X2),X2>=0,X2=<9,!, R is
%    X1/X2,
%    write(X1),write(S),write(X2),write("="),writeln(R),arifmetic(Z).
%

%split_list(X,L):-string_length(X,P),P=0,!,write(L).
%split_list(X,L):-sub_string(X,0,1,_,S), split_string(S,"","",L1),
%   sub_string(X,1,_,0,S1),sub_string(S1,0,1,_,S2),
%   split_string(S2,"","",L2),
%    append(L1,L2,L3), append(L3,L,Z),
%    sub_string(S1,1,_,0,Y),split_list(Y,Z).

reverse1([],[]).
reverse1([X|Y],Z):-reverse(Y,T),append(T,[X],Z).


split_list2(X,L):-sub_string(X,0,1,_,S), split_string(S,"","",L1),
   sub_string(X,1,_,0,S1), append(L1,L,Z),write(Z),split_list2(S1,Z).
split_list2(X,L):-string_length(X,P),P=1,!,reverse1(L,L1), L1=L.




add_dot("",_,[]).
add_dot(X,I,Y):-string_length(X,P), I>=P,!.
add_dot(X,I,Y):-sub_string(X,I,1,_,S), split_string(S,"","",L1),
    split_string(" ","","",L2), append(L1,L2,L3),
    append(L3,Y,Y1),I1 is I+1, add_dot(X,I1,Y1).


string2charlist("", [ ]):- !.
string2charlist(Str, [H|T]):-
    frontchar(Str, H, Str_Rest),
    string2charlist(Str_Rest, T).
