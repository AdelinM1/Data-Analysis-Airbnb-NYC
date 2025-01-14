-- 1. What is the average price for each neighborhood?
SELECT neighbourhood, AVG(price) AS Avg_Price
FROM airbnb
GROUP BY neighbourhood
ORDER BY Avg_Price DESC;

-- 2. What are the top 10 most reviewed listings?
SELECT id, neighbourhood, room_type, number_of_reviews
FROM airbnb
ORDER BY number_of_reviews DESC
LIMIT 10;

-- 3. What is the price distribution across the different room types?
SELECT room_type, 
       CASE 
           WHEN price < 50 THEN 'Under $50'
           WHEN price BETWEEN 50 AND 150 THEN '$50 - $150'
           WHEN price BETWEEN 151 AND 300 THEN '$151 - $300'
           ELSE 'Above $300'
       END AS Price_Range,
       COUNT(*) AS Count
FROM airbnb
GROUP BY room_type, Price_Range
ORDER BY room_type, Price_Range;

-- 4. What is the average price by room type?
SELECT room_type, AVG(price) AS Avg_Price
FROM airbnb
GROUP BY room_type
ORDER BY Avg_Price DESC;

-- 5. What is the revenue Ccontribution by room type across neighborhoods?
SELECT 
    neighbourhood,
    room_type,
    SUM(price * days_occupied_in_2019) AS Total_Revenue,
    ROUND(SUM(price * days_occupied_in_2019) * 100.0 / SUM(SUM(price * days_occupied_in_2019)) OVER(PARTITION BY neighbourhood), 2) AS Revenue_Percentage
FROM airbnb
GROUP BY neighbourhood, room_type
ORDER BY neighbourhood, Revenue_Percentage DESC;