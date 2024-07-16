-- WHAT IS A SUB-QUERY? HOW DOES SQL PROCESS A STATEMENT CONTAINING SUB_QUERY?
-- FIND THE EMPLOYEES WHO'S SALARY IS MORE THAN 
-- THE AVERAGE SALARY EARNED BY ALL EMPLOYEES
;

--AVG SALARY EARNED BY EMPLOYEES
-- STEP 1
SELECT
    AVG(salary)
FROM
    employee;

-- STEP 2
SELECT
    *
FROM
    employee
WHERE
    salary > (5791.6667);

-- OR YOU CAN USE SUB QUERY OVER HERE
SELECT
    -- MAIN QUERY
    *
FROM
    employee
WHERE
    salary > (
        SELECT
            --- SUB QUERY
            AVG(salary)
        FROM
            employee
    );

-- THE SECOND WAY OF WRITING THE QUERY IS CALLED AS SUB QUERY
-- TYPES OF SUB QUERY
;

-- SCALAR SUB QUERY
-- Multiple ROW SUB QUERY
-- CORRELATED SUB QUERY 
;

-- SCALAR SUB QUERY : WILL ALWAYS RETURN ONE ROW AND ONE COLUMN
-- SCALER SUB QUERY IN WHERE CLAUSE
SELECT
    -- MAIN QUERY
    *
FROM
    employee
WHERE
    salary > (
        SELECT
            --- SUB QUERY
            AVG(salary)
        FROM
            employee
    );

-- THE ABOVE SUB QUERY RETURNS ONE RECORD
;

-- SCALER SUB QUERY IN ON CLAUSE
SELECT
    *
FROM
    employee AS E
    INNER JOIN (
        SELECT
            AVG(salary) AS SAL
        FROM
            employee
    ) AS AVG_SAL ON E.salary > AVG_SAL.sal;

-- MULTIPLE ROW SUB QUERY
-- SUB QUERY WHICH RETURNS MULTIPLE ROW AND MULTIPLE COLUMN
-- SUB QUERY WHICH RETURNS 1 COLUMN NAD MULTIPLE ROWS
;

-- FIND THE EMPLOYEES WHO EARN THE HIGHEST SALARY IN EACH DEPARTMENT
SELECT
    dept_name,
    MAX(salary)
FROM
    employee
GROUP BY
    1;

SELECT
    *
FROM
    employee
WHERE
    (dept_name, salary) IN (
        SELECT
            dept_name,
            MAX(salary)
        FROM
            employee
        GROUP BY
            1
    );

SELECT
    dept_name,
    MAX(salary)
FROM
    employee
GROUP BY
    1;

-- MULTIPLE ROW SUB QUERY 
-- SINGLE COLUMN MULTIPLE ROW SUB QUERY
-- FIND DEPARTMENT WITH NO EMPLOYEES
SELECT
    DISTINCT(dept_name)
FROM
    employee;

SELECT
    DISTINCT(D.dept_name)
FROM
    department AS D
    INNER JOIN employee AS E
WHERE
    D.dept_name NOT IN (
        SELECT
            DISTINCT(dept_name)
        FROM
            employee
    )
ORDER BY
    1;

-- CORRELATED SUB QUERY
-- SUB QUERY WHICH IS RELATED TO THE OUTER QUERY
-- FIND THE EMPLOYEES IN EACH DEPARTMENT WHO EARN MORE THAN 
-- THE AVG SALARY IN THAT DEPARTMENT
-- STEP 1
SELECT
    AVG(salary)
FROM
    employee
WHERE
    dept_name = "SPECIFIC DEPT";

-- STEP 2
SELECT
    *
FROM
    employee
WHERE
    salary > ("EACH DEPT");

-- STEP 3
SELECT
    *
FROM
    employee AS E1
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employee AS E2
        WHERE
            E2.dept_name = E1.dept_name
    )
ORDER BY
    E1.dept_name;

--
;

SELECT
    AVG(salary)
