select * from hr.employees

select employee_id, first_name, salary, salary*12+10000 as "New Salary" from hr.employees

select employee_id, first_name|| ' salary: ' ||salary as "New Salary" from hr.employees

select employee_id, first_name|| q'[ salary: ]' ||salary as "New Salary" from hr.employees

select distinct first_name,department_id from hr.employees

describe employees

select employee_id, first_name from hr.employees where department_id=50

select employee_id, first_name from hr.employees where salary >=3500

select employee_id, first_name from hr.employees where salary between 2500 and 3500

select * from hr.employees

select employee_id, first_name from hr.employees where email in ('DOCONNEL' , 'DGRANT')

select employee_id, first_name from hr.employees where salary >=3500 and first_name like 'D_%'

select employee_id, first_name from hr.employees where department_id not in 50

select * from hr.employees where salary >=3500 or department_id not in 50 and first_name like 'D_%'

select * from employees order by hire_date DESC

select round(avg(salary),2), max(salary), min(salary), department_id from employees group by department_id

select count(department_id) as count, department_id from employees where salary>2600 group by department_id

select count(department_id) as count, department_id from employees group by department_id having sum(salary)>1300

select first_name, salary, department_id from employees where department_id=50

select max(salary) from employees group by department_id

select min(m_SAL) from (select max(salary) as m_SAL from employees group by department_id)


select * from jobs

describe newData

select * from newData

/*------------Join statement------------*/
select 
jobs.job_id, JOBS.JOB_TITLE, EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME, DEPARTMENTS.DEPARTMENT_NAME, DEPARTMENTS.MANAGER_ID, jobs.max_salary
from (jobs inner join employees on employees.job_id=JOBS.JOB_ID left join departments on departments.department_id=EMPLOYEES.DEPARTMENT_ID)


/* ---------creating new table Short----------*/

create table Short
as 
select jobs.job_id, JOBS.JOB_TITLE, EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME, DEPARTMENTS.DEPARTMENT_NAME, DEPARTMENTS.MANAGER_ID, jobs.max_salary
from (jobs inner join employees on employees.job_id=JOBS.JOB_ID left join departments on departments.department_id=EMPLOYEES.DEPARTMENT_ID)

select * from short

alter table Short 
ADD primary key (employee_id)

alter table Short 
ADD Email varchar(255)

alter table Short
drop column Email

alter table Short ADD SL number(38)

update short
set SL 

alter table Short
drop column SL

drop table short

select * from short

select job_title from jobs where job_title not like '%Clerk' 

/* update short set SL= next value for seq_1   */

select employee_id, max_salary, job_id,
    case job_id when upper('st_clerk') then 10*max_salary
                     when 'AD_ASST' then max_salary*2
    else max_salary end Revised_sal
from short

/*      creating auto sequence generator*/
select row_number() over (order by employee_id) as Sl  from short

/*      tried creating auto sequence generator*/
create sequence seq_1
start with 1
increment by 1
minvalue 1
maxvalue 200
cycle

drop sequence seq_1

create table ds(sl number(38) primary key, first_name varchar(20))

insert into ds values (seq_1.nextval, 'Michael')

insert into ds values (seq_1.nextval, 'Kathrine')

insert into ds values (seq_1.nextval, 'Scarlet')

select * FROM ds

drop table ds


/* ------------table short  ends here-----------*/

select * from employees

/* ---------------creating new table nd --------------*/

create table nd(sl number(38) primary key , Join_Date date)

insert into nd
values (1,'01-Jan-1987') 

insert into nd
values (1,to_date('Jan 15,1987','Mon dd, yyyy'))

select * from nd

drop table nd

/* -----------table nd  ends here----------*/


/*------F2--------*/

select * from employees

/*---- returns a range of salaries;
         salary < any () outputs the salary lesser than the maximum one
         job_id <> '....'  shows all exception the one in quotation   
---*/
select employee_id, email 
    from employees 
    where salary < any(select salary            
                                 from employees 
                                 where job_ID='SH_CLERK')
    and job_id <> 'SH_CLERK'

