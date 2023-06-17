declare
    a varchar2(20) := 'ferow';
begin
    DBMS_OUTPUT.PUT_LINE(a);
end;

declare
    a varchar2(20) ;
    b number := &val;
begin
    select first_name into a
    from employees where employee_id=b; 
    DBMS_OUTPUT.PUT_LINE(a);
end;

declare
    a jobs.min_salary%type ;
    b varchar2(35) := '%Manager';
begin
    select max(min_salary) into a
    from (select min_salary, job_id from jobs where job_title like b) ;
    DBMS_OUTPUT.PUT_LINE(a);
end;

select min_salary, job_id from jobs where job_title like '%Manager';

declare
    a number :=&n;
begin
    if a>10 then
        dbms_output.put_line(a||' is gretaer than ten');
    elsif a<10 then
        dbms_output.put_line(a||' is less than ten');
    else
        dbms_output.put_line(a||' is equal to ten');
    end if;
    dbms_output.put_line(' if-else ends here');
end;

declare
    a number := 10;
begin
    Loop
        dbms_output.put_line('Inside loop '||a);
        a :=a*10;
        if a>10000 then
            dbms_output.put_line(' Exiting loop');
            exit;
        end if;
    end Loop;
    dbms_output.put_line(' Code terminates');
end;

declare
    a number :=50;
begin
    while a<5000 loop
        dbms_output.put_line('Printing '||a);
        a := a*5;
    end loop;
end;

declare
    a number;
    b varchar(20);
begin
    for a in 1..6 loop
         b := b||a;
        dbms_output.put_line('Printing '||b);
    end loop;
end;

declare
    a number;
    b varchar(20);
begin
    for a in reverse 1..6 loop
         b := b||a;
        dbms_output.put_line('Printing '||b);
    end loop;
end;

declare
    i number;
    j number;
begin
    <<outer_loop>>
   i :=2;
   loop
   exit when i=102;
        <<inner_loop>>
        j :=2;
        loop
            exit when i=j or (mod(i,j)=0);
            j :=j+1;
        end loop inner_loop;
        if i=j then
        dbms_output.put_line(i ||' is prime');
        end if;
        i := i+1;
   end loop outer_loop;
end;

declare
    i number;
    j number;
    counter number;
begin

   i :=2;
   for counter in 1..50 loop
      
            <<inner_loop>>
            j :=2;
            loop
                exit when i=j or (mod(i,j)=0);
                j :=j+1;
            end loop inner_loop;
            if i=j then
            dbms_output.put_line(i ||' is prime');
            end if;
            i := i+1;
    end loop;
end;

--  Array --
declare
    type nameArray is varray(5) of varchar2(10);
    type grades is varray(5) of integer;
    names nameArray;
    marks grades;
    total integer;
    i integer;
begin
    names := nameArray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
    marks := grades(70,85,98,89,88);
    total := names.count;
    dbms_output.put_line('Total '|| total || ' Students'); 
    for i in 1..total loop
        dbms_output.put_line(names(i) || ' marks is '|| marks(i));
    end loop;
end;


----------------Procedures----
CREATE OR REPLACE PROCEDURE greetings 
AS 
BEGIN 
   dbms_output.put_line('Hello World!'); 
END;

-- Procedure can be called from Execute statement and also from plSql block
EXECUTE greetings;

BEGIN 
   greetings; 
END;

DROP PROCEDURE greetings;


------ In Out modes-------
DECLARE 
   a number; 
   b number; 
   c number;
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS 
BEGIN 
   IF x < y THEN 
      z:= x; 
   ELSE 
      z:= y; 
   END IF; 
END;   
BEGIN 
   a:= 23; 
   b:= 45; 
   findMin(a, b, c); 
   dbms_output.put_line(' Minimum of (23, 45) : ' || c); 
END; 

CREATE OR REPLACE PROCEDURE query_emp
(p_id IN employees.employee_id%TYPE,
p_name OUT employees.last_name%TYPE,
p_salary OUT employees.salary%TYPE) IS
BEGIN
SELECT last_name, salary INTO p_name, p_salary
FROM employees
WHERE employee_id = p_id;
END query_emp;
/

SET SERVEROUTPUT ON
DECLARE
v_emp_name employees.last_name%TYPE;
v_emp_sal employees.salary%TYPE;
BEGIN
query_emp(171, v_emp_name, v_emp_sal);
DBMS_OUTPUT.PUT_LINE(v_emp_name||' earns '||
to_char(v_emp_sal, '$999,999.00'));
END;

----------------------------------------------------
---- :::::::::   Functions  :::::::::----
create or replace function count_employee
return number is
 total number :=0;
