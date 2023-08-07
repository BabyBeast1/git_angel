--ex 10) ���� ���� ������ ���� ���� ��� ��ġ�� �ִ����� ã�´�
-- : width_bucket(ǥ����, �ּҰ�, �ִ밪, ����)
-- �ּ�-�ִ밪�� �����ϰ� 10���� ������ ���� �� ��ġ ã��
-- 0-100������ ������ ���� �� 74�� ���ԵǾ� �ִ� ������ ǥ���Ͻÿ�
select width_bucket(74,0,100,10) from dual;

--ex 11) �������� : ltrim(��), rtrim(����), trim(����)
select rtrim('test  ') || 'exam' from dual;

--ex 12) sysdate : �ý��ۿ� ������ �ð�ǥ��
select sysdate from dual;
select to_char(sysdate, 'YYYY"��" MM"��" DD"��"') as ���ó�¥ from dual;
select to_char(sysdate, 'HH"��" MI"��" SS"��"') as ���ó�¥ from dual;
select to_char(sysdate, 'HH24"��" MI"��" SS"��"') as ���ó�¥ from dual;

--ex 13) add_months(date, �޼�) : ��¥�� �޼� ���ϱ�
select add_months(sysdate, 7) from dual;

--ex 14) last_day(date) : �ش���� ������ ��
select last_day(sysdate) from dual;
select last_day('2004-02-01') from dual;
select last_day('2005-02-01') from dual;

--���� 3 ���ú��� �̹� �� ������ �� ���� ������ ���Ͻÿ�
select last_day(sysdate)-sysdate from dual;

--ex 15) months_between(date1, date2) : �� ��¥ ������ �� ��
select round(months_between('95-10-21', '94-10-20'), 0) from dual;

������� ��ȯ(����)
select last_name, to_char(salary, 'L99,999.00')
from employees
where last_name='King';

--ex16 ) 
select to_char(to_date('97/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; �� 2097
select to_char(to_date('97/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; �� 1997

select to_char(to_date('17/9/30', 'YY-MM-DD') , 'YYYY-MON-DD') from dual; �� 2017 
select to_char(to_date('17/9/30', 'RR-MM-DD') , 'RRRR-MON-DD') from dual; �� 2017

--���� 4 2005�� ������ ���� ����� ã���ÿ�
select last_name, to_char(hire_date, 'dd-mon-yyyy') as HIRE_DATE
from employees
where hire_date <'05/01/01';

--ex17) fm���� : ���İ� �����Ͱ� �ݵ�� ��ġ�ؾ���(fm - fm���̰��� ��ġ)
      fm�� ǥ���ϸ� ���� ���� 0�� ��Ÿ���� �ʴ´�.
select last_name, hire_date from employees where hire_date='05/09/30';
select last_name, hire_date from employees where hire_date='05/9/30';

select to_char(sysdate, 'YYYY-MM-DD') from dual;	
select to_char(sysdate, 'YYYY-fmMM-DD') from dual;

select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-MM-DD') from dual;
�� 2011-03-01
select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-DD') from dual;
�� 2011-3-1
select to_char(to_date('2011-03-01','YYYY-MM-DD'), 'YYYY-fmMM-fmDD') from dual;
�� 2011-3-01

--ex 18) Count(�÷���), max(�÷���), min(�÷���), avg(�÷���), sum(�÷���) �Լ�
--employees ���̺��� �޿��� �ִ�, �ּ�, ���, ���� ���Ͻÿ�
--����) ����� �Ҽ� ���� ����, ���� ���ڸ����� �޸���� \ǥ��
select max(salary),
       min(salary),
       trunc(avg(salary),0),
       to_char(sum(salary),'L9,999,999')from employees;
       
--���� 5 Ŀ�̼�(commission_pct)�� ���� ���� ����� �ο����� ���Ͻÿ�

select count(*) from employees
where commission_pct is null;

--ex 19 ) employees ���̺��� ���� �μ� �����ؼ� �� �μ��� ���� ���Ͻÿ�
select department_id from employees;  -- 107
select count(department_id) from employees;  -- 106
select count(*) from employees; -- 107
select count(distinct department_id) from employees; -- 11
select count(distinct nvl(department_id, 0)) from employees; -- 12
select distinct nvl(department_id, 0) from employees; -- nvl�� null���� 0���� ��ġ

