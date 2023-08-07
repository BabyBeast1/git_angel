--ex1 ) �����, �μ�ID, �Ի����� �μ����� ������������ �����Ͻÿ�
select last_name, department_id, hire_date
from employees
order by 2 desc;

--ex2 ) �����, �μ�ID, �Ի����� �μ����� ������������ �����Ͻÿ�
-- ���� �μ��� ���� ���� �Ի��ϼ����� �����Ͻÿ�
select last_name, department_id, hire_date
from employees
order by 2 desc, 3 asc; -- ���� 2�� �÷��� �����Ͱ� �Ȱ����� 3�� �÷� ���ķ� ��������

--���� 1 ������� ������ ���� �� ���� ������ �������� �����Ͻÿ�
select last_name as "��  ��", salary*12 as "��  ��"
from employees
order by 2 desc;


-- ex1 ) �̸��� �ҹ��ڷ� �ٲ� �� �˻�
-- 'Higgins' ����� �����ȣ, �̸�, �μ� ��ȣ�� �˻��Ͻÿ�
select employee_id, last_name, department_id
from employees
where lower(last_name)= 'higgins';

-- ex2 ) 10�� 3���� ���� ������ ���Ͻÿ�(mod)
select mod(10,3) from dual;  -- dual�� ������ ���̺�

-- ex3 ) 35765.357�� �ݿø�(round)
-- ��ġ�� n�� �� n�� ����� (n+1)���� �ݿø��� �ǰ�
            -- n�� ������ n�� ��ġ���� �ݿø��ȴ�.
select round(35654.357,2) from dual; -- 35654.36
select round(35765.357,0) from dual; -- 35765
select round(35765.357,-3) from dual; -- 36000

-- ex4 ) 35765.357�� ����(trunc)
-- ��ġ�� n�� �� n�� ����� (n+1)���� ������ �ǰ�
            -- n�� ������ n�� ��ġ���� ������ �ȴ�.
select trunc(35765.357,2) from dual; -- 35765.35
select trunc(35765.357,0) from dual; -- 35765
select trunc(35765.357,-3) from, dual; -- 35000


-- ex5 ) concat('���ڿ�1', '���ڿ�2') : ���ڿ��� ����(���ڿ�1+���ڿ�2)
select concat('hello', ' World') from dual;

--���� 2 ����� ���ڵ带 �˻��Ͻÿ� (concat, length)
-- ����1) �̸��� ���� �����Ͻÿ�(concat)
-- ����2) ������ �̸��� ���̸� ���Ͻÿ�(length)
-- ����3) ���� n ���� ������ ���(substr)
select Employee_ID,
       concat (first_name,' '|| last_name) as name,
       length(concat(first_name,''||last_name))as length
from employees
where substr(last_name, -1, 1) = 'n';