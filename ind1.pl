%Сливает два списка
append([],X,X):-!.
append([X1|Y1],Z,[X1|Y2]):-append(Y1,Z,Y2).

% Удаляем заданный элемент из списка
%
del(_,[],[]).
del(X,[X|Y],Z):- del(X,Y,Z).
del(X,[Y|L],[Y|L1]):- X \= Y, del(X,L,L1).

%Проверяем элементы двух списков
%
delete_list([],[]).
delete_list([X|Y],[X|Z]):-del(X,Y,Z1),delete_list(Z1,Z).

merge([],X,X).
merge(X,[],X).
merge(X1,Y1,Z):- delete_list(X1,X), delete_list(Y1,Y),
      append(X,Y,Z1), delete_list(Z1,Z).
