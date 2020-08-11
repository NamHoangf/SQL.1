CREATE DATABASE QuanLyNhanSu
GO
--
CREATE TABLE PhongBan (
 MaPB varchar(7) PRIMARY KEY,
 TenPB nvarchar(50)
)
GO

--
 CREATE TABLE NhanVien (
 MaNV varchar(7) PRIMARY KEY,
 TenNV nvarchar(50),
 NgaySinh Datetime CHECK(NgaySinh < GetDate()),
 SoCMND char(9) CHECK(SoCMND not like '%[^0-9]%'),
 GioiTinh Char(1) CHECK (GioiTinh = 'M' or GioiTinh = 'F') DEFAULT('M'),
 DiaChi nvarchar(100),
 NgayVaoLam Datetime,
 MaPB varchar(7),
 CONSTRAINT year20 CHECK(DATEDIFF(year, NgaySinh, NgayVaoLam) >20),
 CONSTRAINT FK_PhongBan FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB)
 );
 
 --
CREATE TABLE LuongDA (
   MaDA varchar(8), 
   MaNV varchar(7), 
   NgayNhan Datetime NOT NULL DEFAULT(GETDATE()),
   SoTien Money CHECK (SoTien>0),
   CONSTRAINT PK_LuongDA PRIMARY KEY (MaDA, MaNV),
   CONSTRAINT FK_NhanVien FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV)
)
--1 Thực hiện chèn dữ liệu vào các bảng vừa tạo (ít nhất 5 bản ghi cho mỗi bảng).
INSERT INTO PhongBan values('T101', N'Hành Chính')
INSERT INTO PhongBan values('T102', N'Nhân Sự')
INSERT INTO PhongBan values('T103', N'Kế Toán')
INSERT INTO PhongBan values('T104', N'Kinh Doanh')
INSERT INTO PhongBan values('T105', N'Đầu Tư')
INSERT INTO PhongBan values('T106', N'Dự Án')

INSERT INTO NhanVien VALUES('K1',N'Nguyễn Văn A','1951-7-04', '015235326', 'M', N'Ha Noi', '1990-05-27','T101')
INSERT INTO NhanVien VALUES('K2',N'Nguyễn Văn B','1941-9-04', '012355328', 'F', N'Ha Noi', '1999-05-27','T102')
INSERT INTO NhanVien VALUES('K3',N'Nguyễn Văn C','1951-9-04', '560152532', 'M', N'Ha Noi', '1991-05-27','T103')
INSERT INTO NhanVien VALUES('K4',N'Nguyễn Văn D','1961-9-04', '784523532', 'F', N'Ha Noi', '2005-05-27','T104')
INSERT INTO NhanVien VALUES('K5',N'Nguyễn Văn E','1971-9-04', '345234525', 'M', N'Ha Noi', '2010-05-27','T105')
INSERT INTO NhanVien VALUES('K6',N'Nguyễn Văn F','1951-5-04', '345234529', 'M', N'Ha Noi', '2012-05-27','T106')

INSERT INTO LuongDA VALUES('M23','K1','1985-04-25',2500)
INSERT INTO LuongDA VALUES('M24','K2','1975-04-25',2545)
INSERT INTO LuongDA VALUES('M25','K3','1989-04-25',2590)
INSERT INTO LuongDA VALUES('M26','K4','1976-04-25',2547)
INSERT INTO LuongDA VALUES('M27','K5','1965-04-25',2545)

--2Viết một query để hiển thị thông tin về các bảng LUONGDA, NHANVIEN, PHONGBAN.
SELECT * FROM PhongBan
SELECT * FROM NhanVien
SELECT * FROM LuongDA

--3 Viết một query để hiển thị những nhân viên có giới tính là ‘F’.
SELECT MaNV, TenNV, GioiTinh, NgaySinh, SoCMND, DiaChi, NgayVaoLam, MaPB
FROM NhanVien
WHERE GioiTinh = 'F'

--4.Hiển thị tất cả các dự án, mỗi dự án trên 1 dòng.
 SELECT MaDA AS'All DA'
FROM LuongDa

--5.Hiển thị tổng lương của từng nhân viên (dùng mệnh đề GROUP BY).
SELECT MaDA, MaNV,NgayNhan, SUM(SoTien)
FROM LuongDA
GROUP BY  MaDA, MaNV,NgayNhan;

--6.Hiển thị tất cả các nhân viên trên một phòng ban cho trước (VD: ‘Hành chính’).

SELECT MaNV, TenNV, NgaySinh, SoCMND, GioiTinh, DiaChi, NgayVaoLam, MaPB 
FROM  NhanVien 
WHERE MaPB='T101'

--SELECT TenNV
--FROM NhanVien
--WHERE MaPB LIKE 'T101'
--GROUP BY TenNV

--SELECT TenNV
--FROM NhanVien
--     JOIN PhongBan
--	    ON PhongBan.MaPB= NhanVien.MaPB
--WHERE TenPB = N'Phòng Bạn'

