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