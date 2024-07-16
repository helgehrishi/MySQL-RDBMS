-- THE CASE EXPRESSION GOES THROUGH CONDITION AND RETURNS
-- A VALUE WHEN THE FIRST CONDITION IS MET (LIKE IF-THEN-ELSE)
-- IF NO CONDITION ISE MET (LIKE IF-THEN-ELSE) IF NO CONDITIONS ARE TRUE,
-- IT RETURNS THE VALUE IN THE ELSE CLAUSE.
-- IF THERE IS NO ELSE PART AND NO CONDITION ARE TRUE IT RETURNS NULL
;

-- CASE STATEMENT SYNTAX
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE other_result
END;

-- PAYMENT
CREATE TABLE payment(
    customer_id INT,
    amount INT,
    mode VARCHAR(50),
    payment_date DATE
);

INSERT INTO
    payment(customer_id, amount, mode, payment_date)
VALUES
    (1, 60, 'Cash', '2020-09-24'),
    (10, 70, 'mobile Payment', '2021-02-28'),
    (11, 80, 'Cash', '2021-03-01'),
    (2, 500, 'Credit Card', '2020-04-27'),
    (8, 100, 'Cash', '2021-01-26');

SELECT
    customer_id,
    amount,
    CASE
        WHEN amount > 100 THEN 'EXPENSIVE PRODUCT'
        WHEN amount = 100 THEN 'MODERATE PRODUCT'
        ELSE 'Inexpensive product'
    END AS PRODUCT_STATUS
FROM
    payment;

-- CASE EXPRESSION
CASE
    EXPRESSION
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    WHEN valueN THEN resultN
    ELSE other_result
END;

SELECT
    amount,
    customer_id,
    CASE
        amount
        WHEN 500 THEN 'Prime Customer'
        WHEN 100 THEN 'Plus Customer'
        ELSE 'Regular Customer'
    END AS CUST_STATUS
FROM
    payment;