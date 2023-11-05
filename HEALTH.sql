--DATA EXPLORAITON

SELECT * FROM HEALTH

--CHACKING DATA TYPES AND FIX IT IF INDEED 

ALTER TABLE HEALTH ALTER COLUMN Year DATE

ALTER TABLE HEALTH ALTER COLUMN Population INT

ALTER TABLE HEALTH ALTER COLUMN Life_expectancy INT 

ALTER TABLE HEALTH ALTER COLUMN GDP INT 


--SELECT BASIC RECORDS 

SELECT  Country, Year, Population, Adult_Mortality, infant_deaths FROM HEALTH
group by   Country, Year, Population, Adult_Mortality, infant_deaths
HAVING Population    is not null 
order by Country

--RELATIONSHIP BETWEEN Adult_Mortality AND POPULATION

SELECT  Country, Year, Population, Adult_Mortality, ( Adult_Mortality / Population)*100 AS Adult_Mortality_PERCENTAGE
FROM HEALTH
group by   Country, Year, Population, Adult_Mortality 
HAVING Population    is not null 
order by Country

-- TOTAL DEATH RATE 

SELECT  Country, Year, Population, Adult_Mortality, infant_deaths
,(Adult_Mortality + infant_deaths)  AS TOTAL_DEATH,((Adult_Mortality + infant_deaths)/Population)*100  AS TOTAL_DEATH_RATE  
FROM HEALTH
group by   Country, Year, Population, Adult_Mortality, infant_deaths
HAVING Population    is not null 
order by Country

--RELATIONSHIP BETWEEN Adult_Mortality AND  HIV/AIDS

SELECT  Country, Year, Population, Adult_Mortality,  [ HIV/AIDS] AS AIDS_DEATH_RATE
FROM HEALTH
group by   Country, Year, Population, Adult_Mortality,  [ HIV/AIDS]
HAVING Population    is not null 
order by Country

--RELATIONSHIP BETWEEN TOTAL_PATIONT AND POPULATION

SELECT  Country, Year, Population, (Hepatitis_B + Measles + Polio + Diphtheria ) AS TOTAL_PATIONT ,
((Hepatitis_B + Measles + Polio + Diphtheria ) /Population)*100 AS PATIONT_PERCENTAGE
FROM HEALTH
group by   Country, Year, Population, Adult_Mortality, Hepatitis_B, Measles, Polio, Diphtheria
HAVING Population    is not null 
order by Country

----RELATIONSHIP BETWEEN TOTAL_PATIONT AND Life_expectancy 

SELECT  Country, Year, Population, Adult_Mortality, (Hepatitis_B + Measles + Polio + Diphtheria ) AS TOTAL_PATIONT,
(Adult_Mortality/(Hepatitis_B + Measles + Polio + Diphtheria ))*100 AS PATIONT_DEATH_PERCENTAGE   
FROM HEALTH
group by   Country, Year, Population, Adult_Mortality,  Hepatitis_B, Measles, Polio, Diphtheria
HAVING Population    is not null 
order by Country



-- cleaning data 

--check for null value in data and delete it  .

delete  FROM HEALTH
WHERE Population is null

-- GET_MAX_POPULATION

SELECT Population AS highest_population, Country, Status
FROM HEALTH
WHERE Population = (SELECT MAX(Population) FROM HEALTH);

--GET_MAX_ADULT_MORTALITY

SELECT Adult_Mortality AS highest_Adult_Mortality, Country,Status
FROM HEALTH
WHERE Adult_Mortality = (SELECT MAX(Adult_Mortality) FROM HEALTH);


--USING STORE PROCEDURE TO GET SPICIFIED DATA 

CREATE PROCEDURE  status_INFO (@status AS nvarchar(255))

AS
BEGIN

SELECT 
Status,Year, Life_expectancy, Adult_Mortality, Population
FROM HEALTH
WHERE Status = @status
ORDER BY Population 

END


EXEC  status_INFO 
@status = developing  


EXEC  status_INFO 
@status = developed   

--DROP UNNECESSARY DATA

alter table	HEALTH
DROP COLUMN THINESSSS, THINNESS, Schooling, Income_composition_of_resources, percentage_expenditure 







