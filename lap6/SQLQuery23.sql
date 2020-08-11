CREATE DATABASE Asignment01
GO
USE Asignment01
GO

CREATE TABLE NguoiMua (
  Makh varchar(10) PRIMARY KEY,
  Nguoidathang nvarchar(50),
  diachi nvarchar (50),
  dienthoai CHAR(9),
  CONSTRAINT chk_dt CHECK (dienthoai not like '%[^0-9]%') 
)
INSERT INTO NguoiMua VALUES (123, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321'),
                            (124, N'Nguyễn Văn Anh', N'123 Nguyễn Trãi, Thanh Xuân, Hà Nội', '123456789')
GO
CREATE TABLE SanPham (
Masp varchar(10) PRIMARY KEY,
Tensp nvarchar (30),
Mota nvarchar (50),
Giaban Money CHECK (Giaban>0)
)
INSERT INTO SanPham VALUES ('T1', N'Máy Tính T450',N'Máy Mới Nhập', 1000),
                           ('T2', N'Điện Thoại Nokia5670', N'Điện Thoại đang hot', 200),
						   ('T3', N'Máy In Samsung450',N'Máy in đang ế', 100)
GO
CREATE TABLE DonDatHang (
 Madathang int PRIMARY KEY,
 Makh varchar(10),
 Ngaydathang DATETIME,
 Soluong int CHECK (Soluong >0),
 Tongtien money
 CONSTRAINT fk_NguoiMua FOREIGN KEY (Makh) REFERENCES NguoiMua(Makh)
 )
 INSERT INTO DonDatHang VALUES (111, 123, '2011-11-11', 2, 1500)
 INSERT INTO DonDatHang VALUES (222, 124, '2011-11-11', 1, 1300)

GO
CREATE TABLE Donhangchitiet (
 Makh varchar(10),
 Madonhang int PRIMARY KEY,
 Masp varchar(10),
 Giaban Money CHECK (Giaban >0),
 Soluongmua int
 CONSTRAINT fk_SanPham FOREIGN KEY (Masp) REFERENCES SanPham(Masp),
 CONSTRAINT fk_Khanhhang FOREIGN KEY (Makh) REFERENCES NguoiMua(Makh)
 )
GO
INSERT INTO Donhangchitiet VALUES (123,11,'T1', 1000, 1)
INSERT INTO Donhangchitiet VALUES (123,12,'T2', 200, 2)
INSERT INTO Donhangchitiet VALUES (123,13,'T3', 100, 1)

SELECT * FROM NguoiMua
SELECT * FROM SanPham
SELECT * FROM DonDatHang
SELECT * FROM Donhangchitiet

--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách khách hàng đã mua hàng ở cửa hàng
SELECT Makh, Nguoidathang
FROM NguoiMua
--b) Liệt kê danh sách sản phẩm của của hàng 
SELECT Masp, Tensp, Mota, Giaban
FROM SanPham
--c) Liệt kê danh sách các đơn đặt hàng của cửa hàng.
SELECT Madonhang,Masp, Giaban, Soluongmua
FROM Donhangchitiet

--5. Viết các câu lệnh truy vấn để
--a) Liệt kê danh sách khách hàng theo thứ thự alphabet
SELECT Makh, Nguoidathang 
FROM NguoiMua
ORDER BY Nguoidathang

--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần
SELECT Masp, Tensp, Mota, Giaban
FROM SanPham
ORDER BY Giaban DESC
--c) Liệt kê các sản phẩm mà khách hàng Nguyễn Văn An đã mua
SELECT Nguoidathang,Tensp, Mota, Mota, Soluongmua, Donhangchitiet.Giaban
FROM Donhangchitiet 
   JOIN NguoiMua
          ON NguoiMua.Makh = Donhangchitiet.Makh
   JOIN SanPham 
          ON SanPham.Masp = Donhangchitiet.Masp
WHERE Nguoidathang = N'Nguyễn Văn An'
--6. Viết các câu lệnh truy vấn để
--a) Số khách hàng đã mua ở cửa hàng.
SELECT Nguoidathang, COUNT(*) AS Sokhanhang
FROM NguoiMua
Group by Nguoidathang

--b) Số mặt hàng mà cửa hàng bán
SELECT Tensp, Madonhang, Soluongmua AS N'Số Lượng đã bán'
FROM SanPham
     JOIN Donhangchitiet
	    ON Donhangchitiet.Masp = SanPham.Masp
--c) Tổng tiền của từng đơn hàng.
SELECT Nguoidathang, SUM(Giaban) as N'Tổng tiền'
FROM Donhangchitiet, NguoiMua
Group by Nguoidathang

--7. Thay đổi những thông tin sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).ALTER TABLE SanPhamADD CONSTRAINT SP CHECK ( Giaban >0)
--b) Viết câu lệnh để thay đổi ngày đặt hàng của khách hàng phải nhỏ hơn ngày hiện tại.  
ALTER TABLE DonDatHang
ADD CONSTRAINT Thaydoi CHECK (Ngaydathang < GETDATE())
--c) Viết câu lệnh để thêm trường ngày xuất hiện trên thị trường của sản phẩm.ALTER TABLE SanPham
ADD Ngayxuathien DATETIME CHECK (Ngayxuathien < GETDATE())
--8. Thực hiện các yêu cầu sau
--a) Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên các cột này
CREATE INDEX SanPham_Nguoidathang
on SanPham(Tensp, Giaban, Mota)

CREATE INDEX Nguoi_dat_hang
ON NguoiMua(Makh, Nguoidathang, diachi, dienthoai)

--b) Xây dựng các view sau đây:
--◦ View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại
--◦ View_SanPham với các cột: Tên sản phẩm, Giá bán
--◦ View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản
--phẩm, Số lượng, Ngày muaCREATE VIEW KhachHang asSELECT Nguoidathang, diachi, dienthoaiFROM NguoiMuaCREATE VIEW View_SanPham asSELECT Tensp, GiabanFROM SanPham
CREATE VIEW KhachHang_SanPham AS
SELECT Makh, Ngaydathang
FROM DonDatHang(SELECT Nguoidathang, dienthoai, tensp, SoluongmuaFROM Donhangchitiet 
   JOIN NguoiMua
          ON NguoiMua.Makh = Donhangchitiet.Makh
   JOIN SanPham 
          ON SanPham.Masp = Donhangchitiet.Masp
)
--c) Viết các Store Procedure (Thủ tục lưu trữ) sau:
--◦ SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng

CREATE PROCEDURE TimKH_MaKH AS
BEGIN 
  SELECT Nguoidathang 
  FROM NguoiMua
  ORDER BY Makh;
END;
      exec TimKH_MaKH
--◦ SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn
CREATE PROCEDURE TimKH_MaHD AS
BEGIN
  SELECT Nguoidathang, diachi, dienthoai
  FROM DonDatHang as ddt
  JOIN NguoiMua as nm
     ON ddt.Makh = nm.Makh
	 ORDER BY Madathang
END;
EXEC TimKH_MaHD
--◦ SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được
--truyền vào Store.
CREATE PROCEDURE SanPham_MakH AS
BEGIN 
  SELECT Tensp, Mota, Giaban
  FROM SanPham as sp
  JOIN Donhangchitiet as dhct
     ON dhct.Masp = sp.Masp
   ORDER BY Madathang