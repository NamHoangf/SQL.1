CREATE DATABASE BOOK_STORE
GO

USE BOOK_STORE
GO

CREATE TABLE Customer (
 CustomerID int PRIMARY KEY IDENTITY,
 CustomerName varchar(50),
 Address varchar(100),
 Phone varchar(12)
 )
 GO

CREATE TABLE Book (
   BookCode int PRIMARY KEY,
   Category varchar(50),
   Author varchar(50),
   Publisher varchar(50),
   Title varchar(100),
   Price int,
   InStore int
)
GO

CREATE TABLE BookSold (
  BookSoldID int PRIMARY KEY,
  CustomerID int,
  BookCode int,
  Date datetime,
  Price int,
  Amount int,
  CONSTRAINT fk_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  CONSTRAINT fk_Book FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
 )

 --1. Chèn ít nhất 5 bản ghi vào bảng Books, 5 bản ghi vào bảng Customer và 10 bản ghi vào bảng  BookSold. 
 INSERT INTO Book VALUES (111, 'Literature', 'Lister', 'Bui Vien', 'Viet cho nhau nghe', 12, 100),
                         (112, 'Economic' ,' Macaer', 'Luong Gia', 'Doc de lam giau', 50, 120),
						 (113, 'Astronomy', 'Hocake', 'Pham Bang', 'Doc de tuong tuong', 23, 101),
						 (114, 'Food','Busicter','Ma Long', 'Doc de an ngon', 20, 90),
						 (115, 'Math', 'LuCak','Hac Hoa', 'Doc de thong minh',40, 50)

INSERT INTO Customer VALUES ( 'Luku', 'A Mat Tinia Glu', '012412412'),
                             ('BigBoy', 'Luu Bang Cai Tiu', ' 12312412'),
							 ('BlueC', 'A Ram Mat', '12312414'),
							 ('HoliShirk','Ngoai Bang Phok', '3452343243'),
							 ( 'Hicrid', 'Thirn Born', '234234234')
INSERT INTO BookSold VALUES (21, 1, 111, '1920-12-5', 15, 10),
                            (22, 2, 112, '1950-5-12', 48, 12),
							(23, 3, 113, '1940-4-2', 26, 10),
							(24, 4, 114, '1962-1-1', 18, 20),
							(25, 5, 115, '1920-1-4', 48, 29)

--2. Tạo một khung nhìn chứa danh sách các cuốn sách (BookCode, Title, Price) kèm theo số lượng đã
--bán được của mỗi cuốn sách. 

CREATE VIEW BookList AS
SELECT Book.BookCode, Title, Book.Price, Amount
FROM Book 
JOIN BookSold
ON BookSold.BookCode = Book.BookCode

--3. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) kèm
--theo số lượng các cuốn sách mà khách hàng đó đã mua. CREATE VIEW CustomerList ASSELECT Customer.CustomerID, CustomerName, Address, BookSold.AmountFROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID--4.. Tạo một khung nhìn chứa danh sách các khách hàng (CustomerID, CustomerName, Address) đã
--mua sách vào tháng trước, kèm theo tên các cuốn sách mà khách hàng đã mua. CREATE VIEW CustomerListago1month ASSELECT Customer.CustomerID, CustomerName, Address,Book.CategoryFROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID
JOIN Book
ON Book.BookCode = BookSold.BookCode
WHERE BookSold.Date = DATEADD(month, -1, '1920-2-4')

SELECT * FROM CustomerListago1month 
--Tạo một khung nhìn chứa danh sách các khách hàng kèm theo tổng tiền mà mỗi khách hàng đã chi
--cho việc mua sách. 
CREATE VIEW CustomerSumMoney AS
SELECT Customer.CustomerID, CustomerName, Price * Amount as SUM_Money
FROM CustomerJOIN BookSoldOn BookSold.CustomerID = Customer.CustomerID

--Phần IV: Bài tập về nhà 

CREATE DATABASE Management_Class
GO

USE Management_Class
GO

CREATE TABLE Class (
  ClassCode varchar(10) PRIMARY KEY,
  HeadTeacher varchar(30),
  Room varchar(30),
  TimeSlot char,
  CloseDate datetime
)
GO


CREATE TABLE Student (
  RollNo varchar(10) PRIMARY KEY,
  ClassCode varchar(10),
  Fullname varchar(30),
  Male bit,
  BirthDate datetime,
  Address varchar(30),
  Privice char(2),
  Email varchar(30),
  CONSTRAINT fk_class FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode)
 )
 GO
 
 
CREATE TABLE Subject (
  SubjectCode varchar(10) PRIMARY KEY,
  SubjectName varchar(40),
  WMark bit,
  PMark bit,
  WTest_per int,
  Ptest_per int
)
GO

