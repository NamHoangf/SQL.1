CREATE DATABASE City_Software 
GO

USE City_Software  
GO

CREATE TABLE Employee (
 EmployeeID int PRIMARY KEY,
 Name varchar(100),
 Tel char(11),
 Email varchar(30)
)
GO


CREATE TABLE Group1 (
GroupID int,
GroupName varchar(30),
LeaderID int PRIMARY KEY,
ProjectID int,
CONSTRAINT fk_Project FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
CONSTRAINT FK_Group FOREIGN KEY (GroupID) REFERENCES GroupDetail(GroupID)
)


CREATE TABLE Project (
 ProjectID int PRIMARY KEY,
 ProjectName varchar(30),
 StartDate datetime,
 EndDate datetime,
 Period int,
 Cost money
)

CREATE TABLE GroupDetail (
 GroupID int PRIMARY KEY,
 EmployeeID int,
 Status char(20),
 CONSTRAINT fk_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)
GO

--

INSERT INTO Employee VALUES (111, 'Nguyen VAn A', '01542312347', 'Nguyenvana@gmail.com'),
                             (112, 'Nguyen Van B', '09123451236','Nguyenvanb@gmail.com'),
							 (113, 'Hoang thi C', '02323453326', 'HoangthiC@gmail.com'),
							 (114,'Tran Thuy D', '02342344524','TranTHiD@gmail.com')
INSERT INTO Employee VALUES (115, 'Dinh Van E', '03242344323', 'DinhVcane@gmail.com')

INSERT INTO Group1 VALUES (11, 'Nhom Nghien Cuu', 1, 1111),
                           (12, 'Nhom Khoa Hoc', 2, 2222),
						   (13, 'Nhom Lap Trinh', 3,3333),
						   (14, 'Nhom Trai Nghiem', 4, 4444),
						   (15, 'Nhom Kham Pha', 5, 5555)

INSERT INTO Project VALUES (1111, 'Tim Giai PHap', '2010-2-4','2010-5-5', 3,4000000),
                           (2222, 'Tim Hanh Tin ', '1992-2-3','2020-3-2', 57, 1231432423),
						   (3333, 'Tao San Pham ', '2019-4-5','2019-6-4', 2, 20000000),
						   (4444, 'Di tim co Vat', '2012-2-4','2012-9-12',7, 9230000),
						   (5555, 'Bat Ma', '2019-2-3','2019-9-2', 7, 21312332)

INSERT INTO GroupDetail VALUES (11, 111, 'Da Lam'),
                                (12, 112, 'Dang lam'),
								(13,113, 'Da lam'),
								(14,114, 'Da lam'),
								(15,115, 'Da lam')


--3. Viết câu lệnh truy vấn để: 
--a. Hiển thị thông tin của tất cả nhân viên
SELECT EmployeeID, Name, Tel, Email
FROM Employee

--b. Liệt kê danh sách nhân viên đang làm dự án “Tim Giai PHap” 
SELECT Name
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE ProjectName ='Tim Giai PHap'

--c. Thống kê số lượng nhân viên đang làm việc tại mỗi nhóm 
SELECT   Count(*) SoLuongNhanVien
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE G.GroupName = 'Nhom Nghien Cuu'

SELECT   Count(*) SoLuongNhanVien
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE G.GroupName ='Nhom Khoa Hoc'

SELECT   Count(*) SoLuongNhanVien
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE G.GroupName ='Nhom Lap Trinh'

SELECT   Count(*) SoLuongNhanVien
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE G.GroupName ='Nhom Trai Nghiem'

SELECT   Count(*) SoLuongNhanVien
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID
WHERE G.GroupName ='Nhom Kham Pha'

--d. Liệt kê thông tin cá nhân của các trưởng nhóm 
SELECT GroupID, GroupName, LeaderID, ProjectID
FROM Group1

--e. Liệt kê thông tin về nhóm và nhân viên đang làm các dự án có ngày bắt đầu làm trước ngày 2010-2-4
SELECT  GroupName, Name, ProjectName
FROM Group1 as G
JOIN GroupDetail  as GD
ON GD.GroupID= G.GroupID
JOIN Employee as E
ON E.EmployeeID = GD.EmployeeID
JOIN Project as p
ON P.ProjectID=G.ProjectID
WHERE StartDate = '2010-2-4'

--f. Liệt kê tất cả nhân viên dự kiến sẽ được phân vào các nhóm làm việc 
SELECT EmployeeID, Name, Tel
FROM Employee 

--g. Liệt kê tất cả thông tin về nhân viên, nhóm làm việc, dự án của những dự án đã hoàn thành 
SELECT Name, Tel, Email 
FROM Employee 
WHERE EmployeeID IN(
SELECT EmployeeID
FROM GroupDetail 
WHERE Status = 'Da lam')