--���� 
select sum(price) as '�Ǹž�'
from sellings
where created_at >= '2016-11-01' && created_at <= '2016-11-30';

--ex 20 ) �� decode(ǥ����, �˻�1,���1, �˻�2,���2....[default])
       -- : ǥ���İ� �˻��� ���Ͽ� ��� ���� ��ȯ �ٸ��� default

       --  �� case  value  when  ǥ����  then  ����1
       --    when  ǥ����  then  ����2
       --    else  ����3
       --  end case

--���� id�� 'SA_MAN' �Ǵ� ��SA_REP'�̸� 'Sales Dept' �� �� �μ��̸� 'Another'�� ǥ��
--����) �з����� �������� ����
select job_id, decode(job_id, 
                     'SA_MAN', 'Sales Dept',
                     'SA_REP', 'Sales Dept',
                     'Another') "�з�"
from employees
order by 2;
-------------------------------------------
select job_id, case job_id
                    when 'SA_MAN' then 'Sales Dept'
                    when 'SA_REP' then 'Sales Dept'
                    else 'Another'
              end "�з�"
from employees
order by 2;       
-------------------------------------------
select job_id, case 
                    when job_id='SA_MAN' then 'Sales Dept'
                    when job_id='SA_REP' then 'Sales Dept'
                    else 'Another'
              end "�з�"
from employees
order by 2;

--[����6] �޿��� 10000 �̸��̸� �ʱ�, 20000 �̸��̸� �߱� �� �ܸ� ����� ����Ͻÿ�
-- ����1) ������ �����ȣ, �����, �������� ǥ���Ͻÿ�
-- ����2) ���� �÷����� �������� �����ϰ�, ������ ����� �÷����� �������� �Ͻÿ� 
-- ����3) case ����Ͻÿ�

select employee_id as �����ȣ, last_name as �����, 
                case when salary<'10000' then '�ʱ�'
                     when salary<'20000' then '�߱�'
                     else '���' end "����"
from employees
order by 3, 2;

-- ex21) rank�Լ� : ��ü ���� ������� ������ ����
--      rank(ǥ����) within group(order by ǥ����)
--      rank() over(������Ƽ��)  �� ��ü ������ ǥ��

--  �޿��� 3000�� ����� ���� �޿������� ���Ͻÿ�
select rank(3000) within group(order by salary desc) "rank" from employees;


--   ��ü����� �޿������� ���Ͻÿ�
select employee_id, salary, rank() over(order by salary desc)"rank" from employees;


-- [����7] ������̺��� �����ȣ, �̸�, �޿�, Ŀ�̼�, ������ ����Ͻÿ�
--        ����1) ������ $ ǥ�ÿ� ���ڸ����� �޸��� ����Ͻÿ�
--        ����2) ���� = �޿� * 12 + (�޿� * 12 * Ŀ�̼�)
--        ����3) Ŀ�̼��� ���� �ʴ� ����� �����ؼ� ����Ͻÿ�

select employee_id as �����ȣ, 
       last_name as �̸�, 
       salary as �޿�,
       nvl(commission_pct,0) as Ŀ�̼�,
       to_char(salary * 12 + (salary * 12 * nvl(commission_pct,0)), '$999,999,999') as ����
from employees;

-- [����8] �Ŵ����� ���� ����� MANAGER_ID�� 1000������ ǥ��
--        ����1) ������ �����ȣ, �̸�, �Ŵ���ID
--        ����2) ��� ����� ǥ���Ͻÿ�

select employee_id as �����ȣ, 
       last_name as �̸�, 
       nvl(manager_id,1000) as �Ŵ���ID
from employees;
