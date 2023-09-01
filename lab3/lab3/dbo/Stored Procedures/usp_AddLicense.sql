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