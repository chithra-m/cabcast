CREATE PROCEDURE [Account].[usp_v1_UserInfo_Save]
	@Id UNIQUEIDENTIFIER,
	@AspNetUserId NVARCHAR(450),
	@ComcastEmployeeId NVARCHAR(450),
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Gender NVARCHAR(15),
	@ManagerId UNIQUEIDENTIFIER NULL,
	@IsRider BIT = 0,
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

	IF (@AspNetUserId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Auth].[AspNetUsers] WHERE [Id] LIKE @AspNetUserId))
	BEGIN
		RAISERROR('INVALID_PARAM_ASP_NET_USER_ID_NOT_EXIST', 16, 1);
	END

	IF (@ComcastEmployeeId IS NULL OR LEN(@ComcastEmployeeId) <= 0)
	BEGIN
		RAISERROR('INVALID_PARAM_COMCAST_EMPLOYEE_ID', 16, 1);
	END

	IF (LEN(@FirstName) <= 0)
	BEGIN
		RAISERROR('INVALID_PARAM_FIRST_NAME_MIN_LENGTH_ERROR', 16, 1);
	END

	IF (LEN(@LastName) <= 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LAST_NAME_MIN_LENGTH_ERROR', 16, 1);
	END

	DECLARE @UserInfoId UNIQUEIDENTIFIER = CASE WHEN (@Id IS NULL OR @Id = @EmptyGuid) THEN NEWID() ELSE @Id END;

    IF(@Id IS NULL OR @Id = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Account].[UserInfo] WHERE [Id] = @Id))
	BEGIN
		INSERT INTO [Account].[UserInfo] 
		([Id], [AspNetUserId], [ComcastEmployeeId], [FirstName], [LastName], [Gender], [ManagerId], [IsRider], [CreatedBy])
		VALUES 
		(@UserInfoId, @AspNetUserId, @ComcastEmployeeId, @FirstName, @LastName, @Gender, @ManagerId, @IsRider, @LoggedInUserId);
	END
	ELSE
	BEGIN  
		UPDATE [Account].[UserInfo]
		SET	
			[AspNetUserId] = @AspNetUserId,
			[ComcastEmployeeId] = @ComcastEmployeeId,
			[FirstName] = @FirstName,
			[LastName] = @LastName,
			[Gender] = @Gender,
			[ManagerId] = @ManagerId,
			[IsRider] = @IsRider,
			[ModifiedBy] = @LoggedInUserId,
			[ModifiedDate] = GETUTCDATE()
		WHERE [Id] = @UserInfoId AND [RowStatus] = 'A';
	END

	SET @Result = @UserInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;