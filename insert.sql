DROP TABLE IF EXISTS EMPLOYEE;

CREATE TABLE EMPLOYEE (
    ID SERIAL PRIMARY KEY,
    FIRST_NAME VARCHAR(20) NOT NULL,
    LAST_NAME VARCHAR(20),
    AGE INTEGER,
    SEX VARCHAR(1),
    INCOME DOUBLE PRECISION
);

SELECT * FROM EMPLOYEE;


INSERT INTO EMPLOYEE
    (
        FIRST_NAME,
        LAST_NAME,
        AGE,
        SEX,
        INCOME
    )
VALUES
    (
        'HIMANSHU',
        'SRIVASTAVA',
        34,
        'M',
        150000.00
    ),
    (
        'ABHILASHA',
        'ROOPAM',
        33,
        'F',
        100000.00
    )
RETURNING *
;


INSERT INTO EMPLOYEE
    (
        FIRST_NAME,
        LAST_NAME,
        SEX,
        INCOME
    )
VALUES
    (
        'ABC',
        'DEF',
        'M',
        150000.00
    ),
    (
        'DEF',
        'ROOPAM',
        'F',
        100000.00
    )
RETURNING *
;

COMMIT;

SELECT * FROM EMPLOYEE;
