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