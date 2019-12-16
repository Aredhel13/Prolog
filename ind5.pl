run:- consult('D:/Системная/Desktop/4course/Prolog/database.pl'),
    retractall(student/2),retractall(subject/2), retractall(exam/3),
    menu.

menu:-repeat,
    write('База данных'),nl,nl,
    write('1 - Данные о студентах'),nl,
    write('2 - Данные о предметах'),nl,
    write('3 - Данные об оценках'),nl,
    read(X),X>0, X<4, check(X).

check(1):-student_menu.
check(2):-subject_menu.
check(3):-exam_menu.

student_menu:-repeat, nl,
    write('Таблица студентов'),nl,nl,
    write('1 - Посмотреть данные о студентах'),nl,
    write('2 - Добавить данные в таблицу'),nl,
    write('3 - Удалить данные из таблицы'),nl,
    write('4 - Сохранить таблицу в файл'),nl,
    write('5 - Вернуться к выбору данных'),nl,
    read(X), X>0, X<6, process(X).

subject_menu:-repeat, nl,
    write('Таблица экзаменационных предметов'),nl,nl,
    write('1 - Посмотреть данные о предметах'),nl,
    write('2 - Добавить данные в таблицу'),nl,
    write('3 - Удалить данные из таблицы'),nl,
    write('4 - Сохранить таблицу в файл'),nl,
    write('5 - Вернуться к выбору данных'),nl,
    read(X), X>0, X<6, process1(X).

exam_menu:-repeat, nl,
    write('Таблица экзаменационных оценок'),nl,nl,
    write('1 - Посмотреть данные об оценках'),nl,
    write('2 - Добавить данные в таблицу'),nl,
    write('3 - Удалить данные из таблицы'),nl,
    write('4 - Сохранить таблицу в файл'),nl,
    write('5 - Вернуться к выбору данных'),nl,
    read(X), X>0, X<6, process2(X).


process(1):-showtableStudent.
process(2):-addstudent.
process(3):-deletestudent.
process(4):-dbsave.
process(5):-menu.


process1(1):-showtableSubject.
process1(2):-addsubject.
process1(3):-deletesubject.
process1(4):-dbsave.
process1(5):-menu.


process2(1):-showtableExam.
process2(2):-addexam.
process2(3):-deleteexam.
process2(4):-dbsave.
process2(5):-menu.


showtableStudent:- write("Name"),tab(16),write("ID"), nl,nl,writeStudent.
writeStudent:- student(X,Y),write(X),tab(10),write(Y),tab(15), nl,fail.

showtableSubject:- write("ID"),tab(10),write("Subject name"),tab(20), nl,nl,
    writeSubject.
writeSubject:- subject(X,Y),write(X),tab(11),write(Y), nl,fail.

showtableExam:- write("ID"),tab(20),write("Subject name"),tab(15),
    write("Exam grade"), nl, nl,writeExam.

writeExam:- exam(X,Y,Z),student(Y1,X),write(Y1),tab(11),subject(Y,Y2),write(Y2),
    tab(20), write(Z), nl,fail.

addstudent:- write("Добавить студента"),nl,nl,
    write("id: "), read(Y),
    write("Фамилия И.О.: "),
    read(X),
    checkidStudent(Y,F), F=0,
    assertz(student(X,Y));
    write("Такой ID уже существует").

checkidStudent(X,F):- not(student(X,_)), F is 0; F is 1.

addsubject:- write("Добавить предмет"),nl,nl,
    write("id: "), read(X),
    write("Название: "),
    read(Y),
    checkSubject(X,Y,F), F=0,
    assertz(subject(X,Y));
    write("Такой ID или предмет уже существует").

addexam:-
    write("Добавить оценку"),nl,nl,
    write("Введите фамилию И.О. студента: "), read(X),
    write("Название предмета: "), read(Y),
    write("Оценка: "), read(Z),
    check(X,Y,F), F=0, findStudent(X,X1), findSubject(Y,Y1),
    assertz(exam(X1,Y1,Z));
    write("Ошибка, таких данных нет").

findStudent(X,X1):- student(X,Y),!, X1 is Y.
findSubject(X,X1):- subject(Y,X),!, X1 is Y.

check(X,Y,F):- student(X,_), subject(_,Y),!, F is 0;F is 1.
checkSubject(X,Y,F):- not(subject(X,_)),not(subject(_,Y)),F is 0;F is 1.

deletestudent:- write('Удалить студента'),nl,nl,
    write('Укажите студента: '), read(X),
    retract(student(X,Y)),
    retract(exam(Y,_,_)),
    write('Студент удален из БД'),nl,nl,
    tell('D:/Системная/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('Таблица обновлена'),nl.

deletesubject:- write('Удалить предмет'),nl,nl,
    write('Укажите предмет: '), read(X),
    retract(subject(Y,X)),
    retract(exam(_,Y,_)),
    write('Предмет удален из БД'),nl,nl,
    tell('D:/Системная/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('Таблица обновлена'),nl.

deleteexam:- write('Удалить данные о результатах экзамена'),nl,nl,
    write('Что вы хотите удалить?'),nl,
    write('1 - Результаты студента'),nl,
    write('2 - Результаты экзамена по предмету'),nl,
    read(X), X>0, X<3, process3(X).

process3(1):- deleteExamStudent.
process3(2):- deleteExamSubject.

deleteExamStudent:- write('Удалить данные о результатах следущего студента:' ),
    read(X), findStudent(X,X1), retractall(exam(X1,_,_)),
    write('Данные удалены из БД'),nl,nl,
    tell('D:/Системная/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('Таблица обновлена'),nl.

deleteExamSubject:- write('Удалить данные о результатах по следующему предмету:' ),
    read(X), findSubject(X,X1), retractall(exam(_,X1,_)),
    write('Данные удалены из БД'),nl,nl,
    tell('D:/Системная/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('Таблица обновлена'),nl.

dbsave:- tell('D:/Системная/Desktop/4course/Prolog/database.pl'), listing(student),listing(subject),listing(exam),
    told, write('База сохранена'),nl,fail.
