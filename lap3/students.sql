CREATE DATABASE Student
GO
USE Student
GO

CREATE TABLE Student(
StudNo int Primary Key,
StudName nvarchar(50) NOT NULL,
StudAddr nvarchar(50),
StudPhone bigint,
BirthDate DateTime
);

INSERT INTO Student values
(1, 'Michael John', 'New York', 9145247891,'12-01-1989');

INSERT INTO Student values
(2, 'Anna Lombard','Alabama', 894252823, '8-25-1989');
INSERT INTO Student values

(3, 'Peter Dawson', 'California', 916562142,'02-15-1963');

INSERT INTO Student values
(4, 'Leonard Thornton','New Jersey', 894534533, '12-20-1991');

INSERT INTO Student values
(5, 'Elizabeth Isaac','Atlanta', 9149855771, '07-11-1990');

SELECT * FROM Student
--Thêm cột country
ALTER TABLE Student ADD Country nvarchar(20) NULL
--thêm dữ liệu vào cột country
UPDATE Student SET Country ='USA'
