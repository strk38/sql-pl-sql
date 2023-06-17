--Anonymous Block

SET SERVEROUTPUT ON
declare
    v_name varchar2(20);
begin
    select first_name into v_name  
    from employees 
    where employee_id=100;
    
    DBMS_OUTPUT.PUT_LINE(' The First Name of the Employee is ' || v_name);
end;
/
--
DECLARE
v_myName VARCHAR2(20);
BEGIN
DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
v_myName := 'John';
DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
END;

DECLARE
v_myName VARCHAR2(20):= 'John';
BEGIN
v_myName := 'Steven';
DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
END;
--
--Delimiters in String Literals
declare
    v_event varchar2(20);
begin
    v_event :=q'[June 3rd]';
    dbms_output.put_line('The output''s on: '||v_event);
    
     v_event :=q'!July 6th!';
    dbms_output.put_line('The output''s on: '||v_event);
    
end;
--

--Bind /Host Variables: Bind variables are created in the environment and not in the declarative section of a PL/SQL
--block. Therefore, bind variables are accessible even after the block is executed. When created,
--bind variables can be used and manipulated by multiple subprograms

VARIABLE b_result NUMBER
BEGIN
SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result
FROM employees WHERE employee_id = 144;
END;
/
PRINT b_result

-- Referencing Bind Variable
VARIABLE b_emp_salary NUMBER
BEGIN
SELECT salary INTO :b_emp_salary
FROM employees WHERE employee_id = 178;
END;
/
PRINT b_emp_salary
SELECT first_name, last_name
FROM employees
WHERE salary=:b_emp_salary;

--Using a Qualifier with Nested Blocks
BEGIN <<outer>>
    DECLARE
    v_father_name VARCHAR2(20):='Patrick';
    v_date_of_birth DATE:='20-Apr-1972';
        BEGIN
            DECLARE
            v_child_name VARCHAR2(20):='Mike';
            v_date_of_birth DATE:='12-Dec-2002';
            BEGIN
                DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name);
                DBMS_OUTPUT.PUT_LINE('Date of Birth: '||outer.v_date_of_birth);
                DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name);
                DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
            END;
        END;
END outer;


--Retrieve hire_date and salary for the specified employee.
DECLARE
    v_emp_hiredate employees.hire_date%TYPE;
    v_emp_salary employees.salary%TYPE;
BEGIN
        SELECT hire_date, salary
        INTO v_emp_hiredate, v_emp_salary
        FROM employees
        WHERE employee_id = 100;
        DBMS_OUTPUT.PUT_LINE ('Hire date is :'|| v_emp_hiredate);
        DBMS_OUTPUT.PUT_LINE ('Salary is :'|| v_emp_salary);
END;
/

--Return the sum of salaries for all the employees in the specified
--department.

--DECLARE
--v_sum_sal NUMBER(10,2);
--v_deptno NUMBER NOT NULL := 60;
--BEGIN
--    SELECT SUM(salary) -- group function
--    INTO v_sum_sal FROM employees
--    WHERE department_id = v_deptno;
--    DBMS_OUTPUT.PUT_LINE ('The sum of salary is ' || v_sum_sal);
--END;

--              Updating Data: Example
--DECLARE
--sal_increase employees.salary%TYPE := 800;
--BEGIN
--    UPDATE employees
--    SET salary = salary + sal_increase
--    WHERE job_id = 'ST_CLERK';
--END;
--
--DECLARE
--sal_increase employees.salary%TYPE := 800;
--BEGIN
--    UPDATE employees
--    SET salary = salary - sal_increase
--    WHERE job_id = 'ST_CLERK';
--END;
-- Ending by undo changes

--  IF ELSIF ELSE Clause
DECLARE
v_myage number:=31;
BEGIN
    IF v_myage < 11 THEN
        DBMS_OUTPUT.PUT_LINE(' I am a child ');
    ELSIF v_myage < 20 THEN
        DBMS_OUTPUT.PUT_LINE(' I am young ');
    ELSIF v_myage < 30 THEN
        DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
    ELSIF v_myage < 40 THEN
        DBMS_OUTPUT.PUT_LINE(' I am in my thirties');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' I am always young ');
    END IF;
END;


--WHILE Loops: Example
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
v_counter NUMBER := 1;
BEGIN
    SELECT MAX(location_id) 
    INTO v_loc_id 
    FROM locations
    WHERE country_id = v_countryid;
    WHILE v_counter <= 3 
    LOOP
        INSERT INTO locations(location_id, city, country_id)
        VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
        v_counter := v_counter + 1;
    END LOOP;
END;
/

--Basic Loop: Example
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_counter NUMBER(2) := 1;
v_new_city locations.city%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO v_loc_id FROM locations
    WHERE country_id = v_countryid;
    LOOP
        INSERT INTO locations(location_id, city, country_id)
        VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
        v_counter := v_counter + 1;
    EXIT WHEN v_counter > 3;
    END LOOP;
END;
/

--FOR Loops: Example
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO v_loc_id
    FROM locations
    WHERE country_id = v_countryid;
        FOR i IN 1..3 LOOP
            INSERT INTO locations(location_id, city, country_id)
            VALUES((v_loc_id + i), v_new_city, v_countryid );
        END LOOP;
END;
/

