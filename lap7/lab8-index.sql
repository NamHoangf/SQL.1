CREATE DATABASE Lab10

USE AdventureWorks2016CTP3
SELECT*INTO Lab10 FROM Production.WorkOrder

USE Lab10
SELECT*INTO WordOrderIXx FROM WorkOrder

SELECT * FROM WorkOrder
SELECT *  FROM WordOrderIXx

CREATE INDEX IX_WorkOrderID ON WordOrderIXx(WorkOrderID)

SELECT*FROM WorkOrder where WorkOrderID = 7200
SELECT*FROM WordOrderIXx where WorkOrderID =7200


--Phần III: 
IF(DB_ID('Aptech') IS NOT NULL)
   DROP DATABASE Aptech
ELSE 
   CREATE DATABASE Aptech
GO
USE Aptech
GO

CREATE TABLE Classes (
 ClassName char(6) unique with (Pad_index=on, FillFactor = 70,Ignore_Dup_Key =On),
 Teacher varchar(30), --constraint  TeacherIndex  unique NONCLUSTERED not null ,
 TimeSlot varchar(30),
 Class int,
 Lab int
)
--Tạo an unique, clustered index tên là MyClusteredIndex trên trường ClassName
--CREATE CLUSTERED INDEX IX_ClassName 
--ON Classes(ClassName) WITH (Pad_index=on, FillFactor = 70)
--ALTER TABLE Classes ADD UNIQUE(ClassName)
--ALTER TABLE Classes REBUILD WITH (Ignore_Dup_Key =On)
--
https://sqltimes.wordpress.com/2014/12/13/sql-server-ignore_dup_key-setting-influences-unique-index-and-non-unique-index-behavior/
CREATE UNIQUE CLUSTERED INDEX IX_ClassName 
ON Classes(ClassName) WITH (Pad_index=on, FillFactor = 70,Ignore_Dup_Key =On )
--

--Tạo a nonclustered index tên là TeacherIndex trên trường Teacher
CREATE NONCLUSTERED INDEX TecharIndex ON Classes(Teacher)
--Xóa chỉ mục TeacherInde
DROP INDEX TecharIndex ON Classes
--Tạo lại MyClusteredIndex
-- DROP_EXISTING = ON , SQL Server sẽ loại bỏ và xây dựng lại chỉ mục được phân cụm / không phân cụm hiện có với các đặc tả chỉ mục được sửa đổi, giữ nguyên tên chỉ mục như nó tồn tại. Chúng ta có thể thêm / bớt cột, sửa đổi thứ tự sắp xếp hoặc thay đổi nhóm tệp.
--ALLOW_PAGE_LOCKS Chỉ định xem có cho phép khóa trang hay không. Mặc định là BẬT.

CREATE UNIQUE CLUSTERED INDEX IX_ClassName 
ON Classes(ClassName) WITH (DROP_EXISTING =ON, ALLOW_PAGE_LOCKS= ON, MAXDOP = 2) 
https://docs.microsoft.com/en-us/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15

--5.Tạo một composite index tên là ClassLabIndex trên 2 trường Class và Lab. 
CREATE INDEX Class_Lab_Index
ON Classes (Class, Lab)
--. Viết câu lệnh xem toàn bộ các chỉ mục của cơ sở dữ liệu Aptech. 
CREATE STATISTICS Thong_ke ON Classes(ClassName)
 
DBCC SHOW_STATISTICS (Classes, ClassName)
https://zarez.net/?p=1093

--PhanIV: 
CREATE DATABASE RiverPlate
GO
USE RiverPlate
GO

CREATE TABLE Student(
  StudentNo int PRIMARY KEY,
  StudentName varchar(50),
  StudentAddress varchar(100),
  PhoneNO int 
)

CREATE TABLE Department (
  DeptNO int PRIMARY KEY,
  DeptName varchar(50),
  ManagerName char(30)
)

CREATE TABLE Assignment (
  AssignmentNo int PRIMARY KEY,
  Description varchar(100)
)

CREATE TABLE Works_Assgin(
  JobID int PRIMARY KEY,
  StudentNo int,
  AssignmentNo int,
  TotalHours int,
  JobDetails XML,
  CONSTRAINT FK_Student FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo),
  CONSTRAINT FK_AssignmentNo FOREIGN KEY (AssignmentNo) REFERENCES Assignment(AssignmentNo)
)
--Người quản lý trường RiverPlate muốn hiển thị tên của sinh viên và mã số sinh viên của họ. Tạo
--một clustered index tên là IX_Student trên cột StudentNo của bảng Student, trong khi chỉ mục
--được tạo, các bảng và các chỉ mục có thể được sử dụng để truy vấn và thay đổi dữ liệu. 
CREATE UNIQUE NONCLUSTERED INDEX IX_Student
ON Student(StudentName)
--2.Chỉnh sửa và xây dựng lại (rebuild) IX_Student đã được tạo trên bảng Student trong đó các bảng
--và chỉ mục không thể sử dụng để truy vấn và thay đổi dữ liệu. 
ALTER INDEX IX_Student ON Student DISABLE 
--3Người quản lý trường đại học RiverPlate muốn lấy ra tên nhóm làm việc, người quản lý nhóm và
--mã số nhóm. Tạo một chỉ notclustered index tên là IX_Dept trên bảng Department sử dụng
--trường khóa DeptNo và 2 trường không khóa DeptName và DeptManagerNo. 
CREATE NONCLUSTERED INDEX IX_Dept 
ON Department(DeptName, ManagerName) WITH (ALLOW_ROW_LOCKS = ON)
