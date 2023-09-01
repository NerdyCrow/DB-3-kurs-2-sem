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