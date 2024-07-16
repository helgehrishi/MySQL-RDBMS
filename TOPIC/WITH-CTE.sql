-- WITH CLAUSE IS ALSO KNOWN AS CTE
-- CTE - COMMON TABLE EXPRESSION
CREATE TABLE emp4 (
    emp_id INT(5),
    emp_name VARCHAR(50),
    salary INT(10)
);

INSERT INTO
    emp4(emp_id, emp_name, salary)
VALUES
    (101, "Mohan", 40000),
    (102, "James", 50000),
    (103, "Robin", 60000),
    (104, "Carol", 70000),
    (105, "Alice", 80000),
    (106, "Jimmy", 90000);

-- FETCH EMPLOYEES WHO EARN MORE THAN AVERAGE SALARY OF ALL EMPLOYEES
-- SUB-QUERY FACTORING
SELECT
    *
FROM
    emp4 AS E
WHERE
    E.salary > "AVG_SALARY";

-- TO FIND "AVG_SALARY" WE NEED TO WRITE ANOTHER QUERY
WITH AVG_SALARY (AVG_SAL) AS (
    SELECT
        (ROUND(AVG(salary)))
    FROM
        emp4
)
SELECT
    *
FROM
    emp4 AS E,
    AVG_SALARY AS AVG_SAL
WHERE
    E.salary > AVG_SAL.AVG_SAL;

-- FIND STORES WHO'S WHERE BETTER THAN THE AVERAGE SALES ACROSS ALL STORES
SELECT
    *
FROM
    sales;

-- 1) TOTAL SALES PER EACH STORE -- TOTAL_SALES
SELECT
    S.store_id,
    SUM(S.cost) AS "TOTAL_SALES_PER_STORE"
FROM
    sales AS S
GROUP BY
    1;

-- 2) FIND THE AVERAGE SALES WITH RESPECT TO ALL THE STORES -- AVG_SALES
SELECT
    ROUND(AVG(TOTAL_SALES_PER_STORE)) AS AVG_SALES_FOR_ALL_STORES
FROM
    (
        SELECT
            S.store_id,
            SUM(S.cost) AS "TOTAL_SALES_PER_STORE"
        FROM
            sales AS S
        GROUP BY
            1
    ) AS X;

-- 3) FIND THE STORES WHERE TOTAL_SALES IS GREATER THAN AVG_SALES
SELECT
    *
FROM
    (
        SELECT
            S.store_id,
            SUM(S.cost) AS "TOTAL_SALES_PER_STORE"
        FROM
            sales AS S
        GROUP BY
            1
    ) AS TOTAL_SALES
    INNER JOIN (
        SELECT
            ROUND(AVG(TOTAL_SALES_PER_STORE)) AS AVG_SALES_FOR_ALL_STORES
        FROM
            (
                SELECT
                    S.store_id,
                    SUM(S.cost) AS "TOTAL_SALES_PER_STORE"
                FROM
                    sales AS S
                GROUP BY
                    1
            ) AS X
    ) AS AVG_SALES ON TOTAL_SALES.TOTAL_SALES_PER_STORE > AVG_SALES.AVG_SALES_FOR_ALL_STORES;

-- ABOVE LOGIC IS QUITE LENGTHY AND DIFFICULT TO READ
WITH TOTAL_SALES (store_id, TOTAL_SALES_PER_STORE) AS (
    SELECT
        S.store_id,
        SUM(S.cost) AS "TOTAL_SALES_PER_STORE"
    FROM
        sales AS S
    GROUP BY
        S.store_id
),
AVG_SALES (AVG_SALES_FOR_ALL_STORES) AS (
    SELECT
        ROUND(AVG(TOTAL_SALES_PER_STORE)) AS AVG_SALES_FOR_ALL_STORES
    FROM
        TOTAL_SALES
)
SELECT
    *
FROM
    TOTAL_SALES AS TS
    INNER JOIN AVG_SALES AS AV ON TS.TOTAL_SALES_PER_STORE > AV.AVG_SALES_FOR_ALL_STORES;