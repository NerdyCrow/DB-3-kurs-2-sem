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