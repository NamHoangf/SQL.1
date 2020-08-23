CREATE DATABASE Assignment_03
GO

USE Assignment_03
GO

CREATE TABLE Customer (
  CustomerID int primary key identity,
  CustomerName nvarchar(40),
  Address nvarchar(40),
  Birthdat datetime,
  Sex bit,
  IdentityCard char(9)
)
GO

INSERT INTO Customer VALUES ( N'Nguyễn Nguyệt Nga', N'Hà Nội', '1991-2-4', 0,'123456789'),
                             (N'Nguyễn Văn Tuấn', N'Tây Thành', '1995-2-4', 1, '987654321'),
							 (N'Nguyễn Văn Trỗi', N'Hoàng Trung', '1994-2-9', 1,'123456542'),
							 (N'Trịnh Thùy Dung', N'Tây Mồ', '1996-4-24', 0, '987654678'),
							 (N'Hoàng Thúc Dục', N'Phan Thiết', '1995-2-4', 1,'567325523')

CREATE TABLE Subscription (
  SubID int primary key,
  CustomerID int,
  SubTypeID int,
  SubDate datetime,
  CONSTRAINT fk_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  CONSTRAINT fk_SubType FOREIGN KEY (SubTypeID) REFERENCES  SubscriptionType(SubTypeID)
)
GO


INSERT INTO Subscription VALUES (093323234, 1,1, '2012-12-02')
INSERT INTO Subscription VALUES (093456788,2,2, '2015-6-5'),
								 (093456777,3,1,'2013-9-12'),
								 (093456666,4,2,'2011-12-2'),
								 (093455555,5,1,'2017-11-29')
 CREATE TABLE SubscriptionType (
  SubTypeID int PRIMARY KEY ,
  SubTypeName nvarchar(30), 
)
GO

INSERT INTO SubscriptionType  VALUES (1,N'Trả Trước'),
                                (2,N'Trả Sau')
								
--4. Viết các câu lênh truy vấn để
--a) Hiển thị toàn bộ thông tin của các khách hàng của công ty.
SELECT CustomerID, CustomerName, Address, Birthdat, sex
FROM Customer

--b) Hiển thị toàn bộ thông tin của các số thuê bao của công ty
SELECT SubID, CustomerID, SubTypeID, SubDate
FROM Subscription

--5. Viết các câu lệnh truy vấn để lấy
--a) Hiển thị toàn bộ thông tin của thuê bao có số: 0123456789
SELECT CustomerName, Address, Birthdat, Sex,SubTypeName, SubDate
FROM customer as C
JOIN Subscription as S
ON C.CustomerID=S.CustomerID
JOIn SubscriptionType as St
ON St.SubTypeID= S.CustomerID
WHERE SubID = 123456789

--b) Hiển thị thông tin về khách hàng có số CMTND: 123456789
SELECT CustomerName, Address, Birthdat, Sex,SubTypeName, SubDate
FROM customer as C
JOIN Subscription as S
ON C.CustomerID=S.CustomerID
JOIn SubscriptionType as St
ON St.SubTypeID= S.CustomerID
WHERE IdentityCard = '123456789'

--c) Hiển thị các số thuê bao của khách hàng có số CMTND:123456789
SELECT SubID 
FROM Subscription
WHERE CustomerID IN (SELECT CustomerID FROM Customer
WHERE IdentityCard = '123456789')

--d) Liệt kê các thuê bao đăng ký vào ngày 12/12/09
SELECT SubID, SubDate
FROM Subscription
WHERE SubDate= 2012-12-02

--e) Liệt kê các thuê bao có địa chỉ tại Hà Nội
SELECT SubID , CustomerName, IdentityCard, Birthdat
FROM Customer
JOIN Subscription as S
On S.CustomerID = Customer.CustomerID
WHERE Address = N'Hà Nội'

--6. Viết các câu lệnh truy vấn để lấy
--a) Tổng số khách hàng của công ty
SELECT Count(CustomerID) as Sum_Customer
FROM Customer
--b) Tổng số thuê bao của công ty.
SELECT Count(SubID) as Sum_Sub
FROM Subscription
--c) Tổng số thuê bào đăng ký ngày 12/12/09
SELECT COUNT(SubID) as Sum_Sub12_2
FROM Subscription
WHERE SubDate = '2012-12-02'
--d) Hiển thị toàn bộ thông tin về khách hàng và thuê bao của tất cả các số thuê bao.SELECT CustomerName, Address, Birthdat, Sex,IdentityCard, SubDate, SubTypeName
FROM Customer  as C
JOIN Subscription as S
ON S.CustomerID = C.CustomerID
JOIN SubscriptionType as ST
ON ST.SubTypeID = S.SubTypeID
--7. Thay đổi những thay đổi sau trên cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày đăng ký là not null.ALTER TABLE SubscriptionALTER COLUMN SubDate datetime Not NULl--b) Viết câu lệnh để thay đổi trường ngày đăng ký là trước hoặc bằng ngày hiện tại.ALTER TABLE SubscriptionADD CONSTRAINT Sub_Date CHECK (SubDate  <= GETDATE())--c) Viết câu lệnh để thay đổi số điện thoại phải bắt đầu 09ALTER TABLE SubscriptionADD CONSTRAINT sub_ID CHECK (SubID LIKE '9__%')--d) Viết câu lệnh để thêm trường số điểm thưởng cho mỗi số thuê bao.ALTER TABLE SubscriptionADD BonusPoints int --8. Thực hiện các yêu cầu sau--a) Đặt chỉ mục (Index) cho cột Tên khách hàng của bảng chứa thông tin khách hàngCREATE INDEX CustomerNameON Customer(CustomerName)--b) Viết các View sau:--View_KhachHang: Hiển thị các thông tin Mã khách hàng, Tên khách hàng, địa chỉCREATE VIEW VIEW_KHACHHANG AS SELECT CustomerID, CustomerName, AddressFROM Customer--View_KhachHang_ThueBao: Hiển thị thông tin Mã khách hàng, Tên khách hàng, Số thuê baoCREATE VIEW VIEW_KHACHHANG_THUEBAO asSELECT  CustomerName, SubIDFROM Customer as CJOIN Subscription as SON C.CustomerID =S.CustomerID--c) Viết các Store Procedure sau:
-- SP_TimKH_ThueBao: Hiển thị thông tin của khách hàng với số thuê bao nhập vào
CREATE PROCEDURE SP_TimKH_ThueBao AS
SELECT  CustomerName, address, Birthdat, Sex, IdentityCard
FROM Customer AS C
JOIN Subscription as SON C.CustomerID =S.CustomerIDWHERE SubID = 123456789--SP_TimTB_KhachHang: Liệt kê các số điện thoại của khách hàng theo tên truyền vàoCREATE PROCEDURE SP_TimTB_KhachHang asSELECT SubID FROM SubscriptionWHERE CustomerID IN (SELECT CustomerID FROM Customer where CustomerName = N'Nguyễn Nguyệt Nga')--SP_ThemTB: Thêm mới một thuê bao cho khách hàngCREATE PROCEDURE SP_ThemTB asINSERT INTO Subscription VALUES (094234324, 6, 1, '2019-2-25')--SP_HuyTB_MaKH: Xóa bỏ thuê bao của khách hàng theo Mã khách hàngCREATE PROCEDURE SP_HuyTB_MaKH asDELETE FROM Subscription WHERE CustomerID = 6