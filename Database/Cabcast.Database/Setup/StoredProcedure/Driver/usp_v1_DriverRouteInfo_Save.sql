CREATE PROCEDURE [Setup].[usp_v1_DriverRouteInfo_Save]
	@Id UNIQUEIDENTIFIER,
	@DriverInfoId UNIQUEIDENTIFIER,
	@RouteInfoId UNIQUEIDENTIFIER,
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

	IF (@DriverInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Setup].[DriverInfo] WHERE [Id] LIKE @DriverInfoId))
	BEGIN
		RAISERROR('INVALID_PARAM_DRIVER_INFO_ID_NOT_EXIST', 16, 1);
	END

	IF (@RouteInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Setup].[RouteInfo] WHERE [Id] LIKE @RouteInfoId))
	BEGIN
		RAISERROR('INVALID_PARAM_ROUTE_INFO_ID_NOT_EXIST', 16, 1);
	END

	DECLARE @DriverRouteInfoId UNIQUEIDENTIFIER = CASE WHEN (@Id IS NULL OR @Id = @EmptyGuid) THEN NEWID() ELSE @Id END;

    IF(@Id IS NULL OR @Id = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Setup].[DriverRouteInfo] WHERE [Id] = @Id))
	BEGIN
		INSERT INTO [Setup].[DriverRouteInfo]
		([Id], [DriverInfoId], [RouteInfoId], [DepartureTime], [CreatedBy])
		VALUES 
		(@DriverRouteInfoId, @DriverInfoId, @RouteInfoId, @DepartureTime, @LoggedInUserId);
	END
	ELSE
	BEGIN  
		UPDATE [Setup].[DriverRouteInfo]
		SET	
			[DriverInfoId] = @DriverInfoId,
			[RouteInfoId] = @RouteInfoId,
			[DepartureTime] = @DepartureTime,
			[ModifiedBy] = @LoggedInUserId,
			[ModifiedDate] = GETUTCDATE()
		WHERE [Id] = @DriverRouteInfoId AND [RowStatus] = 'A';
	END

	SET @Result = @DriverInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;