CREATE TABLE window_test (new_id INT, new_cat CHAR(255));

INSERT INTO
    window_test(new_id, new_cat)
VALUES
    (100, 'Agni'),
    (200, 'Agni'),
    (500, 'Dhrati'),
    (700, 'Dhrati'),
    (200, 'Vayu'),
    (300, 'Vayu'),
    (500, 'Vayu');

-- WINDOW FUNCTION USING AGGREGATE FUNCTION
-- SUM, AVG, COUNT, MIN, MAX
-- SUM
SELECT
    new_id,
    new_cat,
    SUM(new_id) OVER(PARTITION BY new_cat) AS TOTAL
FROM
    window_test;

SELECT
    new_id,
    new_cat,
    SUM(new_id) OVER(
        PARTITION BY new_cat
        ORDER BY
            new_cat
    ) AS TOTAL
FROM
    window_test;

-- AVG
SELECT
    new_id,
    new_cat,
    AVG(new_id) OVER (PARTITION BY new_cat) AS "AVG"
FROM
    window_test;

SELECT
    new_id,
    new_cat,
    AVG(new_id) OVER (
        PARTITION BY new_id
        ORDER BY
            new_cat
    ) AS "AVG"
FROM
    window_test;

-- COUNT
SELECT
    new_id,
    new_cat,
    COUNT(new_id) OVER (PARTITION BY new_id) AS "COUNT"
FROM
    window_test;

SELECT
    new_id,
    new_cat,
    COUNT(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY
            new_id
    ) AS "COUNT"
FROM
    window_test;

-- MIN
SELECT
    new_id,
    new_cat,
    MIN(new_id) OVER (PARTITION BY new_cat) AS "MIN"
FROM
    window_test;

SELECT
    new_id,
    new_cat,
    MIN(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY
            new_cat
    ) AS "MIN"
FROM
    window_test;

-- MAX 
SELECT
    new_id,
    new_cat,
    MAX(new_id) OVER (PARTITION BY new_cat) AS "MAX"
FROM
    window_test;

SELECT
    new_id,
    new_cat,
    MAX(new_id) OVER (
        PARTITION BY new_cat
        ORDER BY
            new_cat
    ) AS "MAX"
FROM
    window_test;

-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
-- WHICH WILL GIVE YOU SINGLE OUTPUT BASED ON INPUT VALUES
-- SUM
SELECT
    new_id,
    new_cat,
    SUM(new_id) OVER(
        ORDER BY
            new_id ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS "TOTAL"
FROM
    window_test;

-- AVG
SELECT
    new_id,
    new_cat,
    AVG(new_id) OVER(
        ORDER BY
            new_id ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS "AVG"
FROM
    window_test;

-- COUNT
SELECT
    new_id,
    new_cat,
    COUNT(new_id) OVER (
        ORDER BY
            new_id ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS "COUNT"
FROM
    window_test;

-- MIN
SELECT
    new_id,
    new_cat,
    MIN(new_id) OVER(
        ORDER BY
            new_id ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS "MIN"
FROM
    window_test;

-- MAX
SELECT
    new_id,
    new_cat,
    MAX(new_id) OVER(
        ORDER BY
            new_id ROWS BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
    ) AS "MAX"
FROM
    window_test;

-- WINDOW FUNCTION USING RANKING FUNCTION
-- ROW_NUMBER()  
-- ROW_NUMBER() is a window function in SQL that assigns a unique sequential integer to rows within a partition of a result set, starting at 1 for the first row in each partition
SELECT
    new_id,
    ROW_NUMBER() OVER(
        ORDER BY
            new_id
    ) AS "ROW_NUMBER"
FROM
    window_test;

-- RANK() 
-- RANK() is a window function in SQL that assigns a rank to each row within a partition of a result set, with gaps in the ranking values for ties.
SELECT
    new_id,
    RANK() OVER(
        ORDER BY
            new_id
    ) AS "RANK"
FROM
    window_test;

-- DENSE_RANK()
-- DENSE_RANK() is a window function in SQL that assigns a rank to each row within a partition of a result set without gaps in the ranking values for ties.
SELECT
    new_id,
    DENSE_RANK() OVER(
        ORDER BY
            new_id
    ) AS "DENSE_RANK"
FROM
    window_test;

-- PERCENT_RANK()
-- PERCENT_RANK() is a window function in SQL that calculates the relative rank of a row as a percentage of the total number of rows in the partition.
SELECT
    new_id,
    PERCENT_RANK() OVER(
        ORDER BY
            new_id
    ) AS "PERCENT_RANK"
FROM
    window_test;

-- WINDOW FUNCTION USING ANALYTICAl FUNCTION
-- FIRST VALUE
SELECT
    new_id,
    FIRST_VALUE(new_id) OVER(
        ORDER BY
            new_cat
    ) AS "FIRST_VALUE"
FROM
    window_test;

-- LAST VALUE
SELECT
    new_id,
    LAST_VALUE(new_id) OVER() AS "LAST_VALUE"
FROM
    window_test;

SELECT
    new_id,
    LAST_VALUE(new_id) OVER(
        ORDER BY
            new_cat
    ) AS "LAST_VALUE"
FROM
    window_test;

SELECT
    new_id,
    LAST_VALUE(new_id) OVER(
        ORDER BY
            new_id
    ) AS "LAST_VALUE"
FROM
    window_test;

-- LEAD 
SELECT
    new_id,
    LEAD(new_id) OVER() AS "LEAD"
FROM
    window_test;

SELECT
    new_id,
    LEAD(new_id) OVER(
        ORDER BY
            new_id
    ) AS "LEAD"
FROM
    window_test;

-- LAG
SELECT
    new_id,
    LAG(new_id) OVER(
        ORDER BY
            new_id
    ) AS "LAG"
FROM
    window_test;