FROM
    employee E2
WHERE
    dept_name = ("EACH DEPARTMENT");

SELECT
    *
FROM
    employee AS E1
WHERE
    SALARY >("AVG SALARY OF EACH DEPT");

SELECT
    *
FROM
    employee AS E1
WHERE
    SALARY >(
        SELECT
            AVG(salary)
        FROM
            employee E2
        WHERE
            dept_name = (E1.dept_name)
    )
ORDER BY
    E1.dept_name;

-- FIND DEPARTMENT WHO DO NOT HAVE ANY EMPLOYEES
SELECT
    dept_name
FROM
    department
WHERE
    NOT EXIST = "DEPARTMENT PRESENT IN EMPLOYEE TABLE";

SELECT
    *
FROM
    department AS D
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            employee AS E
        WHERE
            E.dept_name = D.dept_name
    );

SELECT
    dept_name
FROM
    department AS D
WHERE
    NOT EXISTS(
        SELECT
            *
        FROM
            EMPLOYEE AS E
        WHERE
            D.dept_name = E.dept_name
    );

-- NESTED SUB QUERY
-- FIND STORES WHO'S SALES WHERE BETTER THAN 
-- THE AVERAGE SALES ACROSS ALL STORE
-- 1) TOTAL SALES FOR EACH STORE 
SELECT
    store_name,
    SUM(quantity * price)
FROM
    sales
GROUP BY
    1;

-- 2) AVG SALES FOR ALL THE STORES
SELECT
    AVG(SUM)
FROM
    (
        SELECT
            store_name,
            SUM(quantity * price) AS "SUM"
        FROM
            sales
        GROUP BY
            1
    ) AS X;

-- 3) COMPARE 1 & 2
SELECT
FROM
    (
        SELECT
            store_name,
            SUM(quantity * price) AS "SUM"
        FROM
            sales
        GROUP BY
            1
    ) AS SALES
    INNER JOIN
SELECT
    AVG(SUM)
FROM
    (
        SELECT
            store_name,
            SUM(quantity * price) AS "SUM"
        FROM
            sales
        GROUP BY
            1
    ) AS X;

-- NESTED SUB QUERY
-- FIND STORES WHO'S SALES WHERE BETTER THAN 
-- THE AVERAGE SALES ACROSS ALL STORE
-- 1. TOTAL ACROSS STORES
SELECT
    store_name,
    SUM(quantity * price) AS "SUM_STORE"
FROM
    sales
GROUP BY
    1;

-- 2. AVG OF SALES
SELECT
    AVG(SUM_STORE) AS "AVG_SALES"
FROM
    (
        SELECT
            store_name,
            SUM(quantity * price) AS "SUM_STORE"
        FROM
            sales
        GROUP BY
            1
    ) AS A;

--
SELECT
    store_name,
    SUM(price) AS "TOTAL_SALES"
FROM
    sales
GROUP BY
    1;

--
SELECT
    AVG(TOTAL_SALES)
FROM
    (
        SELECT
            store_name,
            SUM(price) AS "TOTAL_SALES"
        FROM
            sales
        GROUP BY
            1
    ) AS A;

-- NEED TO JOIN 2 TABLES
-- 1. TOTAL SALES_PER_STORE
SELECT
    store_name,
    SUM(price) AS "TOTAL_SALES"
FROM
    sales
GROUP BY
    1;

/*
 +---------------+-------------+
 | store_name    | TOTAL_SALES |
 +---------------+-------------+
 | Apple Store 1 |        7500 |
 | Apple Store 2 |        2000 |
 | Apple Store 3 |        9700 |
 | Apple Store 4 |        5000 |
 +---------------+-------------+
 */
-- 2. AVG SALES FROM ABOVE TABLE
SELECT
    AVG(TOTAL_SALES) AS "AVG_SALES"
FROM
    (
        SELECT
            store_name,
            SUM(price) AS "TOTAL_SALES"
        FROM
            sales
        GROUP BY
            1
    ) AS B;

