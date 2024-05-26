CREATE PROCEDURE [Rides].[usp_v1_RideBookingInfo_RequestSave]
	@RideInfoId UNIQUEIDENTIFIER,
	@PickupRoutePointInfoId UNIQUEIDENTIFIER,
	@BookingDate DATETIME2,
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

	IF (@RideInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Rides].[RideInfo] WHERE [Id] LIKE @RideInfoId AND [RowStatus] = 'A'))
	BEGIN
		RAISERROR('INVALID_PARAM_RIDE_NOT_EXIST', 16, 1);
	END

	IF (@LoggedInUserId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Setup].[PassengerInfo] WHERE [Id] LIKE @LoggedInUserId AND [RowStatus] = 'A'))
	BEGIN
		RAISERROR('INVALID_PARAM_PASSENGER_NOT_EXIST', 16, 1);
	END

	IF (@PickupRoutePointInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Location].[LocationInfo] WHERE [Id] LIKE @PickupRoutePointInfoId AND [RowStatus] = 'A'))
	BEGIN
		RAISERROR('INVALID_PARAM_PICKUP_ROUTE_POINT_NOT_EXIST', 16, 1);
	END

	DECLARE @RideBookingInfoId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [Rides].[RideBookingInfo]
	([Id], [RideInfoId], [PassengerInfoId], [PickupRoutePointInfoId], [BookingDate], [CreatedBy])
	VALUES 
	(@RideBookingInfoId, @RideInfoId, @LoggedInUserId, @PickupRoutePointInfoId, @BookingDate, @LoggedInUserId);

	SET @Result = @RideBookingInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;