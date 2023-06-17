SET SERVEROUTPUT ON

-------<<<<<<<<<<-----Task 1
create or replace procedure seq(v_num in integer) is
begin
--    dbms_output.put_line(length(v_num));
    for i in 1..v_num loop
        dbms_output.put_line(i);
    end loop;
end;

begin
    seq(5);
end;

--------<<<<<<<<<<------Task 2
create or replace function reverseString(v_char in  varchar2)
return varchar2  is v_rev varchar2(20);
begin
    for i in reverse 1..length(v_char) loop
        v_rev :=  substr(v_char,i,1)||' '||v_rev;
        dbms_output.put_line(substr(v_char,i,1));    
    end loop;
    return v_rev;
end;
/
declare
var varchar2(20) := '&inpChr';
c varchar2(20);
begin
    c := reverseString(var);
    dbms_output.put_line(c);     
end;

----------<<<<<<<<<<-------Task 3
create or replace procedure facto(v_val in number, v_fact out number) is 
begin
    v_fact :=1;
    for i in reverse 1..v_val loop
        v_fact := v_fact*i;
    end loop;
    dbms_output.put_line('factorial value '||v_fact);
end;

declare
v_num number;
begin
    facto(5,v_num);
end;

--------<<<<<<<<<<<<-----Task 4
create or replace function ChkPrime(v_val in  number)
return boolean  is flag boolean := true;
begin
    if v_val <=1 then
        flag := False;
    else 
        for i in 2..(v_val-1) loop
            if mod(v_val,i)=0 then
                flag :=False;
                exit;
            end if;
        end loop;
     end if;
    return flag;
end;

declare
ans number:=5;
var boolean;
begin
var :=ChkPrime(ans);
    if var then
    dbms_output.put_line('Value is prime');
    else dbms_output.put_line('not prime');
    end if;
end;

-------<<<<<<<<<<<<<<---------Task 5
create or replace procedure multiTab(v_val in integer, v_result out number) is
begin
    for i in 1..12 loop
        v_result := i*v_val;
        dbms_output.put_line('The multiple of: '|| i ||' * '|| v_val ||' is: '|| v_result);
    end loop;
end;
/
declare
v_n number;
begin
    multiTab(5,v_n);
end;
/
-------<<<<<<<<<<<<<-------Task 6
create or replace function fnSum(v_int integer) 
return number is v_res number;
begin
    v_res :=0;
    for i in 1..v_int loop
    v_res := v_res + i;
    end loop;
    return v_res;
end;
/
declare
v_var number;
v_in integer :=5;
begin
    v_var := fnSum(v_in);
    dbms_output.put_line('The sum of input values: '||v_var);
end;

----------------cursor example---->>>>>>>>>
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
        for val in c_employee  loop
            dbms_output.put_line('empId: '||val.employee_id || ' empName: '||val.first_name); 
        end loop;
        dbms_output.put_line('cursor length: '||v_count); 
--    close c_employee;
end;
----------<<<<<<<<<------cursor example ends

------------------Exception example starts---->>>>>>>>>
create table message (result varchar2(50));
drop table message;
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
----------<<<<<<<<<<----------exception example ends


----------------Bind variable created----->>>>>>>>>>>>
VARIABLE b_result NUMBER
BEGIN
SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result
FROM employees WHERE employee_id = 144;
END;
/
PRINT b_result
--------<<<<<<<<<<<<<<<------bind variable ends


create or replace procedure raiseSal(v_Id in number) is
begin
    select salary+salary*.10 as sal from employees where employee_id=v_Id;
    update employees 
    set employees.salary = sal 
    where employee_id=v_Id;
    
    select * from employees where employee_id=v_Id;
end;
/
execute raiseSal(198);
