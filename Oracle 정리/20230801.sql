--ex 10) 임의 값이 지정된 범위 내에 어느 위치에 있는지를 찾는다
-- : width_bucket(표현식, 최소값, 최대값, 구간)
-- 최소-최대값을 설정하고 10개의 구간을 설정 후 위치 찾기
-- 0-100까지의 구간을 나눈 후 74가 포함되어 있는 구간을 표시하시오
select width_bucket(74,0,100,10) from dual;

--ex 11) 공백제거 : ltrim(왼), rtrim(오른), trim(양쪽)
select rtrim('test  ') || 'exam' from dual;

--ex 12) sysdate : 시스템에 설정된 시간표시
select sysdate from dual;
select to_char(sysdate, 'YYYY"년" MM"월" DD"일"') as 오늘날짜 from dual;
select to_char(sysdate, 'HH"시" MI"분" SS"초"') as 오늘날짜 from dual;
select to_char(sysdate, 'HH24"시" MI"분" SS"초"') as 오늘날짜 from dual;

--ex 13) add_months(date, 달수) : 날짜에 달수 더하기
select add_months(sysdate, 7) from dual;

--ex 14) last_day(date) : 해당달의 마지막 날
select last_day(sysdate) from dual;
select last_day('2004-02-01') from dual;
select last_day('2005-02-01') from dual;

--문제 3 오늘부터 이번 달 말까지 총 남은 날수를 구하시오
select last_day(sysdate)-sysdate from dual;

--ex 15) months_between(date1, date2) : 두 날짜 사이의 달 수
select round(months_between('95-10-21', '94-10-20'), 0) from dual;

명시적인 변환(강제)
select last_name, to_char(salary, 'L99,999.00')
from employees
where last_name='King';

--ex16 ) 
select to_char(to_date('97/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; ← 2097
select to_char(to_date('97/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; ← 1997

select to_char(to_date('17/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; ← 2017 
select to_char(to_date('17/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; ← 2017

--문제 4 2005년 이전에 고용된 사원을 찾으시오
select last_name, to_char(hire_date, 'dd-mon-yyyy') as HIRE_DATE
from employees
where hire_date <'05/01/01';

--ex17) fm형식 : 형식과 데이터가 반드시 일치해야함(fm - fm사이값만 일치)
      fm를 표시하면 숫자 앞의 0을 나타나지 않는다.
select last_name, hire_date from employees where hire_date='05/09/30';
select last_name, hire_date from employees where hire_date='05/9/30';

select to_char(sysdate, 'YYYY-MM-DD') from dual;	
select to_char(sysdate, 'YYYY-fmMM-DD') from dual;

select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-MM-DD') from dual;
← 2011-03-01
select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-DD') from dual;
← 2011-3-1
select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-fmDD') from dual;
← 2011-3-01

--ex 18) Count(컬럼명), max(컬럼명), min(컬럼명), avg(컬럼명), sum(컬럼명) 함수
--employees 테이블에서 급여의 최대, 최소, 평균, 합을 구하시오
--조건) 평균은 소수 이하 절삭, 합은 세자리마다 콤마찍고 \표시
select max(salary),
       min(salary),
       trunc(avg(salary),0),
       to_char(sum(salary),'L9,999,999')from employees;
       
--문제 5 커미션(commission_pct)을 받지 않은 사원의 인원수를 구하시오

select count(*) from employees
where commission_pct is null;

--ex 19 ) employees 테이블에서 없는 부서 포함해서 총 부서의 수를 구하시오
select department_id from employees;  -- 107
select count(department_id) from employees;  -- 106
select count(*) from employees; -- 107
select count(distinct department_id) from employees; -- 11
select count(distinct nvl(department_id, 0)) from employees; -- 12
select distinct nvl(department_id, 0) from employees; -- nvl은 null값을 0으로 대치

--문제 
select sum(price) as '판매액'
from sellings
where created_at >= '2016-11-01' && created_at <= '2016-11-30';

--ex 20 ) ① decode(표현식, 검색1,결과1, 검색2,결과2....[default])
       -- : 표현식과 검색을 비교하여 결과 값을 반환 다르면 default

       --  ② case  value  when  표현식  then  구문1
       --    when  표현식  then  구문2
       --    else  구문3
       --  end case

--업무 id가 'SA_MAN' 또는 ‘SA_REP'이면 'Sales Dept' 그 외 부서이면 'Another'로 표시
--조건) 분류별로 오름차순 정렬
select job_id, decode(job_id, 
                     'SA_MAN', 'Sales Dept',
                     'SA_REP', 'Sales Dept',
                     'Another') "분류"
from employees
order by 2;
-------------------------------------------
select job_id, case job_id
                    when 'SA_MAN' then 'Sales Dept'
                    when 'SA_REP' then 'Sales Dept'
                    else 'Another'
              end "분류"
from employees
order by 2;       
-------------------------------------------
select job_id, case 
                    when job_id='SA_MAN' then 'Sales Dept'
                    when job_id='SA_REP' then 'Sales Dept'
                    else 'Another'
              end "분류"
from employees
order by 2;

--[문제6] 급여가 10000 미만이면 초급, 20000 미만이면 중급 그 외면 고급을 출력하시오
-- 조건1) 제목은 사원번호, 사원명, 구분으로 표시하시오
-- 조건2) 구분 컬럼으로 오름차순 정렬하고, 같으면 사원명 컬럼으로 오름차순 하시오 
-- 조건3) case 사용하시오

select employee_id as 사원번호, last_name as 사원명, 
                case when salary<'10000' then '초급'
                     when salary<'20000' then '중급'
                     else '고급' end "구분"
from employees
order by 3, 2;

-- ex21) rank함수 : 전체 값을 대상으로 순위를 구함
--      rank(표현식) within group(order by 표현식)
--      rank() over(쿼리파티션)  → 전체 순위를 표시

--  급여가 3000인 사람의 상위 급여순위를 구하시오
select rank(3000) within group(order by salary desc) "rank" from employees;


--   전체사원의 급여순위를 구하시오
select employee_id, salary, rank() over(order by salary desc)"rank" from employees;


-- [문제7] 사원테이블에서 사원번호, 이름, 급여, 커미션, 연봉을 출력하시오
--        조건1) 연봉은 $ 표시와 세자리마다 콤마를 사용하시오
--        조건2) 연봉 = 급여 * 12 + (급여 * 12 * 커미션)
--        조건3) 커미션을 받지 않는 사원도 포함해서 출력하시오

select employee_id as 사원번호, 
       last_name as 이름, 
       salary as 급여,
       nvl(commission_pct,0) as 커미션,
       to_char(salary * 12 + (salary * 12 * nvl(commission_pct,0)), '$999,999,999') as 연봉
from employees;

-- [문제8] 매니저가 없는 사원의 MANAGER_ID를 1000번으로 표시
--        조건1) 제목은 사원번호, 이름, 매니저ID
--        조건2) 모든 사원을 표시하시오

select employee_id as 사원번호, 
       last_name as 이름, 
       nvl(manager_id,1000) as 매니저ID
from employees;
