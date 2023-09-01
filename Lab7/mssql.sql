go
use SoftLicenseManagement
go

--				Task 1
create table Report (
id INTEGER primary key identity(1,1),
xml_column XML
);

CREATE PROCEDURE GenerateXML
AS
BEGIN
    SELECT 
        s.Name AS SoftwareName, 
        s.Version AS SoftwareVersion, 
        s.Price AS SoftwarePrice,
        o.ContactId AS OwnerContactId,
        c.ContactId AS CustomerContactId,
        l.Title AS LicenseTitle,
        l.PaymentDate AS LicensePaymentDate,
        l.ExpiryDate AS LicenseExpiryDate,
        lh.Title AS LicenseHistoryTitle,
        lh.PaymentDate AS LicenseHistoryPaymentDate,
        lh.ExpiryDate AS LicenseHistoryExpiryDate,
        GETDATE() AS Timestamp
    FROM 
        Software s
        INNER JOIN Owners o ON s.OwnerId = o.Id
        INNER JOIN Licenses l ON s.Id = l.SoftwareId
        INNER JOIN Customers c ON l.CustomerId = c.Id
        LEFT JOIN LicensesHistory lh ON l.Id = lh.LicenseId
    FOR XML AUTO, ROOT('Data')
END

EXEC GenerateXML

CREATE or alter PROCEDURE InsertReportXML
AS
BEGIN
    DECLARE @xml XML

   set @xml =  (SELECT 
        s.Name AS SoftwareName, 
        s.Version AS SoftwareVersion, 
        s.Price AS SoftwarePrice,
        o.ContactId AS OwnerContactId,
        c.ContactId AS CustomerContactId,
        l.Title AS LicenseTitle,
        l.PaymentDate AS LicensePaymentDate,
        l.ExpiryDate AS LicenseExpiryDate,
        lh.Title AS LicenseHistoryTitle,
        lh.PaymentDate AS LicenseHistoryPaymentDate,
        lh.ExpiryDate AS LicenseHistoryExpiryDate,
        GETDATE() AS Timestamp
    FROM 
        Software s
        INNER JOIN Owners o ON s.OwnerId = o.Id
        INNER JOIN Licenses l ON s.Id = l.SoftwareId
        INNER JOIN Customers c ON l.CustomerId = c.Id
        LEFT JOIN LicensesHistory lh ON l.Id = lh.LicenseId
    FOR XML auto )

    INSERT INTO Report (xml_column) VALUES (@xml)
END

exec InsertReportXML
 select * from Report

 --task 4
 create primary xml index XMLIndex on Report(xml_column)
create xml index XMLIndex_sec on Report(xml_column)
using xml index XMLIndex for path

--task 5 

go
create or alter procedure SelectData @query nvarchar(max)
as
begin
  
    execute('select xml_column.query('''+@query+''') as [xml_column] from Report')
end

execute SelectData '/s/o';