run:- consult('D:/���������/Desktop/4course/Prolog/database.pl'),
    retractall(student/2),retractall(subject/2), retractall(exam/3),
    menu.

menu:-repeat,
    write('���� ������'),nl,nl,
    write('1 - ������ � ���������'),nl,
    write('2 - ������ � ���������'),nl,
    write('3 - ������ �� �������'),nl,
    read(X),X>0, X<4, check(X).

check(1):-student_menu.
check(2):-subject_menu.
check(3):-exam_menu.

student_menu:-repeat, nl,
    write('������� ���������'),nl,nl,
    write('1 - ���������� ������ � ���������'),nl,
    write('2 - �������� ������ � �������'),nl,
    write('3 - ������� ������ �� �������'),nl,
    write('4 - ��������� ������� � ����'),nl,
    write('5 - ��������� � ������ ������'),nl,
    read(X), X>0, X<6, process(X).

subject_menu:-repeat, nl,
    write('������� ��������������� ���������'),nl,nl,
    write('1 - ���������� ������ � ���������'),nl,
    write('2 - �������� ������ � �������'),nl,
    write('3 - ������� ������ �� �������'),nl,
    write('4 - ��������� ������� � ����'),nl,
    write('5 - ��������� � ������ ������'),nl,
    read(X), X>0, X<6, process1(X).

exam_menu:-repeat, nl,
    write('������� ��������������� ������'),nl,nl,
    write('1 - ���������� ������ �� �������'),nl,
    write('2 - �������� ������ � �������'),nl,
    write('3 - ������� ������ �� �������'),nl,
    write('4 - ��������� ������� � ����'),nl,
    write('5 - ��������� � ������ ������'),nl,
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

addstudent:- write("�������� ��������"),nl,nl,
    write("id: "), read(Y),
    write("������� �.�.: "),
    read(X),
    checkidStudent(Y,F), F=0,
    assertz(student(X,Y));
    write("����� ID ��� ����������").

checkidStudent(X,F):- not(student(X,_)), F is 0; F is 1.

addsubject:- write("�������� �������"),nl,nl,
    write("id: "), read(X),
    write("��������: "),
    read(Y),
    checkSubject(X,Y,F), F=0,
    assertz(subject(X,Y));
    write("����� ID ��� ������� ��� ����������").

addexam:-
    write("�������� ������"),nl,nl,
    write("������� ������� �.�. ��������: "), read(X),
    write("�������� ��������: "), read(Y),
    write("������: "), read(Z),
    check(X,Y,F), F=0, findStudent(X,X1), findSubject(Y,Y1),
    assertz(exam(X1,Y1,Z));
    write("������, ����� ������ ���").

findStudent(X,X1):- student(X,Y),!, X1 is Y.
findSubject(X,X1):- subject(Y,X),!, X1 is Y.

check(X,Y,F):- student(X,_), subject(_,Y),!, F is 0;F is 1.
checkSubject(X,Y,F):- not(subject(X,_)),not(subject(_,Y)),F is 0;F is 1.

deletestudent:- write('������� ��������'),nl,nl,
    write('������� ��������: '), read(X),
    retract(student(X,Y)),
    retract(exam(Y,_,_)),
    write('������� ������ �� ��'),nl,nl,
    tell('D:/���������/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('������� ���������'),nl.

deletesubject:- write('������� �������'),nl,nl,
    write('������� �������: '), read(X),
    retract(subject(Y,X)),
    retract(exam(_,Y,_)),
    write('������� ������ �� ��'),nl,nl,
    tell('D:/���������/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('������� ���������'),nl.

deleteexam:- write('������� ������ � ����������� ��������'),nl,nl,
    write('��� �� ������ �������?'),nl,
    write('1 - ���������� ��������'),nl,
    write('2 - ���������� �������� �� ��������'),nl,
    read(X), X>0, X<3, process3(X).

process3(1):- deleteExamStudent.
process3(2):- deleteExamSubject.

deleteExamStudent:- write('������� ������ � ����������� ��������� ��������:' ),
    read(X), findStudent(X,X1), retractall(exam(X1,_,_)),
    write('������ ������� �� ��'),nl,nl,
    tell('D:/���������/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('������� ���������'),nl.

deleteExamSubject:- write('������� ������ � ����������� �� ���������� ��������:' ),
    read(X), findSubject(X,X1), retractall(exam(_,X1,_)),
    write('������ ������� �� ��'),nl,nl,
    tell('D:/���������/Desktop/4course/Prolog/database.pl'), listing(student),
    listing(subject),listing(exam),
    told, write('������� ���������'),nl.

dbsave:- tell('D:/���������/Desktop/4course/Prolog/database.pl'), listing(student),listing(subject),listing(exam),
    told, write('���� ���������'),nl,fail.
