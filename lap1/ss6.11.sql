/* CREATE TABLE NewEmployees (EmployeeID smallint, FirstName char(10),
LastName char(10), Department varchar(50), HiredDate datetime, Salary
money );
INSERT INTO NewEmployees
VALUES(11,'kevin','Blaine',"Reserach','2006-07-31 00:00:00.000',54000);
WITH EmployeeTemp (EmployeeID, FirstName, LastName, Department,
HiredDate, Salary)
AS
(SELECT * FROM NewEmployees
)
INSERT INTO Employees
SELECT * FROM EmployeeTemp */

CREATE TABLE OutputTest
(
   KeyID int Identity,
   Name char(20)
)
INSERT INTO OutputTest (Name) VALUES('Jim')
INSERT INTO OutputTest (Name) VALUES('Markus')

DECLARE @UpdatedTable TABLE
(
    UpdateTableID int, OldData varchar(20), NewData varchar(20)
)
UPDATE OutputTest
  SET Name = UPPER(Name)
OUTPUT
   Inserted.KeyID,
   Deleted.Name,
   Inserted.Name
INTO @UpdatedTable
SELECT * FROM @UpdatedTable