------What is the average yield (%) per stage and per product?-----
SELECT Stage, ProductName, 
       ROUND(AVG((OutputWeight_kg/InputWeight_kg)*100),2) AS AvgYield
FROM Pharma_ProcessPerformance_Extended
GROUP BY Stage, ProductName
ORDER BY Stage, ProductName;
----yield per batch---
SELECT BatchID, Stage, ProductName, ROUND((OutputWeight_kg / InputWeight_kg) * 100, 2) AS Yield
FROM Pharma_ProcessPerformance_Extended
ORDER BY BatchID;
---Which stage tends to have the lowest average yield overall?---
SELECT Stage, ROUND(AVG((OutputWeight_kg/InputWeight_kg)*100),2) AS AvgYield
FROM Pharma_ProcessPerformance_Extended
GROUP BY Stage
ORDER BY AvgYield desc;
----Are there any batches with yields below 97%? List them with product, stage, and operator.----
SELECT BatchID, ProductName, Stage, Operator, ROUND((OutputWeight_kg/InputWeight_kg)*100,2) AS YieldPercent
FROM Pharma_ProcessPerformance_Extended
WHERE ROUND((OutputWeight_kg/InputWeight_kg)*100,2)<97
ORDER BY YieldPercent;
-----Which operator consistently handles the most efficient runs?----
SELECT Operator, ROUND(AVG(OutputWeight_kg/InputWeight_kg)*100,2) AS AvgYield
FROM Pharma_ProcessPerformance_Extended
GROUP BY Operator
ORDER BY AvgYield desc;
----Which deviation types occur most often per stage?---
SELECT Stage, DeviationType, COUNT (*) AS DeviationCount
FROM Pharma_ProcessPerformance_Extended
GROUP BY Stage, DeviationType
ORDER BY DeviationCount desc;
-----Are deviations concentrated around specific operators or machines?----
SELECT DeviationType, Operator, MachineID, COUNT(*) AS DeviationCount
FROM Pharma_ProcessPerformance_Extended
WHERE DeviationType <> 'None'
GROUP BY DeviationType, Operator, MachineID
ORDER BY DeviationCount desc, DeviationType;
---operator with most deviation regardless of machines--
SELECT Operator,
    COUNT(*) AS TotalDeviations
FROM Pharma_ProcessPerformance_Extended
WHERE DeviationType <> 'None'
GROUP BY Operator
ORDER BY TotalDeviations DESC;
----How many batches per product experienced any deviation other than “None”?----
SELECT ProductName,
      COUNT(DISTINCT BatchID) AS BatcheswithDeviation
FROM Pharma_ProcessPerformance_Extended
WHERE DeviationType <> 'None'
GROUP BY ProductName
ORDER BY BatcheswithDeviation Desc;
---Which machine IDs are associated with more than 3 deviation events---
SELECT MachineID,
       COUNT(*) AS DeviationEvents
FROM Pharma_ProcessPerformance_Extended
GROUP BY MachineID
HAVING COUNT(*) > 3
ORDER BY DeviationEvents desc;
-----Does higher humidity (>50%) correlate with lower yield?----
SELECT CASE
            WHEN Humidity< 40 THEN 'Low'
            WHEN Humidity BETWEEN 40 AND 50 THEN 'Normal'
	   ELSE 'High'
	   END AS HumidityLevel,
	   ROUND(AVG(OutputWeight_kg/InputWeight_kg)*100,2) AS AvgYield
FROM Pharma_ProcessPerformance_Extended
GROUP BY CASE
            WHEN Humidity< 40 THEN 'Low'
            WHEN Humidity BETWEEN 40 AND 50 THEN 'Normal'
	   ELSE 'High'
	   END
ORDER BY AvgYield;
------Are certain months or days showing higher variability in humidity or temperature?---
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    ROUND(STDEV(Humidity), 2) AS HumiditySD,
    ROUND(STDEV(RoomTemp_C), 2) AS TempSD,
    COUNT(*) AS Records
FROM Pharma_ProcessPerformance_Extended
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;
----What’s the weekly trend in average yield or humidity?----
SELECT YEAR(Date) AS Year,
       DATEPART(WEEK,Date) AS WeekNumber,
	   ROUND(AVG(OutputWeight_kg/InputWeight_kg *100),2) AS AvgYield,
	   ROUND(AVG(Humidity),2) AS AvgHumidity,
	   ROUND(STDEV(Humidity),2) AS HumiditySD
FROM Pharma_ProcessPerformance_Extended
GROUP BY YEAR(Date), DATEPART(WEEK,Date)
ORDER BY WeekNumber;