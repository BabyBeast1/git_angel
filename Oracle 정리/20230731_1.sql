--ex1 ) 사원명, 부서ID, 입사일을 부서별로 내림차순으로 정렬하시오
select last_name, department_id, hire_date
from employees
order by 2 desc;

--ex2 ) 사원명, 부서ID, 입사일을 부서별로 내림차순으로 정렬하시오
-- 같은 부서가 있을 때는 입사일순으로 정렬하시오
select last_name, department_id, hire_date
from employees
order by 2 desc, 3 asc; -- 만약 2번 컬럼의 데이터가 똑같으면 3번 컬럼 정렬로 순서정함

--문제 1 사원들의 연봉을 구한 수 연봉 순으로 내림차순 정렬하시오
select last_name as "이  름", salary*12 as "연  봉"
from employees
order by 2 desc;


-- ex1 ) 이름을 소문자로 바꾼 후 검색
-- 'Higgins' 사원의 사원번호, 이름, 부서 번호를 검색하시오
select employee_id, last_name, department_id
from employees
where lower(last_name)= 'higgins';

-- ex2 ) 10을 3으로 나눈 나머지 구하시오(mod)
select mod(10,3) from dual;  -- dual은 가상의 테이블

-- ex3 ) 35765.357을 반올림(round)
-- 위치가 n일 때 n이 양수면 (n+1)에서 반올림이 되고
            -- n이 음수면 n의 위치에서 반올림된다.
select round(35654.357,2) from dual; -- 35654.36
select round(35765.357,0) from dual; -- 35765
select round(35765.357,-3) from dual; -- 36000

-- ex4 ) 35765.357을 내림(trunc)
-- 위치가 n일 때 n이 양수면 (n+1)에서 내림이 되고
            -- n이 음수면 n의 위치에서 내림이 된다.
select trunc(35765.357,2) from dual; -- 35765.35
select trunc(35765.357,0) from dual; -- 35765
select trunc(35765.357,-3) from, dual; -- 35000


-- ex5 ) concat('문자열1', '문자열2') : 문자열의 겹합(문자열1+문자열2)
select concat('hello', ' World') from dual;

--문제 2 사원의 레코드를 검색하시오 (concat, length)
-- 조건1) 이름과 성을 연결하시오(concat)
-- 조건2) 구해진 이름의 길이를 구하시오(length)
-- 조건3) 성이 n 으로 끝나는 사원(substr)
select Employee_ID,
       concat (first_name,' '|| last_name) as name,
       length(concat(first_name,''||last_name))as length
from employees
where substr(last_name, -1, 1) = 'n';