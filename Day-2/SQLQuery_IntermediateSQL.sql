SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Sex]
  FROM [SQL_tutorial_1].[dbo].[EmployeeDemographics]

  -- Inserting Data with null values
  INSERT INTO EmployeeDemographics (FirstName,Age) VALUES ('Refri', 35);
  INSERT INTO EmployeeDemographics(EmployeeID, FirstName, LastName, Sex) VALUES (10, 'Moth', 'Thor', 'Female')
  INSERT INTO EmployeeSalary(EmployeeID, Salary) VALUES (9, 500)
  INSERT INTO EmployeeSalary(JobTitle, Salary) VALUES ('Delivery', 350)


  SELECT * FROM EmployeeSalary
  SELECT * FROM EmployeeDemographics

 /*JOINS
 
 
 */
  SELECT *
  FROM EmployeeDemographics
  INNER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- FULL OUTER JOIN
SELECT *
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- SELECTING the employee that has highest salary except Isaac, because a Salary cut will be implemented
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Isaac'
ORDER BY Salary DESC

-- Finding the average salary of a Delivery. It looks like we dont have to use join since salary and jobtitle can
-- be found in the DemographicsSalary table
SELECT JobTitle, AVG(Salary)
FROM EmployeeSalary
WHERE JobTitle = 'Delivery'
GROUP BY JobTitle

/*UNION and UNION ALL

*/
  SELECT *
  FROM EmployeeDemographics
  UNION
  SELECT *
  FROM EmployeeSalary

/*CASE statement

*/

-- creating a new column wheter it is young or old based on their age,
SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 60 THEN 'Old' 
	WHEN Age BETWEEN 30 AND 60 THEN 'Adult'
	WHEN Age BETWEEN 20 AND 30 THEN 'Young Adult'
	ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY AGE

-- Case with Join statements
-- raise the salary of sellers
SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Seller' THEN SALARY + (SALARY * .10)
	WHEN JobTitle = 'Delivery' THEN SALARY + (SALARY * .05)
	ELSE SALARY - (SALARY * .10)
END AS New_Salary
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/*HAVING

*/

-- What are the jobtitles in the database, and how many employees are there. 
-- Show only those jobs that has atleast 2 workers
SELECT JobTitle, COUNT(JobTitle) AS JobCount
FROM EmployeeSalary
GROUP BY JobTitle
HAVING COUNT(JobTitle)> 2

--
--
SELECT FirstName, Age, JobTitle, AVG(Salary) AS Ave_Salary
FROM EmployeeSalary
INNER JOIN EmployeeDemographics
	ON EmployeeSalary.EmployeeID = EmployeeDemographics.EmployeeID
GROUP BY JobTitle, FirstName, Age --Kailangan asa group by din yung first name at age
HAVING AVG(Salary) > 500
ORDER BY Ave_Salary DESC


/*Updating/ Deleting Table

*/

SELECT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 8, Sex = 'Male'
WHERE FirstName = 'Refri'



SELECT * 
FROM EmployeeDemographics
WHERE EmployeeID = 10

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 10


/*Aliasing

*/

-- Joining the character of two seperate fiels

SELECT Demog.FirstName, Sal.Salary
FROM EmployeeDemographics AS Demog
INNER JOIN EmployeeSalary AS Sal
	ON Demog.EmployeeID = Sal.EmployeeID


/*Partition By

*/

-- Basically sinasabi kung ilan ang babae or lalake
Select Demog.FirstName, Demog.LastName, Demog.Sex, Sal.Salary ,
COUNT(Sex) 
OVER (PARTITION BY Sex) AS TotalSex
FROM EmployeeDemographics AS Demog
JOIN EmployeeSalary AS Sal
	ON Demog.EmployeeID = Sal.EmployeeID


SELECT Sex, COUNT(Sex)
FROM EmployeeDemographics as Demog
JOIN EmployeeSalary as Sal
	ON Demog.EmployeeID = Sal.EmployeeID
GROUP BY Sex