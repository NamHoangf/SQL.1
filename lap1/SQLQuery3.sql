USE AdventureWorks2016CTP3
SELECT LoginID, OrganizationNode, JobTitle
FROM HumanResources.Employee

DECLARE @deptID INT
SELECT @deptID=1
SELECT Name, GroupName FROm HumanResources.Department
WHERE DepartmentID = @deptID

SELECT @@LANGUAGE
SELECT @@VERSION
SELECT @@IDENTITY

SELECT SUM(StandardCost) FROM Production.ProductCostHistory

SELECT COUNT(*) FROM Production.ProductProductPhoto
SELECT * FROM Production.ProductProductPhoto

SELECT GETDATE()

SELECT DATEPART(hh,GETDATE())

SELECT CONVERT(Varchar(50), GETDATE(), 103)

SELECT DB_ID('AdventureWorks2016CTP3')

CREATE DATABASE EXAMPLE3

USE EXAMPLE3
CREATE TABLE Contacts
(MailID VARCHAR(20),
 Name NTEXT,
 TelephoneNumber INT)

 ALTER TABLE Contacts ADD Address NVARCHAR(50)

 INSERT INTO Contacts values ('abc@yahoo.com', N'Nguyen Van A', 090089, N'Ha nOi')
 INSERT INTO Contacts values ('ab3c@yahoo.com', N'Nguyen Van B', 090089, N'Ha nOi')
 INSERT INTO Contacts values ('ab2c@yahoo.com', N'Nguyen Van C', 090089, N'Ha nOi')
 INSERT INTO Contacts values ('ab4c@yahoo.com', N'Nguyen Van D', 090089, N'Ha nOi')

 SELECT * FROM Contacts

 DELETE FROm Contacts Where MailID='abc@yahoo.com'
 UPDATE Contacts SET Name 