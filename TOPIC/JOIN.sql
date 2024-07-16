/*
 +--------+----------+--------+---------+------------+
 | Emp_id | Emp_name | Salary | Dept_id | Manager_id |
 +--------+----------+--------+---------+------------+
 | E1     | Rahul    |  15000 | D1      | M1         |
 | E2     | Manoj    |  15000 | D1      | M1         |
 | E3     | James    |  55000 | D2      | M2         |
 | E4     | Michael  |  25000 | D2      | M2         |
 | E5     | Ali      |  20000 | D10     | M3         |
 | E6     | Robin    |  35000 | D10     | M3         |
 +--------+----------+--------+---------+------------+
 
 +------------+--------------+---------+
 | Manager_id | Manager_name | Dept_id |
 +------------+--------------+---------+
 | M1         | Prem         | D3      |
 | M2         | Shripadh     | D4      |
 | M3         | Nick         | D1      |
 | M4         | Cory         | D1      |
 +------------+--------------+---------+
 
 +---------+-----------+
 | dept_id | dept_name |
 +---------+-----------+
 | D1      | IT        |
 | D2      | HR        |
 | D3      | Finance   |
 | D4      | Admin     |
 +---------+-----------+
 
 +------------+----------------+----------------+
 | Project_id | Project_name   | Team_member_id |
 +------------+----------------+----------------+
 | P1         | Data Migration | E1             |
 | P1         | Data Migration | E2             |
 | P1         | Data Migration | M3             |
 | P2         | ETL Tool       | E1             |
 | P2         | ETL Tool       | M4             |
 +------------+----------------+----------------+
 
 */
-- Employee Table
CREATE TABLE emp3(
    Emp_id VARCHAR(5),
    Emp_name VARCHAR (20),
    Salary INT,
    Dept_id VARCHAR (5),
    Manager_id VARCHAR (5)
);

INSERT INTO
    emp3(
        Emp_id,
        Emp_name,
        Salary,
        Dept_id,
        Manager_id
    )
VALUES
    ("E2", "Manoj", 15000, "D1", "M1"),
    ("E3", "James", 55000, "D2", "M2"),
    ("E4", "Michael", 25000, "D2", "M2"),
    ("E5", "Ali", 20000, "D10", "M3"),
    ("E6", "Robin", 35000, "D10", "M3");

-- Manager Table
CREATE TABLE manager(
    Manager_id VARCHAR(5),
    Manager_name VARCHAR(20),
    Dept_id VARCHAR(5)
);

INSERT INTO
    manager(
        Manager_id,
        Manager_name,
        Dept_id
    )
VALUES
    ("M1", "Prem", "D3"),
    ("M2", "Shripadh", "D4"),
    ("M3", "Nick", "D1"),
    ("M4", "Cory", "D1");

-- Project Table
CREATE TABLE project (
    Project_id VARCHAR(5),
    Project_name VARCHAR(100),
    Team_member_id VARCHAR(5)
);

INSERT INTO
    project(
        Project_id,
        Project_name,
        Team_member_id
    )
VALUES
    ("P1", "Data Migration", "E1"),
    ("P1", "Data Migration", "E2"),
    ("P1", "Data Migration", "M3"),
    ("P2", "ETL Tool", "E1"),
    ("P2", "ETL Tool", "M4");

-- Department Table
CREATE TABLE department (dept_id VARCHAR(5), dept_name VARCHAR(50));

INSERT INTO
    department(dept_id, dept_name)
VALUES
    ("D1", "IT"),
    ("D2", "HR"),
    ("D3", "Finance"),
    ("D4", "Admin");

-- INNER JOIN
-- FETCH THE EMPLOYEE NAME AND DEPARTMENT NAME THEY BELONG TO.
-- emp3.Emp_name department.dept_name emp3.dept_id = department.dept_id
SELECT
    emp3.Emp_name,
    department.dept_name
FROM
    emp3
    INNER JOIN department ON emp3.dept_id = department.dept_id;

