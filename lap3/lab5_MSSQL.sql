CREATE DATABASE BookDream
GO
USE BookDream	
GO
--Xem bảng đã tồn tại hay chưa
IF OBJECT_ID('Book') IS NOT NULL
DROP TABLE Book
GO
CREATE TABLE Book(
  --Dùng để xác định mỗi cuốn sách là duy nhât.
  BookCode int ,
  --Lưu tiêu đề cuốn sách, không cho phép Null
  BookTitle varchar(100) NULL,
  --Tên tác giả, không cho phép Null
  Author varchar(50) NOT NULL,
  --Lần xuất bản
  Edition int,
  --Giá bán
  BookPrice money NOT NULL,
  --Số cuốn có trong thư viện
  Copies int,
  CONSTRAINT BookCode_dr PRIMARY KEY (BookCode)
);
GO
SELECT * FROM Book
INSERT INTO Book VALUES(111,'Music','BigBang',100, 2000,110)
INSERT INTO Book VALUES(112,'Sport','Bat',101, 2002,310)
INSERT INTO Book VALUES(113,'Game','Hittle',103, 2030,112)
INSERT INTO Book VALUES(114,'Liu','Hedan',100, 2001,130)
INSERT INTO Book(BookCode,BookTitle) VALUES (115,'Legan')

CREATE TABLE Member(
  --Dùng để xác định người mượn là duy nhât.
  MemberCode int,
  --Lưu tên người mượn, không cho phép Null
  Name varchar(50) NOT NULL,
  --Địa chỉ của người mượn, không cho phép Null
  Address varchar(100) NOT NULL,
  --Số điện thoại
  PhoneNumber int
 CONSTRAINT MemberCode_dr PRIMARY KEY (MemberCode)
);
GO
INSERT INTO Member(MemberCode, Name, Address) VALUES (1,'Minh','Hanoi')
SELECT * FROM Member
INSERT INTO Member VALUES(2,'Linh','Hanoi',09345435)

CREATE TABLE IssueDetails(
 --Mã cuốn sách có trong bảng Book
 BookCode int ,
 --Mã người mượn có trong bảng Member
 MemberCode int ,
 --Ngày mượn sách
 IssueDate datetime,
 --Ngày trả sách
 ReturnDate datetime
 CONSTRAINT FK_IssueBook FOREIGN KEY(BookCode) REFERENCES Book,
 CONSTRAINT FK_IssueMember FOREIGN KEY(MemberCode) REFERENCES Member

);
GO

INSERT INTO IssueDetails VALUES(111,1,'2015-7-5','2016-7-6')

SELECT * FROM Book
SELECT * FROM Member
SELECT * FROM IssueDetails

--Xóa bỏ các Ràng buộc Khóa ngoại của bảng IssueDetails
ALTER TABLE dbo.IssueDetails DROP CONSTRAINT FK_IssueBook
GO
ALTER TABLE dbo.IssueDetails DROP CONSTRAINT FK_IssueMember
GO

--Xóa bỏ Rnafg buộc Khóa CHính của bảng Member và Book
ALTER TABLE Book
DROP CONSTRAINT BookCode_dr;
GO
ALTER TABLE Member
DROP CONSTRAINT MemberCode_dr;
GO

--Thêm mới Ràng buộc Khóa chính cho bảng Member và Book
ALTER TABLE Book
ADD PRIMARY KEY (BookCode);
GO
ALTER TABLE Member
ADD PRIMARY KEY (MemberCode);
GO

--Thêm mới các Ràng buộc Khóa ngoại cho bảng IssueDetails

ALTER TABLE IssueDetails 
ADD CONSTRAINT FK_BookIssue 
FOREIGN KEY(BookCode) 
REFERENCES Book(BookCode)
GO

ALTER TABLE IssueDetails 
ADD CONSTRAINT FK_MemberIssie
FOREIGN KEY(MemberCode) 
REFERENCES Member(MemberCode)
GO