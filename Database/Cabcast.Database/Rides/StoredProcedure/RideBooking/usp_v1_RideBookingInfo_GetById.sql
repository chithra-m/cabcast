CREATE PROCEDURE [Setup].[usp_v1_RideBookingInfo_GetById]
	@PassengerId UNIQUEIDENTIFIER,
	@LoggedInUserId UNIQUEIDENTIFIER

AS
DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY 

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @RideBookingInfo TABLE(
		[Id] UNIQUEIDENTIFIER, 
		[PickupRoutePointInfoId] UNIQUEIDENTIFIER,
		[StartLocation] UNIQUEIDENTIFIER, 
		[EndLocation] UNIQUEIDENTIFIER, 
		[DriverInfoId] UNIQUEIDENTIFIER,
		[DriverFirstName] NVARCHAR(50),
		[DriverLastName] NVARCHAR(50),
		[DriverPhoneNumber] NVARCHAR(10),
		[DriverEmail] NVARCHAR(256),
		[DriverVehicleInfoId] UNIQUEIDENTIFIER,
		[DriverVehicleInfoVehicleNumber] NVARCHAR(10),
		[DriverVehicleInfoVehicleType] NVARCHAR(15),
		[DriverVehicleInfoVehicleTypeValue] NVARCHAR(15),
		[DriverVehicleInfoIsSupportsAC] BIT,
		[RideInfoId] UNIQUEIDENTIFIER,
		[RideInfoIsWomenOnly] BIT,
		[Ri deDate] DATE,
		[StartTime] TIME(0),
		[EndTime] TIME(0),
		[BookingDate] DATETIME2,
		[BookingStatus] NVARCHAR(15),
		[BookingStatusValue] NVARCHAR(15),
		[SequenceId] INT, 
		[CreatedBy] UNIQUEIDENTIFIER, 
		[CreatedDate] DATETIME2, 
		[ModifiedBy] UNIQUEIDENTIFIER,
		[ModifiedDate] DATETIME2, 
		[RowStatus] NVARCHAR
    );

	INSERT INTO @RideBookingInfo(
		[Id], [PickupRoutePointInfoId], [StartLocation], [EndLocation], [DriverInfoId], [DriverFirstName], [DriverLastName], [DriverPhoneNumber],
		[DriverEmail], [DriverVehicleInfoId], [DriverVehicleInfoVehicleNumber], [DriverVehicleInfoVehicleType],
		[DriverVehicleInfoVehicleTypeValue], [DriverVehicleInfoIsSupportsAC], [RideInfoId], [RideInfoIsWomenOnly], [RideDate],
		[StartTime], [EndTime], [BookingDate], [BookingStatus], [BookingStatusValue], [SequenceId], [CreatedBy],
		[CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
    )
	SELECT	
	[RBI].[Id],  
	[RBI].[PickupRoutePointInfoId], 
	[ROI].[StartLocation], 
	[ROI].[EndLocation], 
	[DI].[Id], 
	[UI].[FirstName], 
	[UI].[LastName], 
	[UI].[PhoneNumber], 
	[UI].[Email], 
	[DVI].[Id],
	[DVI].[VehicleNumber], 
	[DVI].[VehicleType], 
	[VTI].[VehicleTypeValue], 
	[DVI].[IsSupportsAC], 
	[RI].[Id],
	[RI].[IsWomenOnly], 
	[RI].[RideDate], 
	[RI].[StartTime], 
	[RI].[EndTime], 
	[RBI].[BookingDate], 
	[RBI].[BookingStatus], 
	[BSI].[BookingStatusValue],
	[RBI].[SequenceId], 
	[RBI].[CreatedBy], 
	[RBI].[CreatedDate], 
	[RBI].[ModifiedBy], 
	[RBI].[ModifiedDate], 
	[RBI].[RowStatus]
	FROM [Setup].[RideBookingInfo] [RBI]
	LEFT JOIN  [Rides].[RideInfo] [RI] ON [RBI].[RideInfoId] = [RI].[Id]
	LEFT JOIN [Setup].[DriverRouteInfo] [DRI] ON [RI].[DriverRouteInfoId] = [DRI].[DriverInfoId]
	LEFT JOIN [Setup].[DriverInfo] [DI] ON [DRI].[DriverInfoId] = [DI].[Id]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [DI].[UserInfoId]
	LEFT JOIN [Setup].[DriverVehicleInfo] [DVI] ON [DVI].[Id] = [DI].[DriverInfoId]  
	LEFT JOIN [Lookups].[VehicleTypeInfo] [VTI] ON [VTI].[Id] = [DVI].[VehicleType]
	LEFT JOIN [Account].[UserInfo] [MI] ON [UI].[ManagerId] = [MI].[Id]
	LEFT JOIN  [Setup].[RouteInfo] [ROI] ON [ROI].[Id] = [DRI].[RouteInfoId]
	LEFT JOIN [Lookups].[BookingStatusInfo] [BSI] ON [RBI].[BookingStatus] = [BSI].[BookingStatus]
	WHERE [RBI].[PassengerInfoId] = @PassengerId AND [RBI].[RowStatus] = 'A' AND [RBI].CreatedBy = @LoggedInUserId;

	SELECT * FROM @RideBookingInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;