begin
    select count(employee_id) into total from employees;
    return total;
end;

drop function count_employee;

declare
    c number ;
begin
    c := count_employee();
    dbms_output.put_line(c);
end;

----------Another example 
CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER)
RETURN NUMBER IS
BEGIN
RETURN (p_value * 0.08);
END tax;
/
SELECT employee_id, last_name, salary, tax(salary)
FROM employees
WHERE department_id = 100;
------------------------------------------------------------------------------

--    Records--
declare
    emp_record job_history%rowtype;
    emp_id number := 102;
begin
    SELECT * INTO emp_record from job_history where employee_id=emp_id;
    
    dbms_output.put_line('ID: '|| emp_record.employee_id);
   dbms_output.put_line('start date: '|| emp_record.start_date);
   dbms_output.put_line('ebd date: '|| emp_record.end_date);
   dbms_output.put_line('J ID: '|| emp_record.job_id);
   dbms_output.put_line('Department ID: '|| emp_record.department_id);
end;

declare
    v_date date :=sysdate;
    v_tomorrow v_date%type;
begin
    v_tomorrow := v_date+2;
    dbms_output.put_line('today"s '||v_date);
    dbms_output.put_line('tomorrow"s '||v_tomorrow);    
end;
/

----------------Bind variable created
VARIABLE b_result NUMBER
BEGIN
SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result
FROM employees WHERE employee_id = 144;
END;
/
PRINT b_result
--------------

variable b_basic_percent number
variable b_pf_percent number
begin
    :b_basic_percent := 25;
    :b_pf_percent := 12;
end;
/
print b_basic_percent
print b_pf_percent

set serveroutput on
declare
v_basic_percent number :=45;
v_pf_percent number :=12;
v_fname varchar2(15);
v_emp_sal number(10);
begin
    select first_name, salary into v_fname, v_emp_sal 
    from employees where employee_id=110;
    
    dbms_output.put_line('Hello '|| v_fname);
    dbms_output.put_line('Basic salary '|| v_emp_sal);
    dbms_output.put_line('pf Salary '|| v_emp_sal*(v_basic_percent/100)*(v_pf_percent/100) );
end;
/

declare 
v_max_deptno number;
v_dept_name departments.department_name%type :='Education';
v_dept_id number;
begin
    select max(department_id) into v_max_deptno from departments;
    v_dept_id :=v_max_deptno+10;
    insert into departments (department_id, department_name, location_id)
    values (v_dept_id, v_dept_name, NULL);
    dbms_output.put_line('effected rows '||sql%rowcount);
--    dbms_output.put_line('max dept no '||v_max_deptno);   
end;
/

begin
    update departments set location_id=3000 where department_id=280;
end;
/
select * from departments where department_id=280;
delete from departments where department_id=280; 

------Testing data input
insert into departments values (500, 'home', Null, 1800);
select * from departments where department_id=500;
delete from departments where department_id=500;
----------end test 

------------Problem-5 pg 325
drop table message;

create table message(result number);

declare
v_empno emp.employee_id%type :=176;
v_asterisk emp.stars%type :='Null';
begin
    for i in 1..10 loop
        if i =6 or i=8 then
            null;
        else 
            insert into message  values (i);
        end if;
    end loop;
end;
/
select * from message;

------creating emp table as duplicate of employee with data
create table emp 
as
select * from employees;

----adding new colum to table
alter table emp
add stars varchar2(50);

drop table emp;
------

declare
v_empno emp.employee_id%type :=176;
v_asterisk emp.stars%type := Null;
v_sal emp.salary%type;
begin
    select nvl(round(salary/1000),0) into v_sal
    from emp where employee_id=v_empno;
    for i in 1..v_sal loop
        v_asterisk := v_asterisk || '*';
    end loop;
    
    update emp set stars = v_asterisk
    where employee_id=v_empno;
    commit;
    
end;
/
select employee_id, salary,stars from emp where employee_id=176;

----------------End of problem 5

----------------------------Problem 6 pg:330------------------------------------
declare
v_countryid varchar2(20) := 'CA';
v_country_record countries%rowtype;
begin
    select * into v_country_record 
    from countries
    where country_id=upper(v_countryid);
    
    dbms_output.put_line('country Id: '||v_country_record.country_id||
    ' Country Name: '||v_country_record.country_name||
    ' Region: '||v_country_record.region_id );
end;

declare
type dept_table_type is table of departments.department_name%type
index by pls_integer;
my_dept_table dept_table_type;