/*---- returns a range of salaries;
         salary < all() compares with all the values and return othe lesser one.
         job_id <> '....'  shows all exception the one in quotation   
---*/
select employee_id, email 
    from employees 
    where salary < all(select salary            
                                 from employees 
                                 where job_ID='SH_CLERK')
    and job_id <> 'SH_CLERK'

drop table Short

drop table newData

drop table ds

select employee_id ||', '|| first_name ||', '||email as "   Common" from employees

SELECT employee_id, last_name, job_id, salary
    FROM employees
    WHERE salary >= 10000
    or job_id LIKE '%MAN%'
    
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &employee_num
-- & prompts user for value (Ampersand)

SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM DUAL

SELECT ROUND(45.923,2), ROUND(45.923,0), ROUND(45.923,-1)
FROM DUAL;

SELECT last_name, TO_CHAR(hire_date, 'fmDD Month YYYY') AS HIREDATE
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'fmDdspth "of" Month YYYY fmHH:MI:SS AM') AS HIREDATE
FROM employees;

SELECT last_name, employee_id,
COALESCE(TO_CHAR(commission_pct),TO_CHAR(manager_id),
'No commission and no manager') 
FROM employees

SELECT last_name, job_id, salary,
    CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                       WHEN 'ST_CLERK' THEN 1.15*salary
                       WHEN 'SA_REP' THEN 1.20*salary
    ELSE salary END "REVISED_SALARY"
    FROM employees;

SELECT last_name,salary, 
    (CASE  WHEN salary<5000 THEN 'Low' 
                WHEN salary<10000 THEN 'Medium' 
                WHEN salary<20000 THEN 'Good' 
                ELSE 'Excellent' 
    END) qualified_salary 
FROM employees;

--  Similar to case exception a bit short-----

SELECT last_name, job_id, salary,
    DECODE(job_id, 'IT_PROG', 1.10*salary,
                            'ST_CLERK', 1.15*salary,
                            'SA_REP', 1.20*salary,
                            salary) REVISED_SALARY
FROM employees;

-- Keywords: natural join, Using  pg281 (needs celaring)

select length(first_name) from employees

select department_name, department_id from employees group by department_id

select * from departments

select * from jobs

select * from employees

select department_name, totalEmp from departments, (select count(department_id) as totalEmp from employees group by department_id)

select JID,AverageSal from (select job_id as JID,avg(salary) as AverageSal from employees group by job_id) where AverageSal>=1500

select first_name as ename, job_id as "job", salary*12 as "annual Sal"
from employees where  salary*12>=30000 and job_id not like ('%CLERK')

select distinct(manager_id) from employees where commission_pct is Null

select max(Max_salary) from jobs

select job_id from jobs where Max_salary=(select max(Max_salary) from jobs)

select department_id from employees where job_id=(select job_id from jobs where Max_salary=(select max(Max_salary) from jobs))

select department_name 
from departments 
where department_id=(select department_id from employees 
where job_id=(select job_id from jobs where Max_salary=(select max(Max_salary) from jobs)))

select first_name, substr(first_name,1,2) as TwoWords from employees

select round(hire_date,day) from employees 

select first_name as '__' from employees

select manager_id
from employees
where commission_pct is Null

select distinct(manager_id)
from employees
where commission_pct is Null

select * from employees

select first_name, last_name, job_id
from hr.employees
where job_id like '%MAN' and commission_pct is null


select next_day(date '2023-05-11','Thursday') from dual

select manager_id from departments where manager_id is not Null

select employee_id from employees where employee_id=any(select manager_id from departments where manager_id is not Null) and commission_pct is null

select job_id, avg(salary) as average_salary
from hr.employees
group by job_id
having avg(salary)>1500

select JID,AverageSal
from (select job_id as JID,avg(salary) as AverageSal
from employees group by job_id)
where AverageSal>=1500