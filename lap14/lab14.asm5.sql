CREATE DATABASE Assignment_05
GO

USE Assignment_05
GO
--nguoi
CREATE TABLE Person (
 PersonID int PRIMARY KEY, 
 PersonName nvarchar(40),
 Address nvarchar(60),
 Birthday datetime
 )
GO
--lien he
CREATE TABLE Contact (
 ContactID int PRIMARY KEY,
 ContactNumber int,
 PersonID int, 
 CONSTRAINT fk_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
)
GO

--3. Viết các câu lệnh để thêm dữ liệu vào các bảng

INSERT INTO Person values (11,N'Nguyễn Văn An', N'111 Nguyễn trãi, Thanh Xuân, Hà Nội', '1987-8-11'),
                          (12, N' Nguyễn Văn Bình', N'Hải Châu, Hải Dương', '1982-3-4'),
						  (13, N' Hoàng Thị Châu', N'Trùng Khánh, bắc Ninh', '1992-12-5'),
						  (14, N' Trịnh Đình Dương', N'Cao lãnh, Lạnh Sơn', '1989-4-6'),
						  (15, N' Mai Thúc Đạt', N'Tây Can, Hà Nam', '1990-5-5')

INSERT INTO Contact values (111, 987654321, 11),
                            (112, 09873452, 11),
							(113, 09832323, 11),
							(114,09434343,11),
							(115,09234234,12),
							(116,09234234, 12),
							(117, 09123212,13),
							(118, 09234234, 13),
							(119, 09234234, 14),
							(120,09234234, 15)
--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách những người trong danh bạ
SELECT PersonName 
FROM Person
--b) Liệt kê danh sách số điện thoại có trong danh bạ
SELECT ContactNumber 
FROM Contact

--5. Viết các câu lệnh truy vấn để lấy
--a) Liệt kê danh sách người trong danh bạ theo thứ thự alphabet
SELECT PersonName
FROM Person
ORDER BY PersonName 

--b) Liệt kê các số điện thoại của người có thên là Nguyễn Văn An.
SELECT ContactNumber
FROM Contact
WHERE PersonID IN (SELECT PersonID FROM Person WHERE PersonName= N'Nguyễn Văn An')

--c) Liệt kê những người có ngày sinh là 1990-5-5SELECT PersonNameFROM PersonWHERE birthday = '1990-5-5'--6. Viết các câu lệnh truy vấn để
--a) Tìm số lượng số điện thoại của mỗi người trong danh bạ.
SELECT COUNT(*) as Sum_PhoneNumber
FROM Contact
GROUP BY PersonID
--b) Tìm tổng số người trong danh bạ sinh vào thang 12.
SELECT PersonName
FROM Person
WHERE Month(birthday) = 12
--c) Hiển thị toàn bộ thông tin về người, của từng số điện thoại
SELECT PersonName, Address, Birthday
FROM Person
WHERE PersonID IN (SELECT PersonID FROM Contact
WHERE ContactNumber = 987654321)


SELECT PersonName, Address, Birthday
FROM Person
WHERE PersonID IN (SELECT PersonID FROM Contact
WHERE ContactNumber = 9234234)

SELECT PersonName, Address, Birthday
FROM Person
WHERE PersonID IN (SELECT PersonID FROM Contact
WHERE ContactNumber = 9123212)

SELECT PersonName, Address, Birthday
FROM Person
WHERE PersonID IN (SELECT PersonID FROM Contact
WHERE ContactNumber =9234234)

--d) Hiển thị toàn bộ thông tin về người, của số điện thoại 9234234
SELECT PersonName, Address, Birthday
FROM Person
WHERE PersonID IN (SELECT PersonID FROM Contact
WHERE ContactNumber =9234234)
--7. Thay đổi những thư sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.ALTER TABLE PersonADD CONSTRAINT birhtday_1 CHECK(birthday < getdate())--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.--c) Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.ALTER TABLE ContactADD StartDateContact datetime --8. Thực hiện các yêu cầu sau
--a) Thực hiện các chỉ mục sau(Index)

-- IX_HoTen : đặt chỉ mục cho cột Họ và tên

CREATE INDEX IX_HoTen 
ON Person(PersonName)

--IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoạiCREATE INDEX IX_SoDienThoaiON Contact(ContactNumber)--b) Viết các View sau:
--View_SoDienThoai: hiển thị các thông tin gồm Họ tên, Số điện thoại
CREATE VIEW View_SoDienThoai AS
SELECT PersonName, ContactNumber
FROM Person as p
JOIN Contact as c
ON c.PersonID = p.PersonID

--View_SinhNhat: Hiển thị những người có sinh nhật trong tháng hiện tại (Họ tên, Ngày sinh, Số điện thoại)
CREATE VIEW View_SinhNhat AS 
SELECT PersonName, Birthday, ContactNumber
FROM Person as p
JOIN Contact as c
ON c.PersonID = p.PersonID
WHERE Month(birthday) = month(GETDATE())
--https://www.howkteam.vn/course/su-dung-sql-server/truy-van-voi-dieu-kien-trong-sql-server-1389
--c) Viết các Store Procedure sau:
-- SP_Them_DanhBa: Thêm một người mới vào danh bạn
CREATE PROCEDURE SP_Them_DanhBa AS 
INSERT INTO Person VALUES (16, N'Phan Công Chánh', N'Tây triều', '1992-12-12')

--SP_Tim_DanhBa: Tìm thông tin liên hệ của một người theo tên (gần đúng)
CREATE PROCEDURE SP_Tim_DanhBa AS 
SELECT PersonName, ContactNumber, Address, Birthday
FROM Person as p
JOIN Contact as c
ON c.PersonID = p.PersonID
WHERE PersonName = N'Nguyễn Văn An'