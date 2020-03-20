# 1
SELECT * FROM employees WHERE city = "Seattle";
SELECT * FROM customers WHERE city = "Seattle";
SELECT DISTINCT CONCAT(employees.last_name, " ",employees.first_name),
				(SELECT COUNT(*) FROM employees WHERE city = "Seattle")+(SELECT COUNT(*) FROM customers WHERE city = "Seattle") as 'nombre de personnes de Seatles'
FROM (SELECT * FROM employees WHERE city = "Seattle") as employees;
# la requete
SELECT (SELECT COUNT(*) FROM employees WHERE city = "Seattle")+(SELECT COUNT(*) FROM customers WHERE city = "Seattle") as 'nombre de personnes de Seatles', last_name, first_name 
FROM (SELECT * FROM employees WHERE city = "Seattle" UNION SELECT * FROM customers WHERE city = "Seattle") as employees;

# 2
SELECT employees.* from employees
INNER JOIN employee_privileges ON employee_privileges.employee_id = employees.id
INNER JOIN privileges ON privileges.id = employee_privileges.privilege_id
WHERE privileges.privilege_name = "Purchase Approvals";