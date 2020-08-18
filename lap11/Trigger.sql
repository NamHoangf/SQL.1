--CREATE DATABASE Lab13--Tạo CSDL Lab13
GO
USE AdventureWorks2016CTP3
GO
--Sao chép 3 cột ProductID, Name và Color từ bảng Production.Product của database
--AdventureWorks
--sang CSDL Lab13
SELECT ProductID, Name, Color INTO Lab13.dbo.Product FROM Production.Product
GO
USE Lab13
GO
--Hiển thị bảng Product vừa sao chép được
SELECT * FROM Product

CREATE TRIGGER UpdateProduct
ON Product
FOR UPDATE
AS
 BEGIN
 IF(UPDATE(Name))
 BEGIN
 PRINT 'Khong duoc phep thay doi ten san pham';
 ROLLBACK TRANSACTION;
 END
 END

 UPDATE Product SET Name = 'Cocacola' WHERE ProductID = 1


 --Phần III: Bài tập tự làm – 45 phút  --1. Tạo một INSERT trigger có tên là checkCustomerOnInsert cho bảng Customers. Trigger này có
--nhiệm vụ kiểm tra thao tác chèn dữ liệu cho bảng Customer, xem trường Phone có phải là null hay
--không, nếu trường Phone là null thì sẽ không cho tiến hành chèn dữ liệu vào bảng này. 
CREATE DATABASE Lab11
GO
USE Northwind
GO

SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Phone,Fax
INTO Lab11.dbo.Customers FROM Northwind.dbo.Customers
GO
USE Lab11
GO
SELECT * FROM Customers

CREATE TRIGGER checkCustomerOnInsert
ON Customers
FOR INSERT 
AS 
    BEGIN 
	    if EXISTS (SELECT * FROM inserted WHERE Phone = NULL )
		BEGIN 
		 PRINT 'Khong THe CHen Vao DU LIeu';
		 ROLLBACK TRANSACTION;
		 END
	END
GO

--2. Tạo một UPDATE trigger với tên là checkCustomerContryOnUpdate cho bảng Customers.
--Trigger này sẽ không cho phép người dùng thay đổi thông tin của những khách hàng mà có tên
--nước là France.

CREATE TRIGGER checkCustomerContryOnUpdate
ON Customers
FOR UPDATE
AS 
   BEGIN 
      Update Customers SET City='London' 
	  BEGIN 
	     PRINT 'kHONG DUOC Thay doi thong tin khach Hang'
		 ROLLBACK TRANSACTION;
	  END
	END
GO
UPDATE Customers SET CompanyName = 'Around the Urn' WHERE CustomerID='AROUT'
select CustomerID,CompanyName
from dbo.Customers where City = 'London'


--Chèn thêm một cột mới có tên là Active vào bảng Customers và cài đặt giá trị mặc định cho nó là
--1. Tạo một trigger có tên là checkCustomerInsteadOfDelete nhằm chuyển giá trị của cột Active
--thành 0 thay vì tiến hành xóa dữ liệu thực sự ra khỏi bảng khi thao tác xóa dữ liệu được tiến hành. 
SELECT *
from Customers
ALTER TABLE Customers 
ADD Active int NOT NULL DEFAULT (1)

CREATE TRIGGER checkCustomerInsteadOfDelete
ON Customers
FOR DELETE
AS 
    BEGIN 
	 UPDATE Customers Set Active = 0 WHERE CustomerID IN(SELECT CustomerID FROM deleted)
	 ROLLBACK TRANSACTION;
	END
GO

SELECT MAX(checkCustomerContryOnUpdate)
    FROM Customers