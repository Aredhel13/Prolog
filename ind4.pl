readlnfile(S):-readlnfile(S,0).
readlnfile(S,Answer):- R=0,see('D:/swi.txt'),readln(X), X\=[],!,writeln(X),
        ind4(X,S,R,Ans),R1 is (Answer+Ans),readlnfile(S,R1).
readlnfile(_,Answer):-writeln(Answer),seen.
%see(S),readln(X),

% indiv4(S,R):-
% see('D:/swi.txt'),readln(X),writeln(X),X\=[],ind4(X,S,R),seen.

ind4([H|T],S,R,Ans):-cmp(S,H),!, R1 is R+1,ind4(T,S,R1,Ans).
ind4([_|T],S,R,Ans):-ind4(T,S,R,Ans).
ind4([],_,R,Ans):-Ans is R.

cmp("",""):-!.
cmp(S,H):-string_length(S,P1),string_length(H,P2), P1=P2,!,
    sub_string(S,0,1,_,S1), del(S,S1,R1), del(H,S1,R2),
    string_length(R1,P3),string_length(R2,P4), P3=P4,!, cmp(R1,R2).

del(X,S,Y):- split_string(X,S,S,L), atomics_to_string(L,Y).