/*
 +-----------+
 | AVG_SALES |
 +-----------+
 | 6050.0000 |
 +-----------+
 */
-- JOIN THE ABOVE 2 TABLES TO APPLY THE CONDITION
SELECT
    TABLE_1.store_name,
    TABLE_1.TOTAL_SALES
FROM
    (
        SELECT
            store_name,
            SUM(price * quantity) AS "TOTAL_SALES"
        FROM
            sales
        GROUP BY
            1
    ) AS TABLE_1
    INNER JOIN (
        SELECT
            AVG(TOTAL_SALES) AS "AVG_SALES"
        FROM
            (
                SELECT
                    store_name,
                    SUM(price * quantity) AS "TOTAL_SALES"
                FROM
                    sales
                GROUP BY
                    1
            ) AS B
    ) AS TABLE_2 ON TABLE_1.TOTAL_SALES > TABLE_2.AVG_SALES;

-- IN THE ABOVE EXAMPLE WE ARE USING SUB QUERY AGAIN AND AGAIN 
-- THIS IS THE PERFECT OCCASION TO USE WITH CLAUSE
WITH (
    SELECT
        store_name,
        SUM(price * quantity) AS "TOTAL_SALES"
    FROM
        sales
    GROUP BY
        1
) AS SALES
FROM
    (SALES) AS TABLE_1
    INNER JOIN (
        SELECT
            AVG(TOTAL_SALES) AS "AVG_SALES"
        FROM
            (SALES) AS B
    ) AS TABLE_2 ON TABLE_1.TOTAL_SALES > TABLE_2.AVG_SALES;

---
WITH SALES AS (
    SELECT
        store_name,
        SUM(price * quantity) AS TOTAL_SALES
    FROM
        sales
    GROUP BY
        store_name
),
AVG_SALES AS (
    SELECT
        AVG(TOTAL_SALES) AS AVG_SALES
    FROM
        SALES
)
SELECT
    S.store_name,
    S.TOTAL_SALES
FROM
    SALES S
    INNER JOIN AVG_SALES A ON S.TOTAL_SALES > A.AVG_SALES;

-- USING WITH CLAUSE TO AVOID REPARATION 
WITH SALES AS (
    SELECT
        store_name,
        SUM(price * quantity) AS TOTAL_SALES
    FROM
        sales
    GROUP BY
        store_name
)
SELECT
    S.store_name,
    S.TOTAL_SALES
FROM
    SALES S
    INNER JOIN (
        SELECT
            AVG(TOTAL_SALES) AS AVG_SALES
        FROM
            SALES
    ) A ON S.TOTAL_SALES > A.AVG_SALES;

-- DIFFERENT CLAUSES IN SQL WHERE YOU CAN USE SQL
-- SUB QUERY IN 
-- SELECT
-- FROM
-- WHERE
-- HAVING
;

-- USING SUB QUERY IN SELECT CLAUSE
-- FETCH ALL EMPLOYEE DETAILS AND ADD REMARKS TO THOSE EMPLOYEES
-- WHO EARN MORE THAN THE AVERAGE PAY
-- IT SHOULD BE A SCALAR SUB QUERY
SELECT
    *,
    (
        CASE
            WHEN salary > (
                SELECT
                    AVG(salary)
                FROM
                    employee
            ) THEN "HIGHER THAN AVG"
            ELSE null
        END
    ) AS "REMARK"
FROM
    employee;

-- THE ABOVE WAY IS NOT A BEST WAY OF WRITING A SUB QUERY
-- ALTERNATIVE TO WRITE THE ABOVE QUERY
SELECT
    *,
    CASE
        WHEN employee.salary > AVG_SAL.SALARY THEN 'HIGHER THAN AVG'
        ELSE null
    END AS 'REMARK'
FROM
    employee
    CROSS JOIN (
        SELECT
            AVG(salary) AS SALARY
        FROM
            employee
    ) AS AVG_SAL;