f_loop_count number :=10;
v_deptno number :=0;
begin
    for i in 1..f_loop_count Loop
        v_deptno := v_deptno+10;
        select department_name into my_dept_table(i) from departments where department_id= v_deptno;
    end Loop;
    
    for i in 1..f_loop_count Loop
    dbms_output.put_line(my_dept_table(i));
    end Loop;
end;

--------Using Explicit cursor 
------------(7-1): 1
declare
v_deptno number :=20 ;
cursor c_emp_cursor is
    select last_name, salary, manager_id 
    from employees
    where department_id =v_deptno; 
begin
    for i in c_emp_cursor loop
        if i.salary<5000 and i.manager_id=101 or i.manager_id=124
            then dbms_output.put_line(i.last_name||' Due for a raise');
        else dbms_output.put_line(i.last_name||' not due for raise');
        end if;
    end loop;
end;

--------------(7-1):2 [cursor without parameter and cursor w/o parameter--------
--declare
--v_deptno number :=20 ;
--cursor c_dept_cursor is
--    select department_id, department_name 
--    from departments 
--    where department_id<100 
--    order by department_id;
--cursor c_emp_cursor(v_deptno number) is
--    select last_name,job_id, hire_date 
--    from employees
--    where department_id=v_deptno
--    and employee_id < 120;
--begin
--    open c_dept_cursor
--        loop
--        fetch c_dept_cursor into v_current_deptno,v_current_dname;
--        exit when c_dept_cursor%not found;
--        dbms_ouput.put_line('dept number: '||v_current_deptno
--        ||' dept name: '|| v_current_dname);
--end;


------------------------------------------------------------Exception handlings
drop table message;

create table message (result varchar2(50));

select * from message;

declare
v_name employees.last_name%type;
v_emp_sal employees.salary%type :=2000;
begin
    select last_name 
    into v_name
    from employees
    where salary=v_emp_sal;
    Insert into message(result) 
    values (v_name ||' ---- '||v_emp_sal);
exception
    when no_data_found then
        insert into message(result)
        values ('No employee with salary '||to_char(v_emp_sal));
    when too_many_rows then
        insert into message(result)
        values ('More than one employee with salary '||to_char(v_emp_sal));
    when others then
        insert into message(result)
        values ('Other error occured ');
end;
/
select * from message;

----------------------------------------Procedure example check
create procedure qt
is 
begin
    dbms_output.put_line('output1: ');
end;

drop procedure qt;
execute qt;

create procedure qt
as
begin
    dbms_output.put_line('output2: ');
end;

------------------------------------------Shows Error
--create  procedure nt(
--o_deptId in out number
--)
--as 
--begin
--    select department_id into o_deptId from employees where employee_id =o_deptId;
--end;
--
--DECLARE
--   v_employee_id NUMBER := 198;
--   v_department_id NUMBER;
--BEGIN
--   nt(v_department_id);
--   dbms_output.put_line('Output: ' || v_department_id);
--END;
--
--drop procedure nt;
------------------------------------------Shows Error ends here

CREATE OR REPLACE PROCEDURE nt(
   o_deptId IN OUT NUMBER
)
AS
   v_temp_deptId NUMBER; -- Use a different variable to store the result
BEGIN
   SELECT department_id INTO v_temp_deptId FROM employees WHERE employee_id = o_deptId;
   o_deptId := v_temp_deptId; -- Assign the value to the OUT parameter
END;
/

DECLARE
   v_employee_id NUMBER := 198;
   v_department_id NUMBER;
BEGIN
   nt(v_employee_id); -- Pass v_employee_id as the IN OUT parameter
   v_department_id := v_employee_id; -- Assign the value to the separate variable
   dbms_output.put_line('Output: ' || v_department_id);
END;
/

DROP PROCEDURE nt;

----------Cursor practice
SET SERVEROUTPUT ON

declare
c_eId employees.employee_id%type;
c_eName employees.first_name%type;
cursor c_employee is
select employee_id, first_name 
from employees 
where
manager_id=101;
 
begin
    open c_employee;
        loop
            fetch c_employee into c_eId, c_eName;
            exit when c_employee%notfound;
            dbms_output.put_line('empId: '||c_eId || ' empName: '||c_eName); 
        end loop;
    close c_employee;
end;

declare
c_eId employees.employee_id%type;
c_eName employees.first_name%type;
cursor c_employee is
select employee_id, first_name 
from employees 
where
manager_id=101;
v_count integer :=0;
begin
    for i in c_employee loop
        v_count := v_count+1;
    end loop;
--    open c_employee;
        for val in c_employee 
        loop
            dbms_output.put_line('empId: '||val.employee_id || ' empName: '||val.first_name); 
        end loop;
        dbms_output.put_line('cursor length: '||v_count); 
--    close c_employee;
end;