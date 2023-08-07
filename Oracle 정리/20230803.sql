--ex6 ) outer join(left) : 왼쪽 테이블은 모두 포함하여 조인
--사원테이블과 부서테이블에서 부서번호가 같은 사원을 조인하시오 → 107레코드

--방법1(오라클 전용 구문)
select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--방법2(Ansi 표준)
select last_name, department_id, department_name
from employees 
left join departments using(department_id);

--ex7 ) outer join(right) : 오른쪽 테이블은 모두 포함하여 조인
--사원테이블과 부서테이블에서 부서번호가 같은 사원을 조인하시오 → 122 레코드

--방법1(오라클 전용 구문)
select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--방법2(Ansi 표준)
select last_name, department_id, department_name
from employees 
right join departments using(department_id);

--ex8 ) full join : 왼쪽, 오른쪽 테이블을 모두 포함하여 조인
사원테이블과 부서테이블에서 부서번호가 같은 사원을 조인하시오 → 123레코드

--방법1(오라클 전용 구문) : 없다
--방법2(Ansi표준)
select last_name, department_id, department_name
from employees
full join departments using(department_id);

--ex9 ) inner join : 두 개의 컬럼이 일치 하는 경우
--     부서ID와 매니저ID가 같은 사원을 연결 하시오 → 32 레코드
--     (관련 테이블 : departments, employees)
--        last_name     department_id   manager_id

--방법1(오라클 전용 구문)
select e.last_name, d.department_id, d.manager_id
from employees e, departments d
where e.department_id=d.department_id and e.manager_id=d.manager_id;

--방법2(Ansi표준)
select last_name, department_id, manager_id
from employees
inner join departments using(department_id, manager_id);

--ex10 ) 내용은 같은데 컬럼명이 다른 경우에 조인으로 연결하기
--     departments(location_id), locations2(loc_id)

--테이블 복사
create table locations2 as select * from locations;
select * from locations;
select * from locations2;
alter table locations2 rename column location_id to loc_id;
select * from locations2; -- 컬럼명이 바뀌었다

--방법1(오라클 전용 구문)
select d.department_id, l.city
from departments d, locations2 l
where d.location_id = l.loc_id;

--방법2(Ansi 표준)
select department_id, city
from departments
join locations2 on(location_id = loc_id); 

--방법3(Ansi 표준)
select department_id, city
from departments  d
join locations2  l  on(d.location_id = l.loc_id); 

--ex11 ) self 조인 : 자기 자신의 테이블과 조인하는 경우 사원과 관리자를 연결하시오

--사원번호   사원이름      관리자
----------------------------------
--   101      Kochhar      King

--  EMPLOYEES                          EMPLOYEES
-------------------------------------------------------------------
--employee_id, last_name(사원이름)        last_name(관리자)
--조건  employee_id = manager_id

select employee_id, manager_id, last_name from employees;  → e
select employee_id, last_name from employees; → m


--방법1
select  e.employee_id as 사원번호, 
e.last_name as 사원이름, 
m.last_name as 관리자
from employees e, employees m
where m.employee_id = e.manager_id; 

--방법2
select  e.employee_id as 사원번호, 
	e.last_name as 사원이름, 
	m.last_name as 관리자
from employees e
join employees m on(m.employee_id = e.manager_id);  

--ex12 ) cross join : 모든 행에 대해 가능한 모든 조합을 생성하는 조인
select * from countries, locations; → 575레코드

select * from countries cross join locations;

--ex13 ) Non Equijoin (넌 이큐조인) 
--컬럼값이 같은 경우가 아닌 범위에 속하는지 여부를 확인 할 때

on ( 컬럼명 between 컬럼명1 and 컬럼명2)

create table salgrade(
salvel varchar2(2),
lowst number,
highst number);  

insert into salgrade values('A', 20000, 29999);
insert into salgrade values('B', 10000, 19999);
insert into salgrade values('C', 0, 9999);
commit;

select * from salgrade;

select last_name, salary, salvel
from employees
join salgrade on(salary between lowst and highst)
order by salary desc;

--ex14 ) n(여러)개의 테이블은 조인
--업무ID 같은 사원들의 사원이름, 업무내용, 부서이름을 출력하시오
--(EMPLOYEES, JOBS, DEPARTMENTS 테이블을 조인)

--[분석]
--EMPLOYEES        JOBS      DEPARTMENTS
------------------------------------------------------------
--department_id      job_id      department_id
--job_id

select last_name, job_title, department_name
from employees
join departments using(department_id)
join jobs using(job_id);



create table employees_role as select * from employees where 1=0; 
-- ← 테이블 구조만 복사

select * from employees;
select * from employees_role;

insert into employees_role values(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(101, 'Nee', 'Ko', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(200, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(200, 'Nee', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
insert into employees_role values(300, 'GilDong', 'Hong', 'NKOCHHAR', '010-123-4567', '2009-03-01', 'IT_PROG', 23000.00, NULL, 100, 90);

commit;

--ex1 ) union 
--employee_id, last_name이 같을 경우 중복제거 하시오  → 110 레코드
select employee_id, last_name from employees
union
select employee_id, last_name from employees_role order by 1;

--ex2 ) union all
--employee_id, last_name이 같을 경우 중복을 허용 하시오 → 113 레코드
select employee_id, last_name from employees
union all
select employee_id, last_name from employees_role order by 1;

select salary  from employees where department_id=10
union all
select salary  from employees where department_id=30 order by 1;

--ex3 ) minus
--employees_role과 중복되는 레코드는 제거하고 employees에만 있는 사원명단을 구하시오
--(단, employee_id, last_name만 표시) → 106 레코드
select employee_id, last_name from employees
minus
select employee_id, last_name from employees_role;

--ex4 ) intersect
--employees와 employees_role에서 중복되는 레코드의 사원명단을 구하시오
--(단, employee_id, last_name만 표시)   → 1 레코드
select employee_id, last_name from employees
intersect
select employee_id, last_name from employees_role;

--[문제1] employees와 employees_role에서 레코드의 사원명단을 구하시오
--조건1) 사원이름, 업무ID, 부서ID을 표시하시오
--조건2) employees 에서는 부서ID가 10인 사원만 검색
--       employees_role에서는 업무ID가 IT_PROG만 검색
--조건3) 중복되는 레코드는 제거

select last_name, job_id, department_id
from employees where department_id=10
union
select last_name, job_id, department_id
from employees_role where department_id= 50;




--ex5 ) SET operator과 IN operator관계
--job_title이 'Stock Manager' 또는 'Programmer'인 사원들의 사원명과 job_title을 표시하시오

--last_name       job_title
--------------------------------
--Kaufling        StockManager
--Hunlod         Programmer
--           :


--방법1 (join, in연산자 이용)
select last_name, job_title
from employees
join jobs using(job_id)
where job_title in('Stock Manager', 'Programmer');


--방법2 (join, union 이용)
select last_name, job_title
from employees
join jobs using(job_id)
where job_title='Stock Manager'
union
select last_name, job_title
from employees
join jobs using(job_id)
where job_title='Programmer'
order by 2;

--ex9 ) 컬럼명이 다른 경우의 SET operator
--쿼리1과 쿼리2의 select 목록은 반드시동일(컬럼 개수, 데이터 타입)해야 하므로 이를 위해 Dummy Column을 사용할 수 있다.

select last_name, employee_id, hire_date
from employees
where department_id=20
union
select department_name, department_id, NULL
from departments
where department_id=20;