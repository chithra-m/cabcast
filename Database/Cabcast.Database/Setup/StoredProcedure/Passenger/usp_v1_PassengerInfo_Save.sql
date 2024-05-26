CREATE PROCEDURE [Setup].[usp_v1_PassengerInfo_Save]
	@Id UNIQUEIDENTIFIER,
	@UserInfoId UNIQUEIDENTIFIER,
	@HomeLocationInfoId UNIQUEIDENTIFIER,
	@DepartureTime TIME(0),
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

	IF (@UserInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Account].[UserInfo] WHERE [Id] LIKE @UserInfoId))
	BEGIN
		RAISERROR('INVALID_PARAM_USER_INFO_ID_NOT_EXIST', 16, 1);
	END

	IF (@HomeLocationInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Location].[LocationInfo] WHERE [Id] LIKE @HomeLocationInfoId))
	BEGIN
		RAISERROR('INVALID_PARAM_USER_INFO_ID_NOT_EXIST', 16, 1);
	END

	DECLARE @PassengerInfoId UNIQUEIDENTIFIER = CASE WHEN (@Id IS NULL OR @Id = @EmptyGuid) THEN NEWID() ELSE @Id END;

    IF(@Id IS NULL OR @Id = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Account].[UserInfo] WHERE [Id] = @Id))
	BEGIN
		INSERT INTO [Setup].[PassengerInfo]
		([Id], [UserInfoId], [DepartureTime], [HomeLocationInfoId], [CreatedBy])
		VALUES 
		(@PassengerInfoId, @UserInfoId, @DepartureTime, @HomeLocationInfoId, @LoggedInUserId);
	END
	ELSE
	BEGIN  
		UPDATE [Setup].[PassengerInfo]
		SET	
			[UserInfoId] = @UserInfoId,
			[DepartureTime] = @DepartureTime,
			[HomeLocationInfoId] = @HomeLocationInfoId,
			[ModifiedBy] = @LoggedInUserId,
			[ModifiedDate] = GETUTCDATE()
		WHERE [Id] = @PassengerInfoId AND [RowStatus] = 'A';
	END

	SET @Result = @UserInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;