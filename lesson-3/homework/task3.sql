use lesson3;
go

-- Selects distinct product categories.
SELECT DISTINCT Category
FROM Products;


-- Finds the most expensive product in each category.
SELECT p.Category,
       p.ProductName,
       p.Price
FROM Products p
WHERE p.Price = (
    SELECT MAX(Price)
    FROM Products
    WHERE Category = p.Category
)
ORDER BY p.Category;

-- Assigns an inventory status using IIF:
	--'Out of Stock' if Stock = 0.
	--'Low Stock' if Stock is between 1 and 10.
	--'In Stock' otherwise.
SELECT 
    Category,
    ProductName,
    Price,
    IIF(Stock = 0, 'Out of Stock', 
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products
ORDER BY Category;


-- Orders the result by Price descending and skips the first 5 rows.
SELECT 
    Category,
    ProductName,
    Price,
    IIF(Stock = 0, 'Out of Stock', 
        IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS;
