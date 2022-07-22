DROP TABLE IF EXISTS parent_child;

CREATE TABLE parent_child (
    ID SERIAL PRIMARY KEY,
    FIRST_NAME VARCHAR(20) NOT NULL,
    LAST_NAME VARCHAR(20),
    PARENT_ID INTEGER REFERENCES parent_child
);


INSERT INTO parent_child
(
    FIRST_NAME, LAST_NAME, PARENT_ID
)
VALUES
	('Rosa',	'Wellington',	NULL),
	('Jon',	'Wellington',	1),
	('Joni',	'Wellington',	1),
	('Marge',	'Wellington',	1),
	('Mary',	'Dijkstra',	2),
	('Frank',	'Wellington',	2),
	('Jason',	'Wellington',	3),
	('Bobby',	'Wellington',	4),
	('Sammy',	'Wellington',	4),
	('Sarah',	'Wellington',	4),
	('Sam', 'Francis	Dijkstra',	5),
	('Stephen',	'Wellington',	6),
	('Trent',	'Wellington',	6),
	('June',	'Wellington',	9),
	('Josephine',	'Wellington',	9),
	('Suzy',	'Wellington',	9)
;

SELECT * FROM parent_child;


-- LIST ALL CHILDREN OF 1 PARENT

SELECT *
FROM parent_child
WHERE PARENT_ID = 1;

-- LIST A PARENT NODE FOR A CHILD NODE
SELECT CHILD.FIRST_NAME AS CHILD_NAME, PARENT.FIRST_NAME AS PARENT_NAME
FROM
    parent_child AS CHILD INNER JOIN parent_child AS PARENT ON
    CHILD.PARENT_ID = PARENT.ID

WHERE CHILD.ID = 11;

-- GET GENERATION NO FOR EACH NODE
WITH RECURSIVE generation AS (
    SELECT id,
        first_name,
        last_name,
        parent_id,
        0 AS generation_number
    FROM parent_child
    WHERE parent_id IS NULL

UNION ALL

    SELECT child.id,
        child.first_name,
        child.last_name,
        child.parent_id,
        generation_number+1 AS generation_number
    FROM parent_child child
    INNER JOIN generation g
      ON g.id = child.parent_id
)

SELECT first_name,
     last_name,
     generation_number
FROM generation;


WITH RECURSIVE generation AS (
    SELECT
        id,
        first_name,
        last_name,
        parent_id,
        0 AS generation_number
    FROM parent_child
    WHERE parent_id IS NULL

UNION ALL
    SELECT
        child.id,
        child.first_name,
        child.last_name,
        child.parent_id,
        generation_number + 1 AS generation_number
    FROM
        parent_child AS child
        INNER JOIN
        generation AS g
        ON
        child.parent_id = g.id
)
SELECT
    id,
    FIRST_NAME,
    LAST_NAME,
    parent_id,
    generation_number
FROM generation;

-- LIST ALL DEPENDENTS

WITH RECURSIVE generation AS (
    SELECT
        id,
        first_name,
        last_name,
        parent_id,
        0 AS generation_number
    FROM parent_child
    WHERE parent_id IS NULL

UNION ALL
    SELECT
        child.id,
        child.first_name,
        child.last_name,
        child.parent_id,
        generation_number + 1 AS generation_number
    FROM
        parent_child AS child
        INNER JOIN
        generation AS g
        ON
        child.parent_id = g.id
)
SELECT
    parent.id,
    g.FIRST_NAME as child_first_name,
    g.LAST_NAME as child_last_name,
    g.generation_number,
    parent.FIRST_NAME as parent_first_name,
    parent.LAST_NAME as parent_last_name
FROM generation AS G LEFT JOIN parent_child as parent ON g.parent_id = parent.id;


-- Reference
-- https://learnsql.com/blog/query-parent-child-tree/
