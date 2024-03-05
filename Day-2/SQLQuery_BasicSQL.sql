--SELECT TOP (1000) [EmployeeID]
--      ,[JobTitle]
--      ,[Salary]
--  FROM [SQL_tutorial_1].[dbo].[EmployeeSalary]

SELECT TOP 5 * FROM EmployeeDemographics 
SELECT DISTINCT(EmployeeID) FROM EmployeeDemographics -- distinct or unique in the relation (rows) EmployeeID
SELECT DISTINCT(Sex) FROM EmployeeDemographics -- distinct or unique in the relation(rows)
SELECT COUNT(Sex) FROM EmployeeDemographics -- it counts the number of relations that has a value sagot is 7
--hindi niya binibilang kung ilan yung Sex which is 2

SELECT COUNT(SEX) AS SE FROM EmployeeDemographics -- changing the field SEX to SE

SELECT MAX(Salary) FROM SQL_tutorial_1.dbo.EmployeeSalary -- find the maximum integer or value in the field Salary
-- can also use MIN, AVG

SELECT MAX(Salary) FROM EmployeeSalary


/*WHERE STATEMENTS
=, <>, <, >, >=, <=, And, Or, Like, Null, Not Null, In

*/

SELECT * FROM EmployeeDemographics WHERE FirstName = 'Isaac' -- Selecting the relation where the firstname is Isaac
SELECT * FROM EmployeeDemographics WHERE LastName <> 'Newton' -- Selecting the relation where the lastname is NOT Newton

SELECT * FROM EmployeeDemographics WHERE Age >= 38 -- Querying where age is greater than or equal to 38
SELECT * FROM EmployeeDemographics WHERE Age >= 38 AND SEX = 'Male' -- Double requirement

SELECT * FROM EmployeeDemographics WHERE FirstName IS NOT NULL -- not null literally
SELECT * FROM EmployeeDemographics WHERE FirstName IN ('Isaac', 'Exodus') 
-- finding the relation and field where the firstname is Isaac and Exodus
 
/*WILDCARD = usually used in text
using LIKE
*/

SELECT * FROM EmployeeDemographics WHERE  Age >=20 AND LastName LIKE 'S%' --Querying the rows where the age is
-- greater than and equal to 20 and where the last name STARTS with S

SELECT * FROM EmployeeDemographics WHERE Age >20 AND LastName LIKE 'S%ib%' 
-- additional parameter is that in the LastName whatever the place is we can find character ib
-- may mga limitations din, just read about it na lang


/* GROUP BY

*/

SELECT DISTINCT(Sex) FROM EmployeeDemographics -- showing us the distinct value, yun na yun

SELECT Sex FROM EmployeeDemographics GROUP BY Sex -- showing us the unique value tapos it is grouped into these value

SELECT Sex, COUNT(Sex) FROM EmployeeDemographics GROUP BY Sex 
-- here you can see it was grouped and was count how many of them

SELECT Sex, Age, COUNT(Sex) FROM EmployeeDemographics GROUP BY Sex, Age 
--

SELECT Sex, Age, COUNT(Sex) AS CountGender 
FROM EmployeeDemographics 
WHERE Age >30 
GROUP BY Sex, Age 
ORDER BY Sex ASC



SELECT Sex, COUNT(Sex) AS CountGender 
FROM EmployeeDemographics 
WHERE Age >30 
GROUP BY Sex
ORDER BY CountGender

SELECT * 
FROM EmployeeDemographics 
ORDER BY Age, Sex DESC

SELECT *
FROM EmployeeDemographics
ORDER BY 4, 5 DESC
