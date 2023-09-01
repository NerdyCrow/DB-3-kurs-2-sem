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