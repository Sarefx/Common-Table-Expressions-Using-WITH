--create CTEs using the WITH statement
WITH cte_name AS (
    -- sekect query goes here
)

--use CTEs like a table
SELECT * FROM cte_name

--example
WITH product_details AS (
    SELECT ProductName, CategoryName, UnitPrice, UnitsInStock
    FROM Products
    JOIN Categories ON PRODUCTS.CategoryId = Categories.Id
    WHERE Products.Discontinued = 0
)
SELECT * FROM product_details
ORDER BY CategoryName, ProductName

--example
WITH all_orders AS (
    SELECT EmployeeID, COUNT(*) AS order_count
    FROM Orders
    GROUP BY EmployeeID 
),
late_orders AS (
    SELECT EmployeeID, COUNT(*) AS order_count
    FROM Orders
    WHERE RequiredDate <= ShippedDate
    GROUP BY EmployeeID
)

SELECT Employees.ID, LastName,
all_orders.order_count AS total_order_count,
late_orders.order_count AS late_order_count
FROM Employees
JOIN all_orders ON Employees.ID = all_orders.EmployeeID
JOIN late_orders ON Employees.ID = late_orders.EmployeeID