/*
 emp3
 +--------+----------+--------+---------+------------+
 | Emp_id | Emp_name | Salary | Dept_id | Manager_id |
 +--------+----------+--------+---------+------------+
 | E1     | Rahul    |  15000 | D1      | M1         |
 | E2     | Manoj    |  15000 | D1      | M1         |
 | E3     | James    |  55000 | D2      | M2         |
 | E4     | Michael  |  25000 | D2      | M2         |
 | E5     | Ali      |  20000 | D10     | M3         |
 | E6     | Robin    |  35000 | D10     | M3         |
 +--------+----------+--------+---------+------------+
 
 department
 +---------+-----------+
 | dept_id | dept_name |
 +---------+-----------+
 | D1      | IT        |
 | D2      | HR        |
 | D3      | Finance   |
 | D4      | Admin     |
 +---------+-----------+
 
 O/P
 +----------+-----------+
 | Emp_name | dept_name |
 +----------+-----------+
 | Rahul    | IT        |
 | Manoj    | IT        |
 | James    | HR        |
 | Michael  | HR        |
 +----------+-----------+
 
 THERE ARE TOTAL 6 EMPLOYEES BUT THE OUT PUT IS ONLY 4 EMPLOYEES
 
 AS D10 IN AVAILABLE IN department table
 
 INNER JOIN WILL FETCH THE RECORDS WHICH ARE PRESENT IN BOTH THE TABLES
 
 AS ONLY D1 & D2 WERE PRESENT IN BOTH THE TABLES ONLY THOSE OUTPUT GOT DISPLAYED
 */
-- LEFT JOIN 
-- THERE ARE MORE THAN 4 EMPLOYEES IN EMPLOYEES TABLE WHY YOU WERE NOT ABLE TO FETCH ALL THE RECORDS
-- FETCH ALL THE EMPLOYEE NAME AND THERE DEPARTMENT NAME THEY BELONG TO.
SELECT
    emp3.Emp_name,
    department.dept_name
FROM
    emp3 -- HERE emp3 IS LEFT TABLE
    LEFT JOIN department ON emp3.dept_id = department.dept_id;

-- SEQUENCE IS IMPORTANT
SELECT
    emp3.Emp_name,
    department.dept_name
FROM
    department -- HERE department IS LEFT TABLE
    LEFT JOIN emp3 ON emp3.dept_id = department.dept_id;

-- LEFT JOIN -> INNER JOIN -> ANY ADDITIONAL RECORDS IN LEFT TABLE
-- RIGHT JOIN 
SELECT
    emp3.Emp_name,
    department.dept_name
FROM
    emp3 -- HERE emp3 IS RIGHT TABLE
    RIGHT JOIN department ON emp3.dept_id = department.dept_id;

-- SEQUENCE IS IMPORTANT
SELECT
    emp3.Emp_name,
    department.dept_name
FROM
    department -- HERE department IS RIGHT TABLE
    RIGHT JOIN emp3 ON emp3.dept_id = department.dept_id;

-- RIGHT JOIN -> INNER JOIN -> ANY ADDITIONAL RECORDS IN RIGHT TABLE
-- FETCH DETAILS OF ALL EMPLOYEES 
-- THERE MANAGER
-- THERE DEPARTMENT 
-- PROJECTS THEY ARE WORKING ON
;

-- *.emp3
-- manager.Manager_name
-- department.dept_name
-- project.Project_name
;

-- MY QUERY TILL 
SELECT
    E.Emp_name,
    M.Manager_name,
    D.dept_name,
    P.Project_name
FROM
    emp3 AS E
    INNER JOIN manager AS M ON E.Manager_id = M.Manager_id
    INNER JOIN department AS D ON D.Dept_id = M.Dept_id
    INNER JOIN project AS P ON E.Emp_id = P.Team_member_id;

SELECT
    E.Emp_name,
    M.Manager_name,
    D.dept_name
FROM
    emp3 AS E
    INNER JOIN manager AS M ON E.Manager_id = M.Manager_id
    INNER JOIN department AS D ON D.Dept_id = M.Dept_id;

-- STEP 1
SELECT
    E.emp_name,
    D.dept_name
FROM
    emp3 AS E
    INNER JOIN department AS D ON E.dept_id = D.dept_id;

