select *
from OilandGas2009


--Different companies importing petroleum products

select R_S_NAME, COUNT(R_S_NAME) AS NoOfTimes
from OilandGas2009
GROUP BY R_S_NAME

--list of petroleum products

select PROD_NAME
from OilandGas2009
GROUP BY PROD_NAME

--List of petroleum products and the no of times they were imported

select PROD_NAME, count(PROD_NAME) as NoOfTimesImported
from OilandGas2009
GROUP BY PROD_NAME

--list of countries petroleum products were imported from

select CNTRY_NAME
from OilandGas2009
GROUP BY CNTRY_NAME

--list of countries petroleum products were imported from and the no of times they exported

select CNTRY_NAME, count(CNTRY_NAME) as NoOfTimesExported
from OilandGas2009
GROUP BY CNTRY_NAME

--list of ports used for imports 

select PORT_CITY
from OilandGas2009
GROUP BY PORT_CITY

--list of ports used for imports and the no of times they were used

select PORT_CITY, count(PORT_CITY) as NoOftimesTheyWereUsed
from OilandGas2009
GROUP BY PORT_CITY

--states that received imports

select PORT_STATE
from OilandGas2009
GROUP BY PORT_STATE

--states that received imports and the no of times they received

select PORT_STATE, count(PORT_STATE) as NoOfTimesTheyReceived
from OilandGas2009
GROUP BY PORT_STATE


--petroleum products with their sulfur content recorded


select PROD_NAME, SULFUR
FROM OilandGas2009
WHERE SULFUR is not null
group by PROD_NAME, SULFUR


--petroleum products with their API GRAVITY VALUES recorded

select PROD_NAME, APIGRAVITY
FROM OilandGas2009
WHERE SULFUR is not null
group by PROD_NAME, APIGRAVITY

--Earliest Reporting Date

Select min(RPT_PERIOD) as EarliestDate
from OilandGas2009

--Latest Reporting Date

Select max(RPT_PERIOD) as EarliestDate
from OilandGas2009


--which company imported the total highest quantity

select R_S_NAME, SUM(QUANTITY) as TotalQuantity
from OilandGas2009
GROUP BY R_S_NAME
ORDER BY TotalQuantity DESC


--which country exported the highest quantity

select CNTRY_NAME, SUM(QUANTITY) as TOTALquantity
from OilandGas2009
GROUP BY CNTRY_NAME
ORDER BY TOTALquantity DESC

--which petroleum product was imported the most

select PROD_NAME, SUM(QUANTITY) as TOTALquantity
from OilandGas2009
GROUP BY PROD_NAME
ORDER BY TOTALquantity DESC

--Which port handled the largest quantity of imports 

select PORT_CITY, SUM(QUANTITY) as TOTALquantity
from OilandGas2009
GROUP BY PORT_CITY
ORDER BY TOTALquantity DESC

--which state received the largest quantity

select PORT_STATE, SUM(QUANTITY) as TOTALquantity
from OilandGas2009
GROUP BY PORT_STATE
ORDER BY TOTALquantity DESC

--Total Quantity imported from each country

select CNTRY_NAME, SUM(QUANTITY) as TOTALquantity
from OilandGas2009
GROUP BY CNTRY_NAME
ORDER BY TOTALquantity DESC

--how many different products did each company import

select R_S_NAME, COUNT(DISTINCT PROD_NAME) AS NumberOfProducts
FROM OilandGas2009
GROUP BY R_S_NAME

--THIS WONT WORK BECAUSE IT SEPRATES THEM
select R_S_NAME, PROD_NAME, COUNT(DISTINCT PROD_NAME) AS NumberOfProducts
FROM OilandGas2009
GROUP BY R_S_NAME, PROD_NAME

--which company imported products from the most countries

select R_S_NAME, COUNT(DISTINCT CNTRY_NAME) AS NumberOfCountries
FROM OilandGas2009
GROUP BY R_S_NAME

--which port received products from canada
Select PORT_CITY
FROM OilandGas2009
where CNTRY_NAME = 'CANADA'

--Average API gravity for each product

SELECT PROD_NAME, AVG(APIGRAVITY) AS AvgAPIGRAVITY
FROM OilandGas2009
GROUP BY PROD_NAME

--Average SULFUR Content for each product
SELECT PROD_NAME, AVG(SULFUR) AS AvgSulfurContent
FROM OilandGas2009
GROUP BY PROD_NAME

--which month had the highest import quantity




--which month had the lowest import quantity




--which products were imported from more than one country

select PROD_NAME, COUNT(DISTINCT CNTRY_NAME) AS NumberOfCountries
FROM OilandGas2009
GROUP BY PROD_NAME
ORDER BY NumberOfCountries desc


--which companies imported residual fuel

select R_S_NAME 
FROM OilandGas2009
WHERE PROD_NAME LIKE 'Residual Fuel%'

--Rank companies by Total quantity imported
select R_S_NAME, SUM(QUANTITY) AS TotalQuantity
from OilandGas2009
group by  R_S_NAME
order by  TotalQuantity desc

select R_S_NAME, SUM(QUANTITY) AS TotalQuantity, RANK() OVER (ORDER BY SUM(QUANTITY) DESC) AS Ranking
from OilandGas2009
group by  R_S_NAME

--Rank countries by Total quantity exported
select CNTRY_NAME, SUM(QUANTITY) AS TotalQuantity
from OilandGas2009
group by  CNTRY_NAME
order by  TotalQuantity desc


