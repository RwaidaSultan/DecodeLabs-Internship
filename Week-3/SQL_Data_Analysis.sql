CREATE DATABASE ECommerceDB;
GO

USE ECommerceDB;
GO

SELECT TOP 10 *
FROM Orders;
--  Data Exploration
SELECT *
FROM Orders;

SELECT COUNT(*) AS Total_Records
FROM Orders;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Orders';
-- Check Missing Values
SELECT
COUNT(CASE WHEN OrderID IS NULL THEN 1 END) AS OrderID,
COUNT(CASE WHEN CustomerID IS NULL THEN 1 END) AS CustomerID,
COUNT(CASE WHEN CouponCode IS NULL THEN 1 END) AS CouponCode,
COUNT(CASE WHEN Product IS NULL THEN 1 END) AS Product,
COUNT(CASE WHEN TotalPrice IS NULL THEN 1 END) AS TotalPrice
FROM Orders;
-- Handle Missing Values
UPDATE Orders
SET CouponCode='No Coupon'
WHERE CouponCode IS NULL;

SELECT COUNT(*)
FROM Orders
WHERE CouponCode IS NULL;
-- Check Duplicate Rows
SELECT *,
COUNT(*) AS Duplicate_Count
FROM Orders
GROUP BY
OrderID,
Date,
CustomerID,
Product,
Quantity,
UnitPrice,
ShippingAddress,
PaymentMethod,
OrderStatus,
TrackingNumber,
ItemsInCart,
CouponCode,
ReferralSource,
TotalPrice
HAVING COUNT(*)>1;
-- Check Data Types
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Orders';

-- 1. Display selected columns
SELECT
    OrderID,
    Product,
    Quantity,
    TotalPrice
FROM Orders;

-- 2. Find all Laptop orders
SELECT *
FROM Orders
WHERE Product = 'Laptop';

-- 3. Find expensive orders
SELECT
    OrderID,
    Product,
    TotalPrice
FROM Orders
WHERE TotalPrice > 1000;
-- 4. Find orders with large quantities
SELECT
    OrderID,
    Product,
    Quantity
FROM Orders
WHERE Quantity >= 4;
-- 5. Sort products by price
SELECT
    OrderID,
    Product,
    TotalPrice
FROM Orders
ORDER BY TotalPrice DESC;
------------------------------------------ Aggregate Functions
-- 6. Total number of orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;
-- 7. Total revenue
SELECT SUM(TotalPrice) AS TotalRevenue
FROM Orders;
-- 8. Average order value
SELECT AVG(TotalPrice) AS AverageOrderValue
FROM Orders;
-- 9. Highest and lowest order value
SELECT
    MAX(TotalPrice) AS HighestOrder,
    MIN(TotalPrice) AS LowestOrder
FROM Orders;
---- GROUP BY
-- 10. Revenue by Product
SELECT
    Product,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY Product
ORDER BY TotalRevenue DESC;
-- 11. Number of Orders by Product
SELECT
    Product,
    COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY Product
ORDER BY NumberOfOrders DESC;
-- 12. Average Order Value by Product
SELECT
    Product,
    AVG(TotalPrice) AS AverageOrderValue
FROM Orders
GROUP BY Product
ORDER BY AverageOrderValue DESC;

-- 13. Revenue by Payment Method
SELECT
    PaymentMethod,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;
-- 14. Orders by Payment Method
SELECT
    PaymentMethod,
    COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY PaymentMethod
ORDER BY NumberOfOrders DESC;
-- 15. Revenue by Referral Source
SELECT
    ReferralSource,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY ReferralSource
ORDER BY TotalRevenue DESC;
-- 16. Orders by Referral Source
SELECT
    ReferralSource,
    COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY ReferralSource
ORDER BY NumberOfOrders DESC;
-- 17. Revenue by Order Status
SELECT
    OrderStatus,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalRevenue DESC;
-- 18. Monthly Revenue
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;
----- HAVING
-- 19. Products with Revenue Greater Than 180000
SELECT
    Product,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY Product
HAVING SUM(TotalPrice) > 180000
ORDER BY TotalRevenue DESC;

-- 20. Top 3 Products by Revenue
SELECT TOP 3
    Product,
    SUM(TotalPrice) AS TotalRevenue
FROM Orders
GROUP BY Product
ORDER BY TotalRevenue DESC;

