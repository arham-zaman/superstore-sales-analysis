# QUERY - 1 - Total Sales And Total Profit Of Each Region

SELECT 
	Region,
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit
FROM orders
GROUP BY Region
ORDER BY SUM(Sales) DESC;

#------------------------------------------------------------------------------------

# QUERY - 2 - Idnetifying Profit Margin For Each Category or Subcategory - Identiying Loss If Any

# Category Profit Margin check 

SELECT
	Category,
    SUM(profit) AS Total_Profit
FROM Orders
GROUP BY Category
ORDER BY Total_Profit DESC;

# Sub-Category Profit Margin Check

SELECT
	`Sub-Category`,
	SUM(profit) AS Total_Profit
FROM orders
GROUP BY `Sub-Category`
HAVING SUM(profit)<0
ORDER BY Total_Profit DESC;

#--------------------------------------------------------------------------------

# QUERY - 3 - Top 10 Product By Sales And Profit

SELECT 
	`Product Name`, 
	SUM(Sales) AS Total_Sales
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT 
	`Product Name`,
	SUM(profit) AS Total_Profit
FROM orders
GROUP BY `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;

#------------------------------------------------------------------------------------

# QUERY - 5 - Total Sales Trend By Each Month

SELECT MONTH(OrderDate_Fixed ) AS Month, SUM(Sales) AS Total_Sales 
FROM orders 
GROUP BY MONTH(OrderDate_Fixed ) 
ORDER BY  MONTH(OrderDate_Fixed )  ASC; 

#------------------------------------------------------------------------------------

# QUERY - 6 - Top 10 Customers Spending The Most

SELECT 
`Customer Name`,
SUM(Sales) AS Total_Sales
FROM orders
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

#----------------------------------------------------------------------------------------

# QUERY - 7 - AVG Order Value For Each Segment

SELECT
Segment,
AVG(Sales) AS Avg_Sales
FROM orders
GROUP BY Segment;

#------------------------------------------------------------------------------------------

# QUERY - 8 - Returned Orders Percentage  With Respect to total orders


SELECT
	(SELECT COUNT(DISTINCT `Order ID`) FROM orders) AS Total_orders ,
	(SELECT COUNT(DISTINCT `Order ID`) FROM returns) AS Returned_Orders,
	CONCAT(CAST(ROUND((SELECT COUNT(DISTINCT `Order ID`) FROM returns) * 100.0/ (SELECT COUNT(DISTINCT `Order ID`) FROM orders),2)as CHAR),'%')AS Returned_Orders_Percentage;
    
#------------------------------------------------------------------------------------------

# QUERY - 9 Category Having The Most Resturned Orders

SELECT 
o.Category,
COUNT(DISTINCT r.`Order ID`) AS returned_Count
FROM orders o
INNER JOIN returns r 
ON o.`Order ID`=r.`Order ID` 
GROUP BY o.Category
ORDER BY returned_Count DESC;

SELECT o.Category, 
       COUNT(DISTINCT o.`Order ID`) AS Total_Orders,
       COUNT(DISTINCT r.`Order ID`) AS Returned_Orders,
       CONCAT(ROUND(COUNT(DISTINCT r.`Order ID`) * 100.0 / COUNT(DISTINCT o.`Order ID`), 2),'%' )AS Return_Rate_Percent
FROM orders o
LEFT JOIN returns r ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY Return_Rate_Percent DESC;

    
#------------------------------------------------------------------------------------------

# QUERY - 10 - Returned Orders Profit and Loss

SELECT
SUM(o.Profit) AS Total_profit_On_Returns
FROM orders o
INNER JOIN returns r 
ON o.`Order ID` = r.`Order ID`;

#------------------------------------------------------------------------------------------

# QUERY - 11 - DOES MORE DISCOUNT AFFECT PROFIT?

SELECT
    CASE
        WHEN (Discount * 100 >= 0 AND Discount * 100 < 30) THEN 'LOW'
        WHEN (Discount * 100 >= 30 AND Discount * 100 < 60) THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS Discount_Category,
    AVG(Profit) AS Avg_Profit
FROM orders
GROUP BY Discount_Category;
SELECT COUNT(*) FROM orders;

