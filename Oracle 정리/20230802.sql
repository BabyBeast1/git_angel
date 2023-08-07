--ex1 ) 사원테이블에서 급여의 평균을 구하시오
--조건) 소수 이하는 절삭, 세자리 마다 콤마(,) 표시
--       사원급여평균  6,461

select to_char(trunc(avg(salary), 0), '99,999') as 사원급여평균 from employees;

--ex2 ) 부서별 급여평균을 구하시오
--조건1) 소수 이하는 반올림
--조건2) 세자리 마다 콤마, 화폐 단위(￦)로 표시
--조건3) 부서별로 오름차순 정렬하시오 
--조건4) 평균급여가 5000이상인 부서만 표시하시오
 --     부서코드        평균급여
      --------------------------
 --       10             ￦8,600
 
 select department_id as 부서코드,
        to_char(round(avg(salary),0), 'L99,999,999') as 평균급여
 from employees
 group by department_id
 having avg(salary) >= 5000
 order by department_id asc;
 
 
-- ex3 ) 부서별 급여평균을 구해서 사원명(last_name), 부서별 급여평균을 출력하시오 - X
select last_name, avg(salary)
from employees
group by department_id;
-- last_name 때문에 error - group by 절에 없는 것을 select에 조회하면 error

-- 문제 1 job_id별 급여의 합계를 구해서 job_id, 급여합계를 출력하시오
select job_id, sum(salary)
from employees
group by job_id
order by sum(salary);

--ex4 ) 비효율적인 having절
--10과 20부서에서 최대급여를 받는 사람의 최대급여를 구하여 정렬하시오

--department_id     max_salary
------------------------------------
-- 10                     4400
-- 20                    13000 

select department_id, max(salary) as max_salary
from employees
group by department_id
having department_id in(10, 20)
order by department_id;
--전체 부서에 대해 그룹을 잡아서 최대급여를 구한 후에 부서가 10과 20인 것을 추려내기 때문인 것 

select department_id, max(salary) as max_salary
from employees
where department_id in(10, 20)
group by department_id
order by department_id;
--부서번호가 10과 20인 것만 골라내서 그룹잡기 때문에 속도가 좀 빠르다

-- ex 22) first_value함수 : 정렬된 값 중에서 첫 번째 값 반환
-- first_value(표현식) over(쿼리파티션)
-- 전체사원의 급여와 함께 각 부서의 최고급여를 나타내고 비교하시오
select employee_id,
       salary,
       department_id,
       first_value(salary) over(partition by department_id order by salary desc)
             "highsal_deptID"
from employees;

--partition by 절은 group by 절과 동일한 역할을 진행 합니다
-- 단, group by 절을 사용하지 않고 필요한 집합으로 행들을 그룹화 시킴
--partition by 절을 사용함으로 group by 절 없이 다양한 grouping 집합의 집계
--결과들을 함께 출력할 수 있습니다.
--order by 절은 partition by로 정의된 window 내에서의 행들의 정렬 순서를 정의한다.
select employee_id,
       last_name,
       salary,
       department_id,
    row_number() over (partition by department_id order by salary desc) rnum
from employees;
-- 부서 번호가 바뀔 때 row number는 새로 시작되는 것을 확인 할 수 있습니다.
null 값은 정렬 시 가장 큰 값으로 인식(기본설정)

--ex 5 ) inner join : 같은 것 끼리만 조인
-- 사원 테이블과 부서테이블에서 부서가 같을 경우 사원번호, 부서번호, 부서이름을 출력하시오

--방법1(오라클 전용 구문)
select employee_id,
       employees.department_id,
       department_name
from employees, departments
where employees.department_id = departments.department_id;

--방법2(오라클 전용 구문)
select  employee_id, 
        e.department_id,
        department_name
from employees e, departments d
where e.department_id = d.department_id; 

--방법3(Ansi 표준)
select employee_id, department_id, department_name
from employees join departments using(department_id); 

--문제 2 부서테이블(departments d)과 위치테이블(locations l)을 연결하여 부서가 위치한 도시를 알아내시오
select department_id, city
from employees
join locations using(location_id);

--ex 6 ) outer join(left) : 왼쪽 테이블은 모두 포함하여 조인
--사원 테이블과 부서 테이블에서 부서번호가 같은 사원을 조인하시오

--방법 1(오라클 전용 구문)
select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

--방법 2(Ansi 표준)
select last_name, department_id, department_name
from employees
left join departments using(department_id);


--ex 7 ) outer join(right) : 오른쪽 테이블은 모두 포함하여 조인
--사원테이블과 부서테이블에서 부서번호가 같은 사원을 조인하시오

--방법1(오라클 전용 구문)
select e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--방법2(Ansi 표준)
select last_name, department_id, department_name
from employees 
right join departments using(department_id);

--ex8 ) full join : 왼쪽, 오른쪽 테이블을 모두 포함하여 조인
--사원테이블과 부서테이블에서 부서번호가 같은 사원을 조인하시오 → 123레코드

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

--    EMPLOYEES                          EMPLOYEES
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

--문제 3 위치ID, 부서ID를 연결해서 사원이름, 도시, 부서이름을 출력하시오
--(관련 테이블 : employees, locations2, departments)
--조건1 : 사원이름, 도시, 부서이름으로 제목을 표시하시오
--조건2 : seattle 또는 oxford 에서 근무하는 사원
--조건3 : 도시 순으로 오름차순 정렬하시오

select last_name as 사원이름, city as 도시, department_name as 부서이름
from employees
join departments using(department_id)
join locations using(location_id)
where city = 'Seattle' or city = 'Oxford'
order by 2;

--문제 4 부서ID, 위치ID, 국가ID를 연결해서 다음과 같이 완성하시오
--(관련 테이블 : employees, locations2, departments, coutries)
--조건1 : 사원번호, 사원이름, 부서이름, 도시, 도시주소, 나라이름으로 제목을 표시하시오
--조건2 : 도시주소에 ch, 또는 sh 또는 Rd가 포함되어 있는 데이터만 표시하시오
--조건3 : 나라이름, 도시별로 오름차순 정렬하시오
--조건4 : 모든 사원을 포함한다
select employee_id as 사원번호, last_name as 사원이름, department_name as 부서이름,
       city as 도시, street_address as 도시주소, country_name as 나라이름
from employees
join departments using(department_id)
join locations using(location_id)
join countries using(country_id)
where street_address like '%ch%' or 
      street_address like '%sh%' or
      street_address like '%rd%'
order by 6, 4;