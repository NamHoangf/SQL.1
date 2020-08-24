CREATE DATABASE MyBlog
GO

USE MyBLog
GO
--2. Create the tables 
CREATE TABLE Users (
  UserID int PRIMARY KEY IDENTITY,
  UserName varchar(20),
  Password varchar(30),
  Email varchar(30) Unique,
  Address nvarchar(200)
)
GO

CREATE TABLE Posts (
  PostID int PRIMARY KEY IDENTITY,
  Title nvarchar(200),
  Contant nvarchar(100),
  Tag nvarchar(100),
  Status Bit,
  CreateTime datetime DEFAULT CURRENT_TIMESTAMP,
  UpdateTime datetime,
  UserID int,
  CONSTRAINT fk_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
)
GO

CREATE TABLE Comments (
  CommentID int PRIMARY KEY IDENTITY,
  Content nvarchar(500),
  Status bit,
  CreateTime datetime DEFAULT CURRENT_TIMESTAMP,
  Author nvarchar(30),
  Email varchar(50) NOT NULL,
  PostID int,
  CONSTRAINT fk_Post FOREIGN KEY (PostID) REFERENCES Posts(PostID)
)
GO

--3. Create a constraint (CHECK) to ensure value of Email column (on the Users table
--and the Comments table) always contain the ‘@’ character.
ALTER TABLE Users 
ADD CONSTRAINT user_check CHECK(Email LIKE '%@%')

--4. Create an unique, none-clustered index named IX_UserName on UserName column
--on table Users.
CREATE UNIQUE Clustered INDEX IX_UserName
ON Users(UserName)
--5. Insert into above tables at least 3 records per table.

INSERT INTO Users VALUES ('NVAN123','ABC123', 'Nguyenvanan@gmail.com', N'Hà Nội')
INSERT INTO Users VALUES ('Hoang123', 'H12345', 'Nguyenhoang@gmail.com', N'Hải Dương'),
                         ('LuubiHT', 'Luu123', 'Luubiht@gmail.com', N'Hà Nội'),
						 ('NBinhT1', 'Binh123', 'NinhBinh@gmail.com', N'Tương Dương'),
						 ('KTam1', 'Ktam121', 'Kinhtam@gmail.com', N'Bình Tam') 

INSERT INTO Posts VALUES (N'Cuộc Sống của tôi', N'Cuộc sống không giống như màu hồng',  N'Cuộc Sống',1, '1996-2-5', '2005-5-2',1)
INSERT INTO Posts VALUES (N'Tiểu Thuyết TT', N'Trong Cuộc sống màu xanh không có màu hồng', N'Xã Hội', 0, '2007-2-4','2012-4-4',2),
                         (N'Đại bàng sa mạc', N'Trong sa mạc xanh sahana ...', N'Chính Trị', 1, '2012-4-3', '2015-4-4',3),
						 (N'Cá bay bay Như CHim ', N'Cá trên trời xanh bay bay như chim', N'Ngoại Giao', 1, '2006-8-2', '2007-12-4', 4),
						 (N'Bài Tình Ca mùa Thu', N'Mùa thu có bài tình ca mùa thu', N'Thu Đàn', 0, '2012-2-9', '2019-4-4', 5)
INSERT INTO Comments VALUES (N'Hay',1, '1999-5-5', N'Giả Lưu','binhluan1@gmail.com', 1),
                             (N'Khá hay', 1, '2009-6-6',N'Lưu Gia', 'Binhluan2@gmail.com',2),
							 (N'Sướng mắt',0, '2014-4-4', N'Binh GIa', 'Binhluan3@gmail.com',3),
							 (N'Tuyệt vời', 1, '2006-9-4',N'Hau GIa', 'Binhluan4@gmail.com', 4),
							 (N'Xao xuyến',0, '2015-5-5',N'Thuc GIa', 'Binhluan5@gmail.com', 5)
--6. Create a query to select the postings has the ‘Social’ tag.('Xã hội'
SELECT Title, Contant, Status, CreateTime, UpdateTime
FROM Posts
WHERE Tag = N'Xã Hội'

--7. Create a query to select the postings that have author who has 'Binhluan4@gmail.com' email.
SELECT Title, Contant, Status, CreateTime, UpdateTime
FROM Posts
WHERE PostID IN (Select PostID FROM Comments
WHERE Email= 'Binhluan4@gmail.com')

--8. Create a query to count the total comments of the posting.
SELECT COUNT(*) AS TOTAL_COMMENTS 
FROM Comments 
GROUP BY PostID

--9. Create a view named v_NewPost, this view includes Title, UserName and CreateTime of two lastest posting.
CREATE VIEW v_NewPost AS 
SELECT Title, UserName, CreateTime
FROM Posts as P
JOIN Users as U
ON P.UserID = U.UserID

--10.Create a stored procedure named sp_GetComment that accepts PostID as given input parameter and display all comments of the posting.
CREATE PROCEDURE  sp_GetComment 
@PostID int
as
BEGIN 
SELECT CommentID, Content, Status, CreateTime, Author ,Email
FROM Comments
END
--11.Create a trigger nammed tg_UpdateTime to automatic update UpdateTime column
--in the Posts table to current time when the record in this table is updated.
CREATE TRIGGER tg_UpdateTime
ON Posts
AFTER UPDATE 
AS   
   BEGIN 
    UPDATE UpdateTime
	SET UpdateTime = CURRENT_TIMESTAMP
	FROM Posts
	JOIN inserted i ON UpdateTime.key = i.key 
    END