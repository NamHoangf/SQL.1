-- CREATE DATABASE Assignment_04
GO

USE Assignment_04
GO

CREATE TABLE Product (
 ProductID varchar(20) PRIMARY KEY,
 ProductName varchar(50),
 CategoryID varchar(10),
 ProduceDate Datetime,
 StaffID int, 
 CONSTRAINT fk_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
 CONSTRAINT fk_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
)
GO
CREATE TABLE Category (
  CategoryID varchar(10) PRIMARY KEY,
  CategoryName nvarchar(40),
)
GO
CREATE TABLE Staff (
 StaffID int PRIMARY KEY,
 StaffName nvarchar(40)
)
GO

--Viết các câu lệnh để thêm dữ liệu vào các bảng
INSERT INTO Product VALUES ('Z37 111111', N'Máy tính sách tay Z37', 'Z37E', '2012-12-09',987688),
                           ('K25 123123', N'Điện Thoại Nokia 3700', 'K37A', '2011-2-19', 123123),
						   ('H55 214241', N'Máy In Sam Sung k234', 'K32A', '2015-2-9', 423432),
						   ('T23 234322', N'Máy Giăt LG 23', 'L23G', '2016-6-5', 442345),
						   ('P42 212133', N'TiVi Panasonic 55', 'TV55', '2019-4-5', 234234)

INSERT INTO Category VALUES ('Z37E', N'Máy tính sách tay'),
                            ('K37A',  N'Điện Thoại Nokia'),
							('K32A', N'Máy In Sam Sung'),
							('L23G', N'Máy Giăt'),
							('TV55',  N'TiVi Panasonic')
INSERT INTO Category VALUES ('VB34', N'Quạt Trần VIBa')
INSERT INTO Staff VALUES (987688, N'Nguyễn Văn An'),
                         (123123, N'Lê Thị Bưởi'),
						 (423432, N'Mai Thị Trúc'),
						 (442345, N'Hồ Thị Đào'),
						 (234234, N'Cao Minh Bạch')

--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách loại sản phẩm của công ty
SELECT CategoryID, CategoryName
FROM Category

--b) Liệt kê danh sách sản phẩm của công ty. 
SELECT ProductID, ProductName, ProduceDate
FROM Product

--c) Liệt kê danh sách người chịu trách nhiệm của công ty.
SELECT StaffID, StaffName
FROM Staff

--5. Viết các câu lệnh truy vấn để lấy
--a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
SELECT CategoryID, CategoryName
FROM category 
ORDER BY CategoryName ASC

--b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên
SELECT StaffID, StaffName
FROM Staff
ORDER BY StaffName ASC

--c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.
SELECT ProductID, ProductName, ProduceDate
FROM Product 
WHERE CategoryID IN (SELECT CategoryID FROM Category  
WHERE CategoryID = 'Z37E')

--d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã
SELECT ProductID, ProductName
FROM Product as P
JOIN Staff as S
ON S.StaffID = P.StaffID
WHERE StaffName = N'Nguyễn Văn An'
ORDER BY ProductID DESC

--7. Thay đổi những thư sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại
ALTER TABLE Product
ADD CONSTRAINT Produce_date CHECK(ProduceDate <= GetDate())

--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
--c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.ALTER TABLE ProductADD Version int --8. Thực hiện các yêu cầu sau--a) Đặt chỉ mục (index) cho cột tên người chịu trách nhiệmCREATE INDEX StaffName_index ON Staff(StaffName)--b) Viết các View sau:
--View_SanPham: Hiển thị các thông tin Mã sản phẩm, Ngày sản xuất, Loại sản phẩm
CREATE VIEW View_SanPham AS 
SELECT ProductID, ProduceDate, CategoryName
FROM Product as P
JOIN Category as C
ON C.CategoryID= P.CategoryID

--View_SanPham_NCTN: Hiển thị Mã sản phẩm, Ngày sản xuất, Người chịu trách nhiệm
CREATE VIEW View_SanPham_NCTN AS
SELECT ProductID, ProduceDate, StaffName
FROM Product as P
JOIN Staff as S
ON S.StaffID = P.StaffID

--View_Top_SanPham: Hiển thị 5 sản phẩm mới nhất (mã sản phẩm, loại sản phẩm, ngày sản xuất)CREATE VIEW View_Top_SanPham ASSELECT TOP (5)ProductID, CategoryName, ProduceDateFROM Product as P
JOIN Category as C
ON C.CategoryID= P.CategoryID
ORDER BY ProduceDate DESC
--c) Viết các Store Procedure sau:
--SP_Them_LoaiSP: Thêm mới một loại sản phẩmCREATE PROCEDURE SP_Them_LoaiSP AS   INSERT INTO Category VALUES ('HN12', N'Tủ Lạnh LG ')--SP_Them_NCTN: Thêm mới người chịu trách nhiệmCREATE PROCEDURE SP_Them_NCTNAS  INSERT INTO Staff VALUES (223424, N'Nguyên Văn Bình') --SP_Them_SanPham: Thêm mới một sản phẩmCREATE PROCEDURE SP_Them_SanPhamAS   INSERT INTO Product VALUES ('B23 123123', N'Quạt Trần ViBa 34', 'HN12', '2016-4-09',223424)  --SP_Xoa_SanPham: Xóa một sản phẩm theo mã sản phẩm  CREATE PROCEDURE SP_Xoa_SanPham  AS     DELETE FROM Product 	WHERE ProductID = 'B23 123123'--SP_Xoa_SanPham_TheoLoai: Xóa các sản phẩm của một loại nào đóCREATE PROCEDURE SP_Xoa_SanPham_TheoLoaiAS  DELETE FROM Product WHERE CategoryID = 'HN12'
