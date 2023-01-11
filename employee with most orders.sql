
What is the last name of the employee or employees who are responsible for the most orders?

WITH A AS (SELECT id, last_name, COUNT(*) orders
           FROM shopify_orders O JOIN shopify_employees E ON O.resp_employee_id = E.id
           GROUP BY id, last_name)

SELECT last_name 
FROM A 
WHERE orders = (SELECT MAX(orders) FROM A)