-- HAVING CLAUSE
-- FIND THE STORES WHO HAVE SOLD MORE UNITS THAN 
-- THE AVG UNITS SOLD BY ALL STORES.
-- 1. STORE   |   UNITS
SELECT
    store_name,
    SUM(quantity) AS QTY
FROM
    sales
GROUP BY
    1;

/*
 +---------------+------+
 | store_name    | QTY  |
 +---------------+------+
 | Apple Store 1 |    6 |
 | Apple Store 2 |    2 |
 | Apple Store 3 |   11 |
 | Apple Store 4 |    3 |
 +---------------+------+
 */
SELECT
    AVG(QTY) AS AVG_QTY
FROM
    (
        SELECT
            store_name,
            SUM(quantity) AS QTY
        FROM
            sales
        GROUP BY
            1
    ) AS STORE_QTY;

/*
 +---------+
 | AVG_QTY |
 +---------+
 |  5.5000 |
 +---------+
 */
SELECT
    TABLE_1.store_name,
    TABLE_1.QTY
FROM
    (
        SELECT
            store_name,
            SUM(quantity) AS QTY
        FROM
            sales
        GROUP BY
            1
    ) AS TABLE_1
    INNER JOIN (
        SELECT
            AVG(QTY) AS AVG_QTY
        FROM
            (
                SELECT
                    store_name,
                    SUM(quantity) AS QTY
                FROM
                    sales
                GROUP BY
                    1
            ) AS STORE_QTY
    ) AS TABLE_2 ON TABLE_1.QTY > TABLE_2.AVG_QTY;

-- USING HAVING
SELECT
    store_name,
    SUM(quantity)
FROM
    sales
GROUP BY
    1
HAVING
    SUM(quantity) > (
        SELECT
            AVG(QTY) AS AVG_QTY
        FROM
            (
                SELECT
                    store_name,
                    SUM(quantity) AS QTY
                FROM
                    sales
                GROUP BY
                    1
            ) AS STORE_QTY
    );

-- ALL THE SQL COMMANDS WHICH ALLOW SUB QUERY
-- SQL QUERY
-- INSERT
-- UPDATE
-- DELETE
;

-- INSERT 
-- INSERT DATA TO EMPLOYEE HISTORY TABLE.
-- MAKE SURE NOT INSERT DUPLICATE RECORDS.
SELECT
    *
FROM
    employee_history;

-- DESCRIBE employee_history
DESCRIBE employee_history;

INSERT INTO
    employee_history
SELECT
    E.emp_id,
    E.emp_name,
    D.dept_name,
    E.salary,
    D.location
FROM
    employee AS E
    INNER JOIN department AS D ON D.dept_name = E.dept_name
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            employee_history AS EH
        WHERE
            EH.emp_id = E.emp_id
    );

-- SUB QUERY IN UPDATE CLAUSE
-- GIVE 10% INCREMENT TO ALL EMPLOYEES IN BANGALORE LOCATION BASED ON 
-- THE MAXIMUM SALARY EARNED BY AN EMPLOYEE IN EACH DEPT.
-- ONLY CONSIDER EMPLOYEES IN employee_history table.
UPDATE
    employee AS E
SET
    salary = (
        SELECT
            MAX(salary) + (MAX(SALARY) * 0.1)
        FROM
            employee_history AS EH
        WHERE
            EH.dept_name = E.dept_name
    )
WHERE
    E.dept_name IN (
        SELECT
            dept_name
        FROM
            department
        WHERE
            location = 'Bangalore'
    )
    AND E.emp_id IN (
        SELECT
            emp_id
        FROM
            employee_history
    );

-- SUB QUERY IN DELETE STATEMENT
-- DELETE ALL DEPARTMENTS WHO DO NOT HAVE ANY EMPLOYEES
DELETE FROM
    department
WHERE
    dept_name IN ();

SELECT
    *
FROM
    department AS d
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            employee AS E
        WHERE
            E.dept_name = d.dept_name
    );