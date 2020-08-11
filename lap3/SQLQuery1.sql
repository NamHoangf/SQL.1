USE Adventureworks2016CTP3
SELECT * FROM Person.Person
--
SELECT Title, FirstName, MiddleName , LastName 
FROM Person.Person
--Gộp Tên 
SELECT Title + '.' + FirstName + '' + LastName AS 'Person Name' 
FROM Person.Person
--
SELECT * FROM Person.Address
--DISTINCT Chỉ trả về các giá trị khác nhau
SELECT DISTINCT (City) FROM Person.Address
--
SELECT TOP 10 * FROM Person.Address
--trích sô dòng dữ liệu 
SELECT TOP 25 PERCENT * FROM Person.Address
--Tính giá trị trung bình của rate trong bảng HumanResources.EmployeePayHistory
SELECT AVG(Rate) FROM HumanResources.EmployeePayHistory
--Trả về số hàng phù hợp với tiêu chí đã chỉ định
SELECT COUNT(BusinessEntityID) AS TitleCount 
FROM HumanResources.Employee
--