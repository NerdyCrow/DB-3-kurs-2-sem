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