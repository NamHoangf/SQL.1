CREATE DATABASE Batch
GO
USE Batch
GO

CREATE TABLE Batch (
BatchNo nvarchar(5),
Subject nvarchar(25),
SubjDesc nvarchar(25),
StartDt DateTime,
EndDt DateTime,
Hours int
);

INSERT INTO Batch values
('A01','Java','Database','12-01-2006','03-15-2006',96);

INSERT INTO Batch values
('A02','Oracle','Database','08-25-2006','11-02-2006',55);

INSERT INTO Batch values
('A03','Sql Server 2005','Database','05-15-2006','06-06-2006',46);

INSERT INTO Batch values
('A04','Net','Database','06-20-2005','08-16-2006',48);

INSERT INTO Batch values
('A05','JSF & Struts','CustomControls','09-07-2005','10-18-2005',120);
SELECT * FROM Batch
--Dâediff để trừ 2 khoảng thời gian(month of Endt- month of startdt)
SELECT DATEDIFF(month, StartDt, EndDt) FROM Batch
--pivot tính tổng 
SELECT BatchNo, [2005] Y2005, [2006] Y2006 
FROM
(SELECT YEAR(StartDt) StartYear, BatchNo, Hours FROM Batch)pft
PIVOT
(
SUM(Hours)
FOR StartYear in ([2005],[2006])
)pst


INSERT INTO Batch values
('A01','Java','Database','12-01-2005','03-15-2006',96);

INSERT INTO Batch values
('A02','Oracle','Database','08-25-2005','11-02-2006',55);

INSERT INTO Batch values
('A03','Sql Server 2005','Database','05-15-2005','06-06-2006',46);

INSERT INTO Batch values
('A04','Net','Database','06-20-2005','08-16-2006',48);

INSERT INTO Batch values
('A05','JSF & Struts','CustomControls','09-07-2005','10-18-2005',120);
SELECT * FROM Batch

--