--7.Hiển thị mức lương của những nhân viên phòng hành chính.
SELECT TenNV, SoTien, GioiTinh
FROM NhanVien
     JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB = N'Hành Chính'

--SELECT  TenNV, SoTien, GioiTinh
--     FROM nhanvienhanhchinh
--     INNER JOIN luongDA
--     ON nhanvienhanhchinh.MaNV = luongDA.MaNV;

--8. Hiển thị số lượng nhân viên của từng phòng.
--Hành Chính
SELECT  COUNT(*) SoLuong
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Hành Chính'
--Nhân Sự
SELECT  COUNT(*) SoLuongNhanVienNhanSu
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Nhân Sự'
--Kết toán
SELECT  COUNT(*) SoLuongNhanVienKeToan
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'kế Toán'
--Kinh Doanh
SELECT  COUNT(*) SoLuongNhanVienKinhDoanh
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Kinh Doanh'
--Đầu tư
SELECT  COUNT(*) SoLuongNhanVienDauTu
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Đầu Tư'

--9. Viết một query để hiển thị những nhân viên mà tham gia ít nhất vào một dự án.
SELECT * FROM LuongDA WHERE MaDA!='';

--10.Viết một query hiển thị phòng ban có số lượng nhân viên nhiều nhất.
SELECT MAX(MaPB) as NVMAX FROM phongban;
--SELECT * FROM PhongBan WHERE MaPB!='';

--11.Tính tổng số lượng của các nhân viên trong phòng Hành chính.
SELECT COUNT(*) AS N'Tổng Số Lượng Nhân Viên' 
FROM NhanVien
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB = N'Hành Chính'

--12. Hiển thị tống lương của các nhân viên có số CMND tận cùng bằng 9.
SELECT right(SoCMND, 1), SoCMND
FROM nhanvien
WHERE right(SoCMND, 1) = '9'

--SELECT right(SoCMND, 1), SoCMND
--FROM nhanvien
--WHERE right(SoCMND, 1) = '9'

--SELECT * FROM NhanVien , luongDA 
--WHERE RIGHT(NhanVien.SoCMND, 1) = '9'  and NhanVien.MaNV = LuongDA.MaNV

--13.Tìm nhân viên có số lương cao nhất.
SELECT MAX(SoTien) as N'Lương Cao Nhất' 
FROM LuongDA
JOIN NhanVien
          ON NhanVien.MaNV = LuongDA.MaNV

--14.Tìm nhân viên ở phòng Hành chính có giới tính bằng ‘F’ và có mức lương > 1200000.
SELECT TenNV 
FROM NhanVien
    JOIN PhongBan 
	   ON PhongBan.MaPB = NhanVien.MaPB
	JOIN LuongDA
	    On LuongDA.MaNV= NhanVien.MaNV
WHERE TenPB = N'Hành Chính' AND  GioiTinh = 'F' AND SoTien > 2000 

--15. Tìm tổng lương trên từng phòng.
SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Nhân Sự'

 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Kế Toán'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Kinh Doanh'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Hành Chính'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Đầu Tư'
-- SELECT pb.MaPB, pb.TenPB, summoney FROM phongban pb,(
--SELECT MaPB, SUM(SoTien) AS summoney FROM nhanvien AS nv, luongDA AS luong WHERE nv.MaNV = luong.MaNV 
--GROUP BY MaPB ) result WHERE pb.MaPB = result.MaPB;
 --16. Liệt kê các dự án có ít nhất 2 người tham gia.
 SELECT MaDA FROM luongDA
 GROUP By MaDA
 Having COUNT(MaNV) >= 2;
 --17.
SELECT * FROM NhanVien
WHERE TenNV LIKE '[N]%'

--18. Hiển thị thông tin chi tiết của nhân viên được nhận tiền dự án trong năm 1989
SELECT * FROM luongDA 
WHERE NgayNhan= '1989-04-25';
--19. Hiển thị thông tin chi tiết của nhân viên không tham gia bất cứ dự án nào.
SELECT * FROM luongDA WHERE MaDA='';
--20. Xoá dự án có mã dự án là DXD02.
DELETE FROM luongDA WHERE MaDA='DXD02';
--21. Xoá đi từ bảng LuongDA những nhân viên có mức lương 2000000.
DELETE FROM luongDA WHERE SoTien='2000000';
--22. Cập nhật lại lương cho những người tham gia dự án XDX01 thêm 10% lương cũ.
UPDATE luongDA
SET SoTien = '900000000'
WHERE MaDA = 'XDX101';
SELECT * FROM luongDA;
--23.Xoá các bản ghi tương ứng từ bảng NhanVien đối với những nhân viên không có mã nhân viên  tồn tại trong bảng LuongDA.
DELETE FROM NhanVien WHERE MaNV not in (SELECT MaNV FROM LuongDA );
--24.Viết một truy vấn đặt lại ngày vào làm của tất cả các nhân viên thuộc phòng hành chính là ngày 12/02/1999
UPDATE nhanvienhanhchinh
SET NgayVaoLam = 2019-04-29;
select * from nhanvienhanhchinh;