USE Northwind
SELECT * FROM Employees
--ss6.3
SELECT 'EmployeeID:' + CONVERT (char(4), EmployeeID)
FROM Employees
--ss6.4
CREATE TABLE Contacts
(MailID varchar(20),
Name text,
TelephoneNumber int)
--ss6.4.2
ALTER TABLE <Table_Name>
 ALTER COLUMN [<Column_name> <New_data_type>]
| ADD [<Column_name> <Data_Type>]
| DROP COLUMN [<Column _Name>]