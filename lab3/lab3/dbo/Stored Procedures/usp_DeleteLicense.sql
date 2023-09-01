CREATE PROCEDURE [dbo].[usp_DeleteLicense]
    @id INT
AS
BEGIN
    DELETE [dbo].[Licenses]
    WHERE Id = @id
END