select CNTRY_NAME, SUM(QUANTITY) AS TotalQuantity, RANK() OVER (ORDER BY SUM(QUANTITY) DESC) AS Ranking
from OilandGas2009
group by  CNTRY_NAME

--The above is for just 2009 dataset, you can also use those same codesto check out the 2010 data
--Now comparing 2009 and 2010 data


--Comparing 2009 and 2010 imports
select sum(a.QUANTITY) AS Imports2009, sum(b.QUANTITY) AS Imports2010
from OilandGas2009 a
cross join OilandGas2010 b

--which companies imported the same product in both years

Select A.R_S_NAME, A.PROD_NAME
from OilandGas2009 A
INNER join OilandGas2010 B
    ON A.R_S_NAME = B.R_S_NAME
    AND A.PROD_NAME = B.PROD_NAME
GROUP BY A.R_S_NAME, A.PROD_NAME
ORDER BY A.R_S_NAME, A.PROD_NAME

--OR

Select DISTINCT A.R_S_NAME, A.PROD_NAME
from OilandGas2009 A
INNER join OilandGas2010 B
    ON A.R_S_NAME = B.R_S_NAME
    AND A.PROD_NAME = B.PROD_NAME
ORDER BY A.R_S_NAME, A.PROD_NAME

--Which ports were active in both years

Select DISTINCT A.PORT_CITY, A.PORT_CODE
from OilandGas2009 A
INNER join OilandGas2010 B
    ON  A.PORT_CITY = B.PORT_CITY
    AND A.PORT_CODE = B.PORT_CODE
ORDER BY A.PORT_CITY, A.PORT_CODE


--Which products increased in import quantity from 2009 to 2010

Select  A.PROD_NAME, SUM(A.QUANTITY) AS TOTAL2009, SUM(B.QUANTITY) AS TOTAL2010
from OilandGas2009 A
INNER join OilandGas2010 B
    ON A.PROD_NAME = B.PROD_NAME
GROUP BY  A.PROD_NAME
HAVING SUM(B.QUANTITY) > SUM(A.QUANTITY)
ORDER BY TOTAL2010 DESC

--Which countries exported more products in 2010 than in 2009

select A.CNTRY_NAME, A.TOTAL2009, B.TOTAL2010
FROM( SELECT CNTRY_NAME, SUM(QUANTITY) AS TOTAL2009
      FROM OILandGas2009
      GROUP BY CNTRY_NAME) A
INNER JOIN (SELECT CNTRY_NAME, SUM(QUANTITY) AS TOTAL2010
      FROM OILandGas2010
      GROUP BY CNTRY_NAME) B
      ON A.CNTRY_NAME = B.CNTRY_NAME
WHERE  B.TOTAL2010 > A.TOTAL2009
ORDER BY B.TOTAL2010 DESC

--Each country's percentage contribution to total imports


--for 2009
select CNTRY_NAME, SUM(QUANTITY) AS TotalImports, ROUND(SUM(QUANTITY) * 100 / (SELECT SUM(QUANTITY) FROM OilandGas2009), 2) As PercentageContribution
From OilandGas2009
group by CNTRY_NAME
ORDER BY PercentageContribution DESC

--for 2010
select CNTRY_NAME, SUM(QUANTITY) AS TotalImports, ROUND(SUM(QUANTITY) * 100 / (SELECT SUM(QUANTITY) FROM OilandGas2010), 2) As PercentageContribution
From OilandGas2010
group by CNTRY_NAME
ORDER BY PercentageContribution DESC

--for both combined

SELECT
    CNTRY_NAME,
    SUM(QUANTITY) AS Total_Imports,
    ROUND(
        SUM(QUANTITY) * 100.0 /
        (
            SELECT SUM(QUANTITY)
            FROM
            (
                SELECT QUANTITY FROM OilandGas2009
                UNION ALL
                SELECT QUANTITY FROM OilandGas2010
            ) AS TotalImports
        ),
        2
    ) AS Percentage_Contribution
FROM
(
    SELECT CNTRY_NAME, QUANTITY
    FROM OilandGas2009

    UNION ALL

    SELECT CNTRY_NAME, QUANTITY
    FROM OilandGas2010
) AS CombinedData
GROUP BY CNTRY_NAME
ORDER BY Percentage_Contribution DESC;

--compare average API gravity by country

--for 2009

select CNTRY_NAME, AVG(APIGRAVITY) AS AverageAPIGravity
from OilandGas2009
WHERE APIGRAVITY IS NOT NULL
GROUP BY CNTRY_NAME 
ORDER BY AverageAPIGravity DESC

--for 2010

select CNTRY_NAME, AVG(APIGRAVITY) AS AverageAPIGravity
from OilandGas2010
WHERE APIGRAVITY IS NOT NULL
GROUP BY CNTRY_NAME 
ORDER BY AverageAPIGravity DESC

--comparing both combined

SELECT
    A.CNTRY_NAME,
    A.Average_API_2009,
    B.Average_API_2010
FROM
(
    SELECT
        CNTRY_NAME,
        AVG(APIGRAVITY) AS Average_API_2009
    FROM OilandGas2009
    WHERE APIGRAVITY IS NOT NULL
    GROUP BY CNTRY_NAME
) A
INNER JOIN
(
    SELECT
        CNTRY_NAME,
        AVG(APIGRAVITY) AS Average_API_2010
    FROM OilandGas2010
    WHERE APIGRAVITY IS NOT NULL
    GROUP BY CNTRY_NAME
) B
ON A.CNTRY_NAME = B.CNTRY_NAME
ORDER BY A.CNTRY_NAME;