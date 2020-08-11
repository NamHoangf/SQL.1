  
CREATE DATABASE Example4
ON PRIMARY
(
   NAME='Example4',
   FILENAME='WHERE\EXAMPLE4.mdf'
)
(
   NAME='Example4'.
   FILENAME='WHERE\Example4.ldf'
)
GO

CREATE DATABASE Example4
ON PRIMARY
(   NAME= N'Customer_DB',
    FILENAME= N'C:\Temp\Example4.mdf')
	LOG ON
(NAME= N'Customer_DB_log',
    FILENAME=N'C:\Temp\Exmaple4_DB_log.ldf')
COLLATE SQL_Latin1_General_CP1_Ci_AS
GO