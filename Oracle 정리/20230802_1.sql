@@d:\Oracle\stExe_학생.sql;

select * from emp;

select sname, major, round(avr,2) as avr
from student
where major <> '화학';


select major, avr
from student
where major <> '화학' and avr >= 2.0;


select pno, pname, cno, cname
from professor
join course using(pno)
where pname = '송강';

select pno, pname, cno, cname
from professor
join course using(pno)
where cname like '%화학%';

select sno, sname, major, syear, cno, cname, result
from student
join score using(sno)
join course using(cno)
where major = '화학' and syear = '1';

select sno, sname, major, syear, cno, cname, result
from student
join score using(sno)
join course using(cno)
where major = '화학' and syear = '1' and cname = '일반화학';