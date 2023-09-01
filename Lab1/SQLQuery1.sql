create database SoftLicenseManagement

use SoftLicenseManagement
CREATE TABLE Contacts (
    Id          INT             IDENTITY (1, 1) NOT NULL,
	Name		  NVARCHAR (75)   NOT NULL,
    Email       NVARCHAR (75)   NOT NULL,
	Address     NVARCHAR (75)   NULL,
    Phone       NVARCHAR (75)   NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);
CREATE TABLE Owners (
    Id          INT             IDENTITY (1, 1) NOT NULL,
	ContactId		INT            NOT NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);
CREATE TABLE Customers (
    Id         INT             IDENTITY (1, 1) NOT NULL,
	ContactId	  INT            NOT NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);



CREATE TABLE Software (
    Id          INT      IDENTITY (1, 1) NOT NULL,
    Name			NVARCHAR(75)    NOT NULL,
	Version      NVARCHAR(75)    NOT NULL,
	Price			MONEY          NOT NULL,
    OwnerId       INT      NOT NULL,
    DateCreated DATETIME NOT NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);



CREATE TABLE Licenses (
    Id				INT            IDENTITY (1, 1) NOT NULL,
    Title				NVARCHAR (75)  NOT NULL,
    PaymentDate		DATETIME       NOT NULL DEFAULT(GETDATE()),
    ExpiryDate		DATETIME		NOT NULL,
    SoftwareId		INT            NOT NULL,
    CustomerId		INT            NOT NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);

CREATE TABLE LicensesHistory (
    Id				INT            IDENTITY (1, 1) NOT NULL,
	LicenseId			INT            NOT NULL,
    Title				NVARCHAR (75)  NOT NULL,
    PaymentDate		DATETIME       NOT NULL DEFAULT(GETDATE()),
    ExpiryDate		DATETIME       NOT NULL,
    SoftwareId		INT            NOT NULL,
    CustomerId		INT            NOT NULL,
    PRIMARY KEY CLUSTERED (Id ASC)
);




---------------------------------------------------------------keys---
ALTER TABLE Software
    ADD CONSTRAINT FK_Software_Owners FOREIGN KEY (OwnerId) REFERENCES Owners (Id);
GO
ALTER TABLE Licenses
    ADD CONSTRAINT FK_Licenses_Software FOREIGN KEY (SoftwareId) REFERENCES Software (Id);
GO
ALTER TABLE Licenses
    ADD CONSTRAINT FK_Licenses_Customers FOREIGN KEY (CustomerId) REFERENCES Customers (Id);
GO
ALTER TABLE Owners
    ADD CONSTRAINT FK_Owners_Contacts FOREIGN KEY (ContactId) REFERENCES Contacts (Id);
GO
ALTER TABLE Customers
    ADD CONSTRAINT FK_Customers_Contacts FOREIGN KEY (ContactId) REFERENCES Contacts (Id);
GO

--------------------------------------------------------------indexes---------------------
CREATE NONCLUSTERED INDEX IX_Software_OwnerId
    ON Software(OwnerId ASC);
GO

CREATE NONCLUSTERED INDEX IX_Owners_ContactId
    ON Owners(ContactId ASC);
GO

CREATE NONCLUSTERED INDEX IX_Customers_ContactId
    ON Customers(ContactId ASC);
GO

CREATE NONCLUSTERED INDEX IX_Licenses_SoftwareId
    ON Licenses(SoftwareId ASC);
GO

CREATE NONCLUSTERED INDEX IX_Licenses_CustomerId
    ON Licenses(CustomerId ASC);

---------------------------------------------------------------Procedures---
CREATE PROCEDURE usp_AddSoftware
    @name NVARCHAR(75),
	@version NVARCHAR(75),
	@price MONEY,
    @ownerId INT,
	@date DATETIME,
    @softwareId INT OUTPUT
AS
BEGIN
    INSERT INTO [dbo].[Software]
    (
        Name,
		Version,
		Price,
		OwnerId,
		DateCreated
    )
    VALUES (@name, @version, @price, @ownerId, @date)

    SET @softwareId = SCOPE_IDENTITY()
END
GO


CREATE PROCEDURE usp_AddLicense
    @title NVARCHAR(75),
	@expirydate DATETIME,
	@softwareId INT,
	@customerId INT,
    @licenseId INT OUTPUT
AS
BEGIN
    INSERT INTO [dbo].[Licenses]
    (
        Title,
		ExpiryDate,
		SoftwareId,
		CustomerId
    )
    VALUES (@title, @expirydate, @softwareId, @customerId)

    SET @licenseId = SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE usp_AddOwner
    @name NVARCHAR(75),
	@email NVARCHAR(75),
	@address NVARCHAR(75),
	@phone NVARCHAR(75),
    @ownerId INT OUTPUT
AS
BEGIN
	DECLARE @contactId INT

    INSERT INTO [dbo].[Contacts]
    (
        Name,
		Email,
		Address,
		Phone
    )
    VALUES (@name, @email, @address, @phone)

    SET @contactId = SCOPE_IDENTITY()

	INSERT INTO [dbo].[Owners]
    (
        ContactId
    )
    VALUES (@contactId)

	 SET @ownerId = SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE usp_AddCustomer
    @name NVARCHAR(75),
	@email NVARCHAR(75),
	@address NVARCHAR(75) = NULL,
	@phone NVARCHAR(75),
    @ownerId INT OUTPUT