--4. Viết câu lệnh kiểm tra:
--a. Ngày hoàn thành dự án phải sau ngày bắt đầu dự án SELECT ProjectID, ProjectNameFROM ProjectWHERE StartDate < EndDate--b. Trường tên nhân viên không được nullSELECT EmployeeID, NameFROM EmployeeWHERE Name is NOT Null--c. Trường trạng thái làm việc chỉ nhận một trong 3 giá trị: inprogress, pending, done ALTER TABLE GroupDetailADD Status char(20) CHECK (Status is  not 'failed' and 'cancelled')--d. Trường giá trị dự án phải lớn hơn 1000 SELECT ProjectID, ProjectName, StartDate, EndDate, Period FROM ProjectWHERE Cost > 1000--e. Trưởng nhóm làm việc phải là nhân viên SELECT LeaderID , NameFROM Group1 as G
JOIN GroupDetail  as GD
ON GD.GroupID= G.GroupID
JOIN Employee as E
ON E.EmployeeID = GD.EmployeeID

--f. Trường điện thoại của nhân viên chỉ được nhập số và phải bắt đầu bằng số 0 
ALTER TABLE Employee
ADD CONSTRAINT chk_Tel CHECK (Tel not like '0%[^0-9]%')

--5. Tạo các thủ tục lưu trữ thực hiện: --a. Tăng giá thêm 10% của các dự án có tổng giá trị nhỏ hơn 21000000 CREATE PROCEDURE Tang10 asSELECT ProjectID, ProjectName, Cost + 210000FROM ProjectWHERE Cost < 21000000--b. Hiển thị thông tin về dự án sắp được thực hiện CREATE PROCEDURE Duan_SapLam asSELECT  ProjectNameFROM GroupDetail as GDJOIN Group1 as GOn G.GroupID=GD.GroupIDJOIN Project as PON P.ProjectID = G.ProjectIDWHERE Status = 'Chuan bi Lam'--c. Hiển thị tất cả các thông tin liên quan về các dự án đã hoàn thànhCREATE PROCEDURE ThonTin_DuAn ASSELECT ProjectName, StartDate,EndDate, Period , CostFROM GroupDetail as GDJOIN Group1 as GOn G.GroupID=GD.GroupIDJOIN Project as PON P.ProjectID = G.ProjectIDWHERE Status = 'Da Lam'--6. Tạo các chỉ mục: --a. Tạo chỉ mục duy nhất tên là IX_Group trên 2 trường GroupID và EmployeeID của bảng GroupDetailCREATE UNIQUE NONCLUSTERED INDEX IX_GroupON GroupDetail(GroupID, EmployeeID)--b. Tạo chỉ mục tên là IX_Project trên trường ProjectName của bảng Project gồm các trường StartDate và EndDateCREATE NONCLUSTERED INDEX IX_ProjectON Project(ProjectName, StartDate, EndDate)--7. Tạo các khung nhìn để
--a. Liệt kê thông tin về nhân viên, nhóm làm việc có dự án đang thực hiện 
CREATE VIEW ThongTin_NhanVien AS
SELECT Name, Tel, Email , GroupName, ProjectName, StartDate, EndDate, Period, Cost
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID

--b. Tạo khung nhìn chứa các dữ liệu sau: tên Nhân viên, tên Nhóm, tên Dự án và trạng thái làm việc của Nhân viên. 
CREATE VIEW View_DuLieu as
SELECT Name, Groupname, ProjectName, Status
FROM Employee as E
JOIN GroupDetail as GD
ON E.EmployeeID=GD.EmployeeID
JOIN Group1 as G
ON G.GroupID=GD.GroupID
JOIN Project as P
ON p.ProjectID=G.ProjectID

--8. Tạo Trigger thực hiện công việc sau:
--a. Khi trường EndDate được cập nhậtthì tự động tính toán tổng thời gian hoàn thành dự án và
--cập nhật vào trường Period CREATE TRIGGER CheckEndDateInsertON Project after INSERT AS     BEGIN        IF EXISTS (SELECT EndDate FROM inserted WHERE EndDate >= StartDate)
         BEGIN
             SELECT EndDate From INSERTED UPDATE Project
             SET Period = DATEDIFF(month, StartDate, EndDate)
         END
      	ENDGOINSERT INTO Project(ProjectID, ProjectName,StartDate, EndDate, Cost)  values (9999,'Truy Vi', '2019-1-12','2019-9-19', 200000000)--b. Đảm bảo rằng khi xóa một Group thì tất cả những bản ghi có liên quan trong bảng GroupDetail cũng sẽ bị xóa theo. CREATE TRIGGER checkGroupDeletedON GroupDetail AFTER DELETEAS     BEGIN 	DELETE FROM  GroupDetail	WHERE GroupID IN (SELECT GroupID FROM DELETED)	END---c. Không cho phép chèn 2 nhóm có cùng tên vào trong bảng Group. CREATE TRIGGER checkgroupupdateON Group1AFTER UPDATEAS     BEGIN 	IF EXISTS(SELECT*FROM inserted I inner join deleted D	ON I.GroupID = D.GroupID WHERE D.GroupName <> I.GroupName)	BEGIN 	  PRINT 'Không cho phép chèn 2 nhóm có cùng tên vào trong bảng Group';	  ROLLBACK TRANSACTION;	END    ENDINSERT INTO Group1 values(11,'Nhom T&T', 7,7777)UPDATE Group1 SET GroupName ='Nhom Hoa Lac' WHERE GroupID = 11