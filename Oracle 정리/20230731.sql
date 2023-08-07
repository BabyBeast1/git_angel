desc employees;

--ex1 ) employees ���̺��� ��� ����� �����ȣ, �̸�(last_name), �޿� �˻�
select employee_id, last_name, salary from employees;

--ex2 ) ���� ���̱� 
-- employees ���̺��� ��� ����� �����ȣ, �̸�(last_name), �޿��˻�
-- ���� ) title �����ȣ, �̸�, �޿��� ����� ��
select employee_id as �����ȣ, last_name as "��  ��", salary as "��  ��"
from employees;

--ex3 ) employee ���̺��� �����ȣ, �̸�, ������ ���Ͻÿ�
-- ���� 1) ���� = �޿� * 12
-- ���� 2) ������ �����ȣ, �̸�, �������� ����
select employee_id as �����ȣ, last_name as "��  ��", salary*12 as "��  ��"
from employees;

--ex4 ) ���Ῥ����(||) : �÷��� �����ؼ� ���
-- frist_name�� last_name�� �����ؼ� ����Ͻÿ�

select first_name ||' '||last_name as "��  ��" from employees;

-- ���� 1
select employee_id as �����ȣ, last_name||' '||first_name as "��  ��", salary*12||'�޷�' as "��  ��"
from employees;

-- ���� 2
select last_name||' is a '|| job_id as "employee Detail"  from employees;

--ex5 ) distinct(�ߺ�����)
-- employees ���̺��� �μ�ID�� ����Ͻÿ�
select distinct department_id from employees;

--ex6 ) 10���μ� �Ǵ� 90���μ� ������� �̸�, �Ի���, �μ�ID �� ����Ͻÿ�
select last_name, hire_date, department_id
from employees
where department_id=10 or department_id=90;

--ex7 ) �޿��� 2500�̻� 3500�̸��� ����� �̸�(last), �Ի���, �޿��� �˻��Ͻÿ�
select last_name, hire_date, salary
from employees
where salary >=2500 and salary<3500;

-- ���� 3 �޿��� 2500 ���� �̰ų� 3000�̻��̸鼭 90�� �μ��� ����� �̸�, �޿�, �μ�ID�� ���
--����1) ������ �����, ����, �μ��ڵ�� �Ͻÿ�
--����2) �޿� �տ� $�� ���̽ÿ�
--����3) ������� frist_name�� last_name�� �����ؼ� ����Ͻÿ�
select last_name||' '||first_name as "�����", '$' || salary as "��  ��", department_id as �μ��ڵ�
from employees
where (salary <=2500 or salary >=3000) and department_id=90;

--ex8 ) 'king' ����� ��� �÷��� ǥ���Ͻÿ�
select * from employees where last_name='King';
-- ���ڿ� �˻��� ���� ��, �ҹ��ڸ� ����
select * from employees where lower(last_name)='king';

--ex9 ) ����ID�� MAN�� ���ԵǾ��ִ� ������� �̸�, ����ID, �μ� ID �� ����Ͻÿ�
select last_name, job_id, department_id
from employees
where job_id like '%MAN%';

--ex10 ) ����ID�� IT�� �����ϴ� ������� �̸�, ����ID, ��óId�� ����Ͻÿ�
select last_name, job_id, department_id
from employees
where job_id like 'IT%';

--ex11 ) is null / is not null
-- Ŀ�̼��� �޴� ������� �̸��� �׺�, Ŀ�̼��� ����Ͻÿ�
select last_name, salary, commission_pct
from employees
where commission_pct is not null;

-- Ŀ�̼��� ���� �ʴ� ������� �̸��� �޿�, Ŀ�̼��� ����Ͻÿ�
select last_name, salary, commission_pct
from employees
where commission_pct is null;

--ex12 ) in������ (or�������� �ٸ� ǥ��)
-- ����ID�� FI_MGR�̰ų� FI_ACCOUNT�� ������� �����ȣ, �̸�, ������ ����Ͻÿ�
select employee_id, last_name, job_id
from employees
where job_id='FI_MGR' or job_id='FI_ACCOUNT';

select employee_id, last_name, job_id
from employees
where job_id in ('FI_MGR', 'FI_ACCOUNT');

--ex13 ) between������(and�������� �ٸ� ǥ��) : �ʰ�, �̸������� ����� �� ����
-- �޿��� 10000�̻� 20000���� �� ����� �����ȣ, �̸�, �޿��� ����Ͻÿ�
select employee_id, last_name, salary
from employees
where salary >=10000 and salary <=20000;

select employee_id, last_name, salary
from employees
where salary between 10000 and 20000;

-- ���� 4 ����ID�� 'SA_REP'�̰ų� 'AD_PRES'�̸鼭 �޿��� 10,000�� �ʰ��ϴ� ������� �̸�, ����ID, �޿��� ����Ͻÿ�
select last_name as "��  ��", job_id as "����ID", salary || '��' as "��  ��"
from employees
where job_id in('AD_PRES', 'SA_REP') and salary > 10000;

-- ���� 5 Employees���̺��� ����ID�� �ߺ����� �ʰ� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
select distinct job_ID
from employees;

-- ���� 6 �Ի����� 2005���� ������� �����ȣ, �̸�, �Ի����� ǥ���Ͻÿ�
select employee_id as "�����ȣ", last_name as "��  ��", hire_date as "�Ի���"
from employees
where hire_date like '05%';



