IF EXISTS (SELECT * FROM sys.databases WHERE Name LIKE 'QuanLySinhVien')
  DROP DATABASE QuanLySinhVien
GO
CREATE DATABASE QuanLySinhVien

GO
USE QuanLySinhVien
GO

CREATE TABLE SinhVien(
  MaSv int PRIMARY KEY,
  TenSv nvarchar(50),
  SinhNgay datetime,
  Email varchar(50),
  LienHe  int,
  GioiTinh nvarchar (10),
  MalopHoc varchar(10)
)
INSERT INTO SinhVien VALUES (1231411, N'Nguyễn Văn Chí', 1911-2-4,'chivannguyen@gamil.com', 092134134, 'Nam', 'T101202')
INSERT INTO SinhVien VALUES (1231412, N'Phèo Thị Nở', 1913-5-5,'nothipheo@gamil.com', 092342334, 'Nữ', 'T101202')
INSERT INTO SinhVien VALUES (1231413, N'Bá Văn Kiến', 1911-2-4,'bakienvan@gamil.com', 023423413, 'Nam', 'T101202')
INSERT INTO SinhVien VALUES (1231414, N'lão Hạc Hạc', 1941-7-4,'laovanhac@gamil.com', 093432134, 'Nam', 'T101203')
INSERT INTO SinhVien VALUES (1231415, N' Cẩu Vàng', 1949-3-4,'cauvang@gamil.com', 092324134, 'Nam', 'T101203')
INSERT INTO SinhVien VALUES (1231416, N'Ông Ông Giáo', 1946-2-6,'ongonggiao@gamil.com', 09234134, 'Nam', 'T101203')

CREATE TABLE LopHoc(
  MaLopHoc varchar(10) PRIMARY KEY,
  TenLopHoc nvarchar(50),
  NgayBatDau datetime,
  NgayKetThuc datetime,
  TrangThaiLop nvarchar(10)
)

INSERT INTO LopHoc VALUES ('T101202' , N'Nam Cao', 1941-12-2, 1991-2-12, N' Đang Học')
INSERT INTO LopHoc VALUES ('T101203' , N'Nam Cao1', 1941-12-3, 1991-2-13, N' Đang Học')
INSERT INTO LopHoc VALUES ('T101204' , N'Nam Cao2', 1941-12-4, 1991-2-14, N' Đang Học')
INSERT INTO LopHoc VALUES ('T101205' , N'Nam Cao3', 1950-4-4, 1980-2-2, N' Kết Thúc')
INSERT INTO LopHoc VALUES ('T101206' , N'Nam Cao4', 1950-5-4, 1981-9-4, N' Kết Thúc')
INSERT INTO LopHoc VALUES ('T101207' , N'Nam Cao5', 1950-6-2, 1921-7-2, N' Kết Thúc')


CREATE TABLE ChiTietLopHoc (
  MaSv int,
  MaLopHoc varchar(10),
  TenSv nvarchar(50),
  MonHoc nvarchar(20),
  NgayBatDau datetime,
  NgayKetThuc datetime,
  TrangThai nvarchar(20),
  CONSTRAINT FK_SinhVien FOREIGN KEY(MaSv) REFERENCES SinhVien,
  CONSTRAINT FK_LopHoc FOREIGN KEY(MaLopHoc) REFERENCES LopHoc
 )
 GO

INSERT INTO ChiTietLopHoc VALUES (1231411,'T101202', N'Nguyễn Văn Chí', N'Môn Văn Học',1941-12-9, 1991-2-9, N'Vắng 80%')
INSERT INTO ChiTietLopHoc VALUES (1231412,'T101202', N'Phèo Thị Nở', N'Môn Văn Học',1941-5-6,1991-12-9, N'Vắng 1% ')
INSERT INTO ChiTietLopHoc VALUES (1231413,'T101202', N'Bá Văn Kiến', N'Môn Văn Học', 1941-5-6, 1991-12-12,N'Không Vắng')
INSERT INTO ChiTietLopHoc VALUES (1231414,'T101203', N'lão Hạc Hạc', N'Môn Văn Học', 1950-5-8, 1999-12-7, N'Vắng 30%')
INSERT INTO ChiTietLopHoc VALUES (1231415,'T101203', N' Cẩu Vàng', N'Môn Văn Học', 1950-5-8, 1999-12-7, N'Vắng 30%')
INSERT INTO ChiTietLopHoc VALUES (1231416,'T101203', N'Ông Ông Giáo', N'Môn Văn Học', 1950-5-5, 1999-12-12, N'Vắng 20%')

UPDATE SinhVien
SET TenSv = N'Nguyễn Văn Cai', MalopHoc = 'T101202'
WHERE MaSv = 1231411
UPDATE LopHoc
SET TenLopHoc = N'Nam Cao2'
WHERE MaLopHoc = 'T101203'
UPDATE ChiTietLopHoc
SET TrangThai = N'Vắng 12%'
WHERE MaSv = 1231414
--Xóa 1 dòng trong bảng Sinh Viên
ALTER TABLE ChiTietLopHoc DROP CONSTRAINT FK_SinhVien
GO
DELETE FROM SinhVien
WHERE MaLopHoc = 'T101203'

--Xóa 1 dòn trong bảng Lop Hoc
ALTER TABLE ChiTietLopHoc DROP CONSTRAINT FK_LopHoc
DELETE FROM LopHoc
WHERE TenLopHoc = N'NamCao2';

--Xóa 1 dòng trong bảng ChiTietLopHoc
DELETE FROM ChiTietLopHoc
WHERE MaSv = 1231415
