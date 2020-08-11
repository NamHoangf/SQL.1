USE tempdb
CREATE TABLE dbo.Customers(
            EmployeeId int IDENTITY(1,1) NOT NULL,
			CustomerInfo xml NOT NULL,
			Updated datetime NOT NULL DEFAULT (getdate()),
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED
(
             [EmployeeId] ASC
) ON [PRIMARY]
) ON [PRIMARY]