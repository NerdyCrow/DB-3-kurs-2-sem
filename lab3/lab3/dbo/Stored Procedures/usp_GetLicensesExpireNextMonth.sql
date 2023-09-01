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