AS
BEGIN
	DECLARE @contactId INT

    INSERT INTO [dbo].[Contacts]
    (
        Name,
		Email,
		Address,
		Phone
    )
    VALUES (@name, @email, @address, @phone)

    SET @contactId = SCOPE_IDENTITY()

	INSERT INTO [dbo].[Customers]
    (
        ContactId
    )
    VALUES (@contactId)

	 SET @ownerId = SCOPE_IDENTITY()
END


DECLARE @custid Int 
exec usp_AddCustomer 'It school','ItSchool@gmail.com','Minsk','375293751214',@custid OUTPUT; 
PRINT @custid

DECLARE @ownerid Int 
exec usp_AddOwner'jetBrains','jetBrains@mail.ru','Munich','1334568',@ownerid OUTPUT; 
PRINT @ownerid

DECLARE @softId Int 
exec usp_AddSoftware 'PyCHarm','2.20.4',27,1,'15.11.2005', @softId OUTPUT; 
PRINT @softId
select * from Software
DECLARE @licenseId Int 
exec usp_AddLicense'ItSchool license','13.03.2023',2,1, @licenseId OUTPUT; 
PRINT @licenseId
-----views-----
CREATE VIEW vw_InactiveLicenses
AS

SELECT l.Id
      ,l.Title
      ,l.PaymentDate
      ,l.ExpiryDate
      ,l.SoftwareId
      ,l.CustomerId
FROM Licenses l
WHERE l.ExpiryDate < GETDATE();

select * from vw_ActiveLicenses
CREATE VIEW vw_ActiveLicenses
AS

SELECT l.Id
      ,l.Title
      ,l.PaymentDate
      ,l.ExpiryDate
      ,l.SoftwareId
      ,l.CustomerId
FROM Licenses l
WHERE l.ExpiryDate > GETDATE();
select * from vw_InactiveLicenses
CREATE VIEW vw_Unpayment
AS

SELECT l.Id
      ,l.Title
      ,l.PaymentDate
      ,l.ExpiryDate
      ,l.SoftwareId
      ,l.CustomerId
FROM Licenses l
WHERE l.PaymentDate < GETDATE();
select * from vw_Unpayment

------function---
CREATE FUNCTION udf_TotalCostOfPurchasedLicenses() returns INT 
AS
BEGIN  
     DECLARE @sum INT = 
	 (SELECT sum(s.Price) 
	 FROM vw_ActiveLicenses l 
	 INNER JOIN 
	 Software s on l.SoftwareId = s.Id);    
     RETURN @sum;
END; 



create function CountOfCustLic(@id int)
returns int
as
begin
declare @count int;
select @count=count(*) from Licenses where Licenses.CustomerId=@id
return @count;
end;
create function CountOfLicenses()
returns int
as
begin
declare @count int;
select @count=count(*) from Licenses
return @count;
end;

select dbo.CountOfLicenses()
select dbo.CountOfCustLic(1);
select dbo.udf_TotalCostOfPurchasedLicenses()

----triggers-----
CREATE TRIGGER Licenses_INSERT
ON Licenses
	AFTER INSERT
	AS
	INSERT INTO LicensesHistory
	(
	LicenseId,
	Title,
	PaymentDate,
	ExpiryDate,
	SoftwareId,
	CustomerId
	) 
	SELECT	i.Id, 
			i.Title,
			i.PaymentDate,
			i.ExpiryDate,
			i.SoftwareId,
			i.CustomerId
	FROM INSERTED i
	RETURN;


create trigger trg_InsertLicenses 
ON Licenses AFTER insert AS select * from Licenses

create trigger trg_InsertOwners 
ON Owners AFTER insert AS select * from Owners



--For app---
CREATE PROCEDURE usp_GetLicenses
AS
BEGIN
    SELECT l.Id
          ,l.Title
          ,l.PaymentDate
          ,l.ExpiryDate
          ,l.SoftwareId
		  ,l.CustomerId
    FROM [dbo].[Licenses] l
END

CREATE PROCEDURE usp_GetLicensesExpireNextMonth
AS
BEGIN
     SELECT l.Id
          ,l.Title
          ,l.PaymentDate
          ,l.ExpiryDate
          ,l.SoftwareId
		  ,l.CustomerId
    FROM [dbo].[Licenses] l
	WHERE DATEDIFF(month, getdate(), l.ExpiryDate) = 1
END

CREATE PROCEDURE [dbo].[usp_DeleteLicense]
    @id INT
AS
BEGIN
    DELETE [dbo].[Licenses]
    WHERE Id = @id
END

CREATE PROCEDURE usp_EditLicense
	@id INT,
	@title NVARCHAR(75),
	@expirydate DATETIME,
	@softwareId INT,
	@customerId INT
AS
BEGIN

    UPDATE s
    SET s.Title = @title,
		s.ExpiryDate = @expirydate,
		s.SoftwareId = @softwareId,
        s.CustomerId = @customerId
    FROM [dbo].[Licenses] s
    WHERE s.Id = @id

END