CREATE TABLE Mark (
 RollNo varchar(10),
 SubjectCode varchar(10),
 WMark float,
 PMark float,
 Mark float,
 CONSTRAINT pk_mark PRIMARY KEY(RollNo, SubjectCode),
 CONSTRAINT fk_Student FOREIGN KEY (RollNo) REFERENCES Student(RollNo),
 CONSTRAINT fk_Subject FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
 )
 GO


 --
 INSERT INTO Class VALUES ('T2004M','ThiDk','Class 207', 'G', '2022-1-12'),
                         ('T2004E','HiDK', 'Class 208', 'K', '2021-12-4'),
						 ('T2005M', 'YDK', 'Class 209', 'I', '2023-2-4'),
						 ('T2005E', 'ThuyDK', 'Class 210', 'M', '2020-5-2'),
						 ('T2006M', 'DANGKTHi', 'Class 211', 'N', '2021-6-2')

 INSERT INTO Student values ('A1', 'T2004M', 'Nguyen Van A', 1, '1991-2-10', 'Tu Liem', 'HP', 'Nguyenvana@gmail.com'),
                             ('B1', 'T2004E', 'Nguyen Thi B', 0, '1995-5-5', 'Soc Son', 'NB', 'Nguyenthib@gmail.com'),
							 ('C1', 'T2005M', 'Hoang Van C', 1,'1994-4-25', 'Thanh Xuan', 'HN', 'Hoangvanc@gmail.com'),
							 ('D1', 'T2005E', 'Luu thuy D', 0, '1997-2-5', 'Hoang Kim', 'BN', 'Luuthuyd@gmail.com'),
							 ('E1', 'T2006M', 'Pham Van E', 1, '1998-2-4', 'Truc Linh', 'HL', 'Phamvane@gmail.com')
INSERT INTO Student values ('B2', 'T2004E', 'Nguyen Van Be', 1, '1994-5-4', 'Ba Tun', 'LS', 'Nguyenvanbe@gmail.com'),
                            ('B3', 'T2004E', 'Nguyen Van Ben', 1,'1996-7-5', 'Con TUm', 'DL','Nguyenvanben@gmail.com')
                           
INSERT INTO Subject VALUES ('EPC', 'Elementary', 1,1, 100,100),
                            ('CF','Control Farm', 0,1, 0, 100),
							('Java1', 'Juventu', 1,0, 10, 0),
							('Buff', 'Legend', 1,1, 10,10),
							('Math', 'Math Mogic', 1,0,10,0),
							('Economic', 'Economic of VN', 1,0,100,0)
							
INSERT INTO Mark VALUES ('A1', 'EPC', 86, 90, 88),
                        ('B1', 'CF', 70,87, 78.5),
						('C1','Java1', 78, 80, 79),
	                    ('D1','Buff', 60,65, 62.5),
						('E1', 'Economic', 79, 80, 79.5)
INSERT INTO Mark VALUES ('A1', 'CF', 79,80, 79.5),
                        ('C1','Buff', 67,80,73.5)
INSERT INTO Mark  VALUES ('B1', 'EPC', 35, 56, 45.5),
                         ('D1', 'Java1', 25, 65, 45)
INSERT INTO Mark VALUES ('B2', 'CF', 35, 55, 45),
                         ('B2', 'Economic', 45,35, 40)
INSERT INTO Mark VALUES ('B3', 'EPC', 35,45, 40),
                        ('B3', 'Java1', 25,45, 35)
--2. Tạo một khung nhìn chứa danh sách các sinh viên đã có ít nhất 2 bài thi (2 môn học khác nhau). 
CREATE VIEW List_Studen_2test as
SELECT dt.RollNo, hs.ClassCode,hs.Fullname, COUNT(*) AS N'Đã Thi ít nhất 2 môn'
FROM Student as hs
JOIN Mark as dt
ON hs.RollNo = dt.RollNo
GROUP BY dt.RollNo, hs.ClassCode, hs.Fullname
HAVING COUNT(SubjectCode)>1
--
CREATE VIEW List_Student_2test2 as
SELECT ClassCode, Fullname
FROM Student
WHERE RollNo IN (SELECT RollNo FROM Mark 
                GROUP BY RollNo
                HAVING count(SubjectCode)>1)

--3. Tạo một khung nhìn chứa danh sách tất cả các sinh viên đã bị trượt ít nhất là một môn.
CREATE VIEW Student_Exam_Faill as
SELECT ClassCode, Fullname as SV_Thi_Truot
FROM Student 
WHERE RollNo IN (SELECT RollNo FROM Mark
               WHERE Mark < 50)

--4.Tạo một khung nhìn chứa danh sách các sinh viên đang học ở TimeSlot G. 
CREATE VIEW Student_Study_TimeSlotG as
SELECT ClassCode, Fullname as SV_TimeSlotG
FROM Student
WHERE ClassCode IN (SELECT ClassCode FROM Class
                    WHERE TimeSlot= 'G')
--5. Tạo một khung nhìn chứa danh sách các giáo viên có ít nhất 3 học sinh thi trượt ở bất cứ môn nào. 
CREATE VIEW Teacher_Student_Examfaill as
SELECT HeadTeacher, Room
FROM Class 
WHERE ClassCode IN (SELECT ClassCode FROM Student_Exam_Faill
                            GROUP BY ClassCode
							HAVING count(SV_Thi_Truot)>2)
 --6. Tạo một khung nhìn chứa danh sách các sinh viên thi trượt môn EPC của từng lớp. Khung nhìn
--này phải chứa các cột: Tên sinh viên, Tên lớp, Tên Giáo viên, Điểm thi môn EPC.    
CREATE VIEW Student_ExamFaill_EPC AS
SELECT Fullname, Room, HeadTeacher, WMark, PMark, Mark
FROM Student
JOIN Class
ON Class.ClassCode = Student.ClassCode
JOIN Mark
ON Mark.RollNo = Student.RollNo
WHERE SubjectCode='EPC' AND Mark <50