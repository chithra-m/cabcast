CREATE PROCEDURE [Auth].[usp_v1_AspNetUsers_Save]
	@UserName NVARCHAR(256),
	@PasswordHash NVARCHAR(MAX),
	@SecurityStamp NVARCHAR(MAX),
	@ConcurrencyStamp NVARCHAR(MAX),
	@PhoneNumber NVARCHAR(10),
	@LoggedInUserId UNIQUEIDENTIFIER,
	@Result UNIQUEIDENTIFIER OUTPUT
AS
DECLARE @Response INT = 0;

DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	IF (@UserName IS NULL OR LEN(@UserName) <= 0)
	BEGIN
		RAISERROR('INVALID_PARAM_USER_NAME', 16, 1);
	END

	DECLARE @AspNetUsersId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [Auth].[AspNetUsers] 
		([Id], [UserName], [NormalizedUserName], [PasswordHash], [SecurityStamp], [ConcurrencyStamp])
	VALUES 
		(@AspNetUsersId, @UserName, UPPER(@UserName), @PasswordHash, @SecurityStamp, @ConcurrencyStamp);

	SET @Result = @AspNetUsersId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;