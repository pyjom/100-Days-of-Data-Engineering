

/* PARTITION BY

*/


SELECT *
FROM EmployeeSalary


SELECT *
FROM EmployeeDemographics

SELECT * ,
MAX(Salary) OVER (PARTITION BY Salary) AS Comparing_Max_Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID





/* CTE = Common Table Expression

*/

WITH CTE_Employee AS
(SELECT FirstName, LastName, Sex, Salary, 
COUNT(Sex)
OVER (PARTITION BY Sex) as TotalSex,
AVG(Salary)
OVER (PARTITION BY Sex) as AvgSalary
FROM EmployeeDemographics 
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE Salary > 500

)
SELECT FirstName, AvgSalary
FROM CTE_Employee

/* TEMP TABLES = Temporary Table

*/

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(50),
Salary int)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES (
1001, 'CEO', 50000)

INSERT INTO #temp_Employee
SELECT *
FROM EmployeeSalary



CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

SELECT *
FROM EmployeeSalary


-- incase you want to run it again, you will have to drop the existing table first
DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2


/* STRING FUNCION

*/

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50))

INSERT INTO EmployeeErrors VALUES
('1001', 'Marina', 'Summers'),
('1002', 'Ru', 'Paul'),
('1005', 'Michelle', 'Vissege')



UPDATE EmployeeErrors 
SET EmployeeID = '1001   '
WHERE LastName = 'Summers'

SELECT *
FROM EmployeeErrors

-- USING TRIM, LTRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- USING REPLACE
SELECT LastName, REPLACE (LastName, ' - Port','') as LastNameFixed
FROM EmployeeErrors

-- SUBSTRING
SELECT SUBSTRING(FirstName, 1, 3)
FROM EmployeeErrors

SELECT *
FROM EmployeeErrors
SELECT *
FROM EmployeeDemographics

SELECT SUBSTRING(Err.FirstName, 1, 3) AS ErrorTable, SUBSTRING(Demog.FirstName,1,3) AS DemogTable
FROM EmployeeErrors as Err
JOIN EmployeeDemographics as Demog
	ON SUBSTRING(Err.FirstName,1,3) = SUBSTRING(Demog.FirstName,1,3)


/* I asked Gemini to add code incase I want to match it with LastName, Age and Gender too

*/
SELECT Err.FirstName AS ErrorTableFirstName,
       Demog.FirstName AS DemogTableFirstName,
       Err.LastName AS ErrorTableLastName,
       Demog.LastName AS DemogTableLastName,
       Err.Age AS ErrorTableAge,
       Demog.Age AS DemogTableAge,
       Err.Gender AS ErrorTableGender,
       Demog.Gender AS DemogTableGender,
       SUM(CASE WHEN SUBSTRING(Err.FirstName, 1, 3) = SUBSTRING(Demog.FirstName, 1, 3) THEN 1 ELSE 0 END) +
       SUM(CASE WHEN Err.LastName = Demog.LastName THEN 1 ELSE 0 END) +
       SUM(CASE WHEN ABS(Err.Age - Demog.Age) <= 2 THEN 1 ELSE 0 END) +  -- Allow for slight age variations
       SUM(CASE WHEN Err.Gender = Demog.Gender THEN 1 ELSE 0 END) AS MatchScore
FROM EmployeeErrors AS Err
JOIN EmployeeDemographics AS Demog
    ON (SUBSTRING(Err.FirstName, 1, 3) = SUBSTRING(Demog.FirstName, 1, 3)  -- Initial fuzzy match on first name
        OR Err.LastName = Demog.LastName)  -- Exact match on last name
GROUP BY Err.FirstName, Demog.FirstName, Err.LastName, Demog.LastName, Err.Age, Demog.Age, Err.Gender, Demog.Gender
HAVING MatchScore >= 3;  -- Require a minimum match score to ensure accuracy

-- hindi ko yan nirun

/* Changing to UPPER or lower case

*/

SELECT FirstName, LOWER(FirstName) AS LoweredFirst, UPPER(FirstName) AS UpperedFirst 
FROM EmployeeErrors


/* STORED PROCEDURES

*/

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp_Employee
AS
SELECT *
FROM #temp_Employee2

EXEC Temp_Employee

/* SUBQUERIES also called NESTED QUERIES

*/

-- Subquery in SELECT

SELECT EmployeeID, Salary, (SELECT AVG (SALARY) FROM EmployeeSalary) AS OverallAvgSal
FROM EmployeeSalary

-- Subquery in Partition By

SELECT EmployeeID, Salary, AVG(Salary) OVER () AS OverallAvgSal
FROM EmployeeSalary

SELECT EmployeeID, Salary, AVG(Salary) OVER (PARTITION BY 1) AS OverallAvgSal
FROM EmployeeSalary


-- Group by doesnt work


-- Subquery in FROM (this method is slow, dont use this. Its better to use CTE/ temp table)

SELECT A.EmployeeID, OverallAvgSal
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS OverallAvgSal
		FROM EmployeeSalary) AS A


-- Subquery in WHERE
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age >30 )


