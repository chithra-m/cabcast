CREATE PROCEDURE [Rides].[usp_v1_RideBookingInfo_RequestCancel]
	@RideBookingInfoId UNIQUEIDENTIFIER,
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

	IF (@RideBookingInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Rides].[RideBookingInfo] WHERE [Id] LIKE @RideBookingInfoId AND [RowStatus] = 'A'))
	BEGIN
		RAISERROR('INVALID_PARAM_RIDE_NOT_EXIST', 16, 1);
	END

	IF (NOT EXISTS(SELECT TOP 1 1 FROM [Rides].[RideBookingInfo] WHERE [Id] LIKE @RideBookingInfoId AND [PassengerInfoId] LIKE @LoggedInUserId))
	BEGIN
		RAISERROR('INVALID_ACCESS_METHOD_NOT_ALLOWED', 16, 1);
	END

	DECLARE @IsConfirmed BIT = 0;

	IF(EXISTS(SELECT TOP 1 1 FROM [Rides].[RideBookingInfo] WHERE [Id] LIKE @RideBookingInfoId AND [BookingStatus] LIKE N'ACCEPTED'))
	BEGIN
		SET @IsConfirmed = 1;
	END

	UPDATE [Rides].[RideBookingInfo]
	SET	
		[BookingStatus] = N'CANCELLED',
		[ModifiedDate] = GETUTCDATE()
	WHERE [Id] = @RideBookingInfoId AND [RowStatus] = 'A';

	IF(@IsConfirmed = 1) 
	BEGIN
		DECLARE @RideInfoId UNIQUEIDENTIFIER;
		SELECT @RideInfoId = [RideInfoId] FROM [Rides].[RideBookingInfo] WHERE [Id] = @RideBookingInfoId;

		UPDATE [Rides].[RideInfo]
		SET	
			[AvailableSeats] = [AvailableSeats] + 1,
			[ModifiedDate] = GETUTCDATE()
		WHERE [Id] = @RideInfoId AND [RowStatus] = 'A';
	END	

	SET @Result = @RideBookingInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;