-- THE OUTPUT IS SHOWING ONLY THE 4 EMPLOYEES
-- TO SHOW DETAILS OF ALL THE EMPLOYEES WE ARE APPLYING LEFT JOIN 
-- BY KEEPING THE emp3 TABLE TO THE LEFT OF "LEFT JOIN" KEYWORD
-- STEP 2
SELECT
    E.emp_name,
    D.dept_name
FROM
    emp3 AS E
    LEFT JOIN department AS D ON E.dept_id = D.dept_id;

-- STEP 3
SELECT
    E.emp_name,
    D.dept_name,
    M.Manager_name
FROM
    emp3 AS E
    LEFT JOIN department AS D ON E.dept_id = D.dept_id
    INNER JOIN manager AS M ON M.Manager_id = E.Manager_id;

-- STEP 4
SELECT
    E.emp_name,
    D.dept_name,
    M.Manager_name,
    P.Project_name
FROM
    emp3 AS E
    LEFT JOIN department AS D ON E.dept_id = D.dept_id
    INNER JOIN manager AS M ON M.Manager_id = E.Manager_id
    INNER JOIN project AS P ON P.Team_member_id = E.Emp_id;

-- STEP 5
SELECT
    E.emp_name,
    D.dept_name,
    M.Manager_name,
    P.Project_name
FROM
    emp3 AS E
    LEFT JOIN department AS D ON E.dept_id = D.dept_id
    INNER JOIN manager AS M ON M.Manager_id = E.Manager_id
    LEFT JOIN project AS P ON P.Team_member_id = E.Emp_id;

-- INNER JOIN: RETURNS ONLY THE ROWS THAT HAVE MATCHING VALUES IN BOTH TABLES BASED ON THE JOIN CONDITION.
;

-- LEFT JOIN: RETURNS ALL ROWS FROM THE LEFT TABLE (TABLE1), AND THE MATCHED ROWS FROM THE RIGHT TABLE (TABLE2).
-- RETURNS NULL ON THE RIGHT SIDE IF THERE IS NO MATCH.
-- INNER JOIN + ALL THE REMAINING RECORDS FROM LEFT TABLE
;

-- RIGHT JOIN: RETURNS ALL ROWS FROM THE RIGHT TABLE (TABLE2), AND THE MATCHED ROWS FROM THE LEFT TABLE (TABLE1).
-- RETURNS NULL ON THE LEFT SIDE IF THERE IS NO MATCH.
-- INNER JOIN + ALL THE REMAINING RECORDS FROM RIGHT TABLE
;

-- FULL OUTER JOIN - FULL JOIN - INNER JOIN
-- + ALL THE REMAINING RECORDS FROM LEFT TABLE
-- + ALL THE REMAINING RECORDS FROM RIGHT TABLE
;

SELECT
    E.Emp_name,
    D.dept_name
FROM
    emp3 AS E FULL
    JOIN department D on d.dept_id = E.Dept_id;

-- MYSQL DOES'T SUPPORT FULL JOIN WE NEED TO USE UNION OVER THERE
SELECT
    E.Emp_name,
    D.dept_name
FROM
    emp3 AS E
    LEFT JOIN department D on d.dept_id = E.Dept_id
UNION
SELECT
    E.Emp_name,
    D.dept_name
FROM
    emp3 AS E
    RIGHT JOIN department D on d.dept_id = E.Dept_id;

-- LEFT JOIN -> LEFT OUTER JOIN
-- RIGHT JOIN -> LEFT OUTER JOIN
-- INNER JOIN -> JOIN
-- CROSS JOIN -> CARTESIAN JOIN
-- WHILE USING CROSS JOIN NO NEED TO USE ON KEYWORD
-- IT WONT JOIN 2 TABLES IT WILL MATCH EVERY RECORD FROM emp3 TABLE WITH EVERY RECORD FROM department TABLE
SELECT
    *
FROM
    emp3 AS E
    CROSS JOIN department D;

SELECT
    E.Emp_name,
    D.Dept_name
FROM
    emp3 AS E
    CROSS JOIN department D;

-- Company TABLE
CREATE TABLE company(
    company_id VARCHAR(10),
    company_name VARCHAR(50),
    location VARCHAR(20)
);

INSERT INTO
    company(company_id, company_name, location)
VALUES
    ("C001", "techTFQ Solutions", "Kuala Lumpur");

-- WRITE A QUERY TO FETCH THE EMPLOYEE NAME AND THEIR CORRESPONDING DEPARTMENT NAME.
-- ALSO MAKE SURE TO DISPLAY THE COMPANY NAME AND THE COMPANY LOCATION CORRESPONDING EACH EMPLOYEE
SELECT
    E.emp_name,
    D.dept_name
FROM
    emp3 AS E
    INNER JOIN department AS D ON E.dept_id = D.dept_id;

SELECT
    E.emp_name,
    D.dept_name,
    C.company_name,
    C.location
FROM
    emp3 AS E
    INNER JOIN department AS D ON E.dept_id = D.dept_id
    CROSS JOIN company AS C;

-- NATURAL JOIN 
-- NO NEED TO SPECIFY ON CLAUSE WHILE USING NATURAL JOIN
-- SQL WILL DECIDE THE ON CLAUSE BASED ON COLUMN NAME
SELECT
    E.emp_name,
    D.dept_name
FROM
    emp3 AS E NATURAL
    JOIN department D;

-- THE RESULT LOOKS LIKE INNER JOIN
-- THERE MIGHT BE 2 COLUMNS WITH SAME NAME IN 2 DIFFERENT TABLES WITH DIFFERENT VALUES IN IT
-- IF THERE ARE NO TWO TABLES WITH SAME NAME IT WILL PERFORM A CROSS JOIN
-- NOT RECOMMENDED
;

-- SELF JOIN
CREATE TABLE family (
    member_id VARCHAR(5),
    name VARCHAR (20),
    age INT,
    parent_id VARCHAR(5)
);

INSERT INTO
    family (
        member_id,
        name,
        age,
        parent_id
    )
VALUES
    ("F1", "David", 4, "F5"),
    ("F2", "Carlo", 10, "F5"),
    ("F3", "Michael", 12, "F5"),
    ("F4", "Johnson", 36, NULL),
    ("F5", "Maryam", 40, "F6"),
    ("F6", "Stewart", 70, NULL),
    ("F7", "Rohan", 6, "F4"),
    ("F8", "Ashe", 8, "F4");

-- IF WE WANT TO FIND THE RELATION BETWEEN FAMILY MEMBERS WE NEED TO USE INNER JOIN
-- THE CHALLENGE IS WE DO NOT HAVE A SEPTATE TABLE FOR THIS
-- WRITE A QUERY TO FETCH THE CHILD NAME AND THEIR AGE CORRESPONDING TO THEIR PARENT NAME ALONG WITH THEIR AGE
-- ONE RECORD FROM SAME TABLE MATCHES WITH THE OTHER RECORD FROM SAME TABLE WE USE SELF JOIN
SELECT
    CHILD.name AS CHILD_NAME,
    CHILD.age AS CHILD_AGE,
    PARENT.name AS PARENT_NAME,
    PARENT.age AS PARENT_AGE
FROM
    family AS CHILD
    INNER JOIN family AS PARENT ON CHILD.parent_id = PARENT.member_id;

-- RETURN ALL THE CHILDREN EVEN IF THE DO NOT HAVE ANY PARENT
SELECT
    CHILD.name AS CHILD_NAME,
    CHILD.age AS CHILD_AGE,
    PARENT.name AS PARENT_NAME,
    PARENT.age AS PARENT_AGE
FROM
    family AS CHILD
    LEFT JOIN family AS PARENT ON CHILD.parent_id = PARENT.member_id;

-- RETURN ALL THE PARENT EVEN OF THEY DO NOT HAVE CHILD
SELECT
    CHILD.name AS CHILD_NAME,
    CHILD.age AS CHILD_AGE,
    PARENT.name AS PARENT_NAME,
    PARENT.age AS PARENT_AGE
FROM
    family AS CHILD
    RIGHT JOIN family AS PARENT ON CHILD.parent_id = PARENT.member_id;