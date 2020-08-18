CREATE DATABASE Assignment_02
GO
USE Assignment_02
GO

CREATE TABLE Company(
  CompanyCode int PRIMARY KEY,
  CompanyName varchar(10),
  Address varchar(10),
  Phone CHAR(6),
  CONSTRAINT chk_dt CHECK (Phone not like '%[^0-9]%'),
)
GO
CREATE TABLE Product (
  ProductCode int PRIMARY KEY,
  ProductName varchar(50),
  CompanyCode int,
  Descriptions nvarchar(60),
  Unti nvarchar(10),
  Price money,
  Amount int,
  CONSTRAINT fk_sp
  FOREIGN KEY (CompanyCode) 
  REFERENCES Company(CompanyCode)
)
GO

--3. Viết các câu lệnh để thêm dữ liệu vào các bảngINSERT INTO Company values (123, 'Asus', 'USA' ,'098323'),             (124, 'Nokia', 'Finland', '054345'),			 (125, 'Samsung','Korea','010312')INSERT INTO Product values (1, 'Laptop T450',123,'Old import machine','Piece', 1000, 10),                           (2, 'TelePhone Nokia 5670',124,'The Phone is hot','Piece', 200,200),						   (3, 'Printer Samsung 450', 125,'The priter is normal','Piece', 100, 10)INSERT INTO Product values(4, 'Computer GT', 126, 'The Computer is Expense', 'Price', 10000, 0)UPDATE Product SET AMOUNT = 0 WHERE ProductCode = 4--4. Viết các câu lênh truy vấn để--a) Hiển thị tất cả các hãng sản xuất.
SELECT CompanyCode, CompanyName,  Address varchar, Phone
 FROM Company 
--b) Hiển thị tất cả các sản phẩm.

SELECT ProductCode, ProductName, Descriptions, Unti, Price
FROM Product

--5.Viết các câu lệnh truy vấn để 
--a) Liệt kê danh sách hãng theo thứ thự ngược với alphabet của tên
SELECT * FROM Company
ORDER BY CompanyName DESC
--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT * FROM Product
ORDER BY Price DESC
--c) Hiển thị thông tin của hãng Asus
SELECT * FROM Company 
WHERE CompanyName = 'Asus'
--d) Liệt kê danh sách sản phẩm còn ít hơn 11 chiếc trong kho
SELECT * FROM Product 
WHERE Amount < 11
--e) Liệt kê danh sách sản phẩm của hãng AsusSELECT ProductCode, ProductName, Descriptions, Unti, Price, AmountFROM Product where Companycode IN (SELECT CompanyCode FROM Company WHERE CompanyName = 'Asus')--6. Viết các câu lệnh truy vấn để lấ--a) Số hãng sản phẩm mà cửa hàng cóSELECT CompanyName, Count(*) as SoHang_SanPhamFROM Company GROUP BY CompanyName--b) Số mặt hàng mà cửa hàng bánSELECT ProductName, Count(*) as Mathang_CuaHangbanFROM ProductGROUP BY ProductName--c) Tổng số loại sản phẩm của mỗi hãng có trong cửa hàng.SELECT CompanyName, Count(*) as Tong_SoLoai_Mahang_MoiHangFROM ProductJOIN CompanyON Company.CompanyCode = Product.CompanyCodeGROUP BY CompanyName  --d) Tổng số đầu sản phẩm của toàn cửa hàngSELECT Count(*) as Mathang_CuaHangbanFROM Product--7. Thay đổi những thay đổi sau trên cơ sở dữ liệu--a) Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0)ALTER TABLE Product  ADD CHECK (Price >0)--b) Viết câu lệnh để thay đổi số điện thoại phải bắt đầu bằng 0.ALTER TABLE CompanyADD CHECK (Phone LIKE '0%')--c) Viết các câu lệnh để xác định các khóa ngoại và khóa chính của các bảngSELECT fk_spFROM Company--8. Thực hiện các yêu cầu sau
--a) Thiết lập chỉ mục (Index) cho các cột sau: Tên hàng và Mô tả hàng để tăng hiệu suất truy vấn
--dữ liệu từ 2 cột này

CREATE INDEX IX_Product
ON Product(ProductName, Descriptions)
EXEC sp_helpindex 'Product'

--b) Viết các View sau:
--◦ View_SanPham: với các cột Mã sản phẩm, Tên sản phẩm, Giá bán
CREATE VIEW View_SanPham as
SELECT ProductCode, ProductName, Price
FROM Product
--View_SanPham_Hang: với các cột Mã SP, Tên sản phẩm, Hãng sản xuấ
CREATE VIEW View_SanPham_Hang AS
SELECT ProductCode, ProductName, CompanyName
FROM Product 
JOIN Company
ON Product.CompanyCode = Company.CompanyCode
--c) Viết các Store Procedure sau:
--◦ SP_SanPham_TenHang: Liệt kê các sản phẩm với tên hãng truyền vào store
 CREATE PROCEDURE SP_SanPham_TenHang
AS 
SELECT * FROM View_SanPham_Hang


EXEC SP_SanPham_TenHang
--SP_SanPham_Gia: Liệt kê các sản phẩm có giá bán lớn hơn hoặc bằng giá bán truyền vàoCREATE PROCEDURE Sp_SanPham_GiaAS SELECT * FROM ProductWHERE Price > 1000-- SP_SanPham_HetHang: Liệt kê các sản phẩm đã hết hàng (số lượng = 0)CREATE PROCEDURE Sp_SanPham_HetHangAS SELECT * FROM ProductWHERE Amount = 0EXEC Sp_SanPham_HetHang--d) Viết Trigger sau:--TG_Xoa_Hang: Ngăn không cho xóa hãngCREATE TRIGGER TG_Xoa_HangON CompanyFOR DELETE AS   BEGIN     declare @CompanyName varchar(10);	SELECT @CompanyName = CompanyName FROM deleted;	ROLLBACK TRANSACTION;	ENDDELETE FROM CompanyWHERE CompanyCode = 123--TG_Xoa_SanPham: Chỉ cho phép xóa các sản phẩm đã hết hàng (số lượng = 0)CREATE TRIGGER TG_Xoa_SanPhamON Product