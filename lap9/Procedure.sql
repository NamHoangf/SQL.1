CREATE TABLE ToyzUnlimited 
GO
USE ToyzUnlimited
GO

CREATE TABLE Toys (
  ProductCode varchar(5) PRIMARY KEY,
  Name varchar(30),
  Category varchar(30),
  Manufacturer varchar(40),
  AgeRange varchar(15),
  UnitPrice money,
  Netweight int,
  QtyOnHand int
)
GO
--1. T?o b?ng Toys v?i c?u trúc gi?ng nh? trên. Thêm d? li?u (15 b?n ghi) vào b?ng v?i giá tr? c?a
--tr??ng QtyOnHand ít nh?t là 20 cho m?i s?n ph?m ?? ch?i. 
INSERT INTO Toys VALUES ('T1', 'JC Toys','Toys', 'Tennessee Williams', '3-5 Year Old', 35, 500, 125)
INSERT INTO Toys VALUES ('T2', 'Doll Riter' ,' Doll', 'Henderen', '3-7 Year Old', 25,400, 100),
                         ('T3', 'Teddy bear', 'Teddy', 'Hammer', '3-11 Year Old', 50,750, 1000),
						 ('T4', 'Football Ball', ' Ball', 'Removored', '5-15 year old', 30,400, 15000),
						 ('T5', 'Kite Bird',' Kite', 'Jiriu', '7-15 Year Old', 12,120, 1400),
						 ('T6', 'Titatic Boat','Boat', 'Jemruc', '5-15 year old', 47,1500, 234),
						 ('T7', 'Busan Train Toys', 'Toys', 'Yo na ka', '7-12 Year Old', 34,1250, 120),
						 ('T8', 'Yo-Yo Ryo','Yo-Yo','YoRic', '9-15 Year Old', 23,50, 1590),
						 ('T9', 'Slide Toys', 'Toys', 'HamHam', '6-12 Year Old', 45,400, 1230),
						 ('T10',' Balloon','Balloon', 'Balli', '5-15 Year Old', 12,25,120),
						 ('T11', 'Rocking Horse', 'Rocking', 'Jemrock',' 6-14 Year old', 60,2600,200),
						 ('T12', 'Whistle ','Whistle', 'Winner B', '5-15 Year old', 34,240, 120),
						 ('T13', 'Car Toys', 'Toys', 'LamaYa', '6-12 Year old', 90,250, 1200),
						 ('T14', 'Rubik cude', 'Rubik', 'Ruzana', '5-12 Year Old', 45,125, 1200),
						 ('T15', 'Block Tomokid', ' Block', 'Tomaya', '7-12 Year old', 34,124, 123)
--2. Vi?t câu l?nh t?o Th? t?c l?u tr? có tên là HeavyToys cho phép li?t kê t?t c? các lo?i ?? ch?i có
--tr?ng l??ng l?n h?n 500g. 
CREATE  PROCEDURE  HeavyToys AS 
SELECT Name FROM Toys 
WHERE Netweight > 500
--3. Vi?t câu l?nh t?o Th? t?c l?u tr? có tên là PriceIncreasecho phép t?ng giá c?a t?t c? các lo?i ??
--ch?i lên thêm 10 ??n v? giá.
CREATE PROCEDURE  PriceIncrease as
SELECT ProductCode,Name, Category, ManuFacturer, UnitPrice+10 As price_increases, Netweight, QtyOnHand
FROM Toys
--4. Vi?t câu l?nh t?o Th? t?c l?u tr? có tên là QtyOnHand làm gi?m s? l??ng ?? ch?i còn trong c?a
--hàng m?i th? 5 ??n v?.  

CREATE PROCEDURE QtyOnHand AS
SELECT ProductCode,Name, Category, ManuFacturer, UnitPrice, QtyOnHand-5 as QtyONHand_decrease
From Toys

--
Exec  HeavyToys
EXECUTE PriceIncrease
EXEC QtyOnHand

--Ph?n IV: Bài t?p v? nhà 
--1. Ta ?ã có 3 th? t?c l?u tr? tên là HeavyToys,PriceIncrease, QtyOnHand. Vi?t các câu l?nh xem
--??nh ngh?a c?acác th? t?c trên dùng 3 cách sau: 
Exec sp_helptext HeavyToys
sp_helptext PriceIncrease
sp_helptext QtyOnHand

SELECT definition FROM sys.sql_modules WHERE object_id=OBJECT_ID('HeavyToys')
SELECT definition FROM sys.sql_modules WHERE object_id=OBJECT_ID('PriceIncrease')
SELECT definition FROM sys.sql_modules WHERE object_id=OBJECT_ID('QtyOnHand')

SELECT OBJECT_DEFINITION(OBJECT_ID('HeavyToys'));
SELECT OBJECT_DEFINITION(OBJECT_ID('PriceIncrease'));
SELECT OBJECT_DEFINITION(OBJECT_ID('QtyOnHand'));

--2. Vi?t câu l?nh hi?n th? các ??i t??ng ph? thu?c c?a m?i th? t?c l?u tr? trên 
EXECUTE sp_depends HeavyToys
EXECUTE sp_depends PriceIncrease 
EXECUTE sp_depends QtyOnHand

--3. Ch?nh s?a th? t?c PriceIncreasevà QtyOnHandthêm câu l?nh cho phép hi?n th? giá tr? m?i ?ã
--???c c?p nh?t c?a các tr??ng (UnitPrice,QtyOnHand). 
ALTER PROCEDURE PriceIncrease as
UPDATE Toys SET UnitPrice = UnitPrice+15 
GO
ALTER PROCEDURE QtyOnHand AS
UPDATE Toys SET QtyOnHand = QtyOnHand-10
GO

--4. Vi?t câu l?nh t?o th? t?c l?u tr? có tên là SpecificPriceIncrease th?c hi?n c?ng thêm t?ng s? s?n
--ph?m (giá tr? tr??ng QtyOnHand)vào giá c?a s?n ph?m ?? ch?i t??ng ?ng. 

CREATE PROCEDURE SpecificPriceIncrease AS 
UPDATE toys SET UnitPrice = UnitPrice+ QtyOnHand
GO
exec SpecificPriceIncrease
select* from Toys
--5. Ch?nh s?a th? t?c l?u tr? SpecificPriceIncrease cho thêm tính n?ng tr? l?i t?ng s? các b?n ghi
--???c c?p nh?t. 
ALTER PROCEDURE SpecificPriceIncrease AS 
BEGIN 
UPDATE Toys SET UnitPrice = UnitPrice + QtyOnHand
SELECT ProductCode,Name, Category, ManuFacturer, UnitPrice AS Price, QtyOnHand 
FROM Toys
WHERE QtyOnHand > 0
SELECT @@ROWCOUNT
END

--6. Ch?nh s?a th? t?c l?u tr? SpecificPriceIncrease cho phép g?i th? t?c HeavyToysbên trong nó 
ALTER PROCEDURE SpecificPriceIncrease AS
BEGIN
UPDATE Toys SET UnitPrice = UnitPrice+QtyOnHand
SELECT ProductCode, Name, UnitPrice as Price, QtyOnHand 
FROM Toys
WHERE QtyOnHand > 0
SELECT @@ROWCOUNT
EXECUTE HeavyToys
END
EXEC SpecificPriceIncrease
--7. Th?c hi?n ?i?u khi?n x? lý l?i cho t?t c? các th? t?c l?u tr? ???c t?o ra. 
--8. Xóa b? t?t c? các th? t?c l?u tr? ?ã ???c t?o ra
DROP PROCEDURE HeavyToys
DROP PROCEDURE QtyOnHand
DROP PROCEDURE PriceIncrease
mon