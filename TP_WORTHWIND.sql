# 1
SELECT * FROM employees WHERE city = "Seattle";
SELECT * FROM customers WHERE city = "Seattle";
SELECT DISTINCT (SELECT COUNT(*) FROM employees WHERE city = "Seattle")+(SELECT COUNT(*) FROM customers WHERE city = "Seattle") as personnesSeatles FROM (SELECT * FROM employees WHERE city = "Seattle") as employees;