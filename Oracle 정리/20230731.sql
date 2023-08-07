desc employees;

--ex1 ) employees 테이블의 모든 사원의 사원번호, 이름(last_name), 급여 검색
select employee_id, last_name, salary from employees;

--ex2 ) 별명 붙이기 
-- employees 테이블의 모든 사원의 사원번호, 이름(last_name), 급여검색
-- 조건 ) title 사원번호, 이름, 급여로 출력할 것
select employee_id as 사원번호, last_name as "이  름", salary as "급  여"
from employees;

--ex3 ) employee 테이블에서 사원번호, 이름, 연봉을 구하시오
-- 조건 1) 연봉 = 급여 * 12
-- 조건 2) 제못을 사원번호, 이름, 연봉으로 츨력
select employee_id as 사원번호, last_name as "이  름", salary*12 as "연  봉"
from employees;

--ex4 ) 연결연산자(||) : 컬럼을 연결해서 출력
-- frist_name과 last_name을 연결해서 출력하시오

select first_name ||' '||last_name as "이  름" from employees;

-- 문제 1
select employee_id as 사원번호, last_name||' '||first_name as "이  름", salary*12||'달러' as "연  봉"
from employees;

-- 문제 2
select last_name||' is a '|| job_id as "employee Detail"  from employees;

--ex5 ) distinct(중복제거)
-- employees 테이블에서 부서ID를 출력하시오
select distinct department_id from employees;

--ex6 ) 10번부서 또는 90번부서 사원들의 이름, 입사일, 부서ID 를 출력하시오
select last_name, hire_date, department_id
from employees
where department_id=10 or department_id=90;

--ex7 ) 급여가 2500이상 3500미만인 사원의 이름(last), 입사일, 급여를 검색하시오
select last_name, hire_date, salary
from employees
where salary >=2500 and salary<3500;

-- 문제 3 급여가 2500 이하 이거나 3000이상이면서 90번 부서인 사원의 이름, 급여, 부서ID를 출력
--조건1) 제목은 사원명, 월급, 부서코드로 하시오
--조건2) 급여 앞에 $를 붙이시오
--조건3) 사원명은 frist_name과 last_name을 연결해서 출력하시오
select last_name||' '||first_name as "사원명", '$' || salary as "월  급", department_id as 부서코드
from employees
where (salary <=2500 or salary >=3000) and department_id=90;

--ex8 ) 'king' 사원의 모든 컬럼을 표시하시오
select * from employees where last_name='King';
-- 문자열 검색할 때는 대, 소문자를 구분
select * from employees where lower(last_name)='king';

--ex9 ) 업무ID에 MAN이 포함되어있는 사원들의 이름, 업무ID, 부서 ID 를 출력하시오
select last_name, job_id, department_id
from employees
where job_id like '%MAN%';

--ex10 ) 업무ID가 IT로 시작하는 사원들의 이름, 업무ID, 부처Id를 출력하시오
select last_name, job_id, department_id
from employees
where job_id like 'IT%';

--ex11 ) is null / is not null
-- 커미션을 받는 사원들의 이름과 그병, 커미션을 출력하시오
select last_name, salary, commission_pct
from employees
where commission_pct is not null;

-- 커미션을 받지 않는 사원들의 이름과 급여, 커미션을 출력하시오
select last_name, salary, commission_pct
from employees
where commission_pct is null;

--ex12 ) in연산자 (or연산자의 다른 표현)
-- 업무ID가 FI_MGR이거나 FI_ACCOUNT인 사원들의 사원번호, 이름, 직무를 출력하시오
select employee_id, last_name, job_id
from employees
where job_id='FI_MGR' or job_id='FI_ACCOUNT';

select employee_id, last_name, job_id
from employees
where job_id in ('FI_MGR', 'FI_ACCOUNT');

--ex13 ) between연산자(and연산자의 다른 표현) : 초과, 미만에서는 사용할 수 없다
-- 급여가 10000이상 20000이하 인 사원의 사원번호, 이름, 급여를 출력하시오
select employee_id, last_name, salary
from employees
where salary >=10000 and salary <=20000;

select employee_id, last_name, salary
from employees
where salary between 10000 and 20000;

-- 문제 4 업무ID가 'SA_REP'이거나 'AD_PRES'이면서 급여가 10,000을 초과하는 사원들의 이름, 업무ID, 급여를 출력하시오
select last_name as "이  름", job_id as "업무ID", salary || '원' as "급  여"
from employees
where job_id in('AD_PRES', 'SA_REP') and salary > 10000;

-- 문제 5 Employees테이블의 업무ID가 중복되지 않게 표시하는 질의를 작성하시오
select distinct job_ID
from employees;

-- 문제 6 입사일이 2005년인 사원들의 사원번호, 이름, 입사일을 표시하시오
select employee_id as "사원번호", last_name as "이  름", hire_date as "입사일"
from employees
where hire_date like '05%';



