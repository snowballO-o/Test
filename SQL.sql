Задание 1
CREATE TABLE table1 (date_column DATE);
SET @date := current_date;
SELECT @date := @date + INTERVAL FLOOR(RAND() * 6) + 2 DAY AS date_column
FROM (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS LIMIT 100) AS dummy;

Задание 2
CREATE TABLE employee (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30)
);
CREATE TABLE sales (
  id INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INTEGER,
  price INTEGER,
  FOREIGN KEY (employee_id)  REFERENCES employee (id)  ON DELETE CASCADE
);

INSERT INTO employee(name) VALUES ('jshfgjh'), ('kfjd'), ('hgf'), ('slkhf');
INSERT INTO sales(employee_id, price) VALUES (1, 200), (2, 460), (3, 123), (4, 340), (1, 234), (3, 50), (3, 50);


SELECT
  e.id,
  e.name,
  s.sales_c,
  RANK() OVER (ORDER BY s.sales_c DESC) AS sales_rank_c,
  s.sales_s,
  RANK() OVER (ORDER BY s.sales_s DESC) AS sales_rank_s
FROM
  employee e
JOIN (
  SELECT
    employee_id,
    COUNT(*) AS sales_c,
    SUM(price) AS sales_s
  FROM
    sales
  GROUP BY
    employee_id
) s ON e.id = s.employee_id
ORDER BY
  sales_rank_c ASC, sales_rank_s ASC;