CREATE PROCEDURE [Rides].[usp_v1_RideInfo_Get]
	@PickupLocationInfoId UNIQUEIDENTIFIER,
	@VehicleType NVARCHAR(15),
	@RideDate DATE,
	@DepartureTime TIME(0) = NULL,
	@IsWomenDriverOnly BIT = 0,
	@LoggedInUserId UNIQUEIDENTIFIER

AS
DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY 

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	IF([Location].[udp_v1_ValidateLocationInfo](@PickupLocationInfoId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_PICKUP_LOCATION_INFO_ID', 16, 1);
	END

	DECLARE @RideInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[RideDate] DATE NOT NULL,
		[AvailableSeats] TINYINT NOT NULL,  
		[DriverRouteInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverRouteDriverInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverRouteRouteInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverRouteDepartureTime] TIME(0) NOT NULL,
		[DriverFirstName] NVARCHAR(50) NOT NULL,
		[DriverLastName] NVARCHAR(50) NOT NULL,
		[DriverGender] NVARCHAR(15) NOT NULL,
		[DriverGenderValue] NVARCHAR(15) NOT NULL,
		[DriverHomeLocationInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverHomeLocationInfoName] NVARCHAR(50) NOT NULL,
		[DriverHomeLocationInfoAddressLine] NVARCHAR(50) NOT NULL,
		[DriverHomeLocationInfoSubAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverHomeLocationInfoSubAreaInfoName] NVARCHAR(25) NOT NULL,
		[DriverHomeLocationInfoAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverHomeLocationInfoAreaInfoName] NVARCHAR(25) NOT NULL,
		[DriverHomeLocationInfoPincode] NVARCHAR(6) NOT NULL,   
		[DriverHomeLocationInfoDistanceFromOffice] TINYINT NOT NULL,
		[DriverHomeLocationInfoDurationByOffice] TIME(0) NOT NULL,
		[DriverVehicleInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DriverVehicleInfoVehicleType] NVARCHAR(15) NOT NULL,
		[DriverVehicleInfoVehicleTypeValue] NVARCHAR(15) NOT NULL,
		[DriverVehicleInfoIsSupportsAC] BIT NOT NULL DEFAULT 0,
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL 
    );

	INSERT INTO @RideInfo(
		[Id], [RideDate], [AvailableSeats], [DriverRouteInfoId], [DriverRouteDriverInfoId], [DriverRouteRouteInfoId], [DriverRouteDepartureTime], [DriverFirstName],
		[DriverLastName], [DriverGender], [DriverGenderValue], [DriverHomeLocationInfoId], [DriverHomeLocationInfoName], [DriverHomeLocationInfoAddressLine], 
		[DriverHomeLocationInfoSubAreaInfoId], [DriverHomeLocationInfoSubAreaInfoName], [DriverHomeLocationInfoAreaInfoId], [DriverHomeLocationInfoAreaInfoName], 
		[DriverHomeLocationInfoPincode], [DriverHomeLocationInfoDistanceFromOffice], [DriverHomeLocationInfoDurationByOffice], [DriverVehicleInfoId],
		[DriverVehicleInfoVehicleType], [DriverVehicleInfoVehicleTypeValue], [DriverVehicleInfoIsSupportsAC], [SequenceId], 
		[CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
    )
	SELECT	
	[RI].[Id],
	[RI].[RideDate],
	[RI].[AvailableSeats],
	[DRI].[Id],
	[DRI].[DriverInfoId],
	[DRI].[RouteInfoId],
	[DRI].[DepartureTime],
	[UI].[FirstName],
	[UI].[LastName],
	[UI].[Gender],
	[GI].[GenderValue],
	[DI].[HomeLocationInfoId],
	[LI].[Name],
	[LI].[AddressLine],
	[LI].[SubAreaInfoId],
	[SAI].[Name],
	[LI].[AreaInfoId],
	[AI].[Name],
	[LI].[Pincode],
	[LI].[DistanceFromOffice],
	[LI].[DurationByOffice],
	[DVI].[Id],
	[DVI].[VehicleType],
	[VTI].[VehicleTypeValue],
	[DVI].[IsSupportsAC],
	[RI].[SequenceId],
	[RI].[CreatedBy],
	[RI].[CreatedDate],
	[RI].[ModifiedBy],
	[RI].[ModifiedDate],
	[RI].[RowStatus]
	FROM [Rides].[RideInfo] [RI]
	LEFT JOIN [Setup].[DriverRouteInfo] [DRI] ON [RI].[DriverRouteInfoId] = [DRI].[Id]
	LEFT JOIN [Setup].[DriverInfo] [DI] ON [DRI].[Id] = [DI].[Id]
	LEFT JOIN [Setup].[DriverVehicleInfo] [DVI] ON [DI].[Id] = [DVI].[DriverInfoId]
	LEFT JOIN [Lookups].[VehicleTypeInfo] [VTI] ON [DVI].[VehicleType] = [VTI].[VehicleType]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [DI].[UserInfoId]
	LEFT JOIN [Lookups].[GenderInfo] [GI] ON [UI].[Gender] = [GI].[Gender]
	LEFT JOIN [Location].[SubAreaInfo] [SAI] ON [SAI].Id = [DI].[Id]
	LEFT JOIN [Location].[AreaInfo] [AI] ON [AI].Id = [DI].[Id]
	LEFT JOIN [Location].[LocationInfo] [LI] ON [DI].[HomeLocationInfoId] = [LI].[Id]
	WHERE [RI].[RideDate] = @RideDate	
	AND [RI].[RowStatus] = 'A' AND [DRI].[RowStatus] = 'A' 
	AND [DI].[RowStatus] = 'A' AND [DVI].[RowStatus] = 'A'
	AND [LI].[RowStatus] = 'A' AND [RI].[RowStatus] = 'A' 
	ORDER BY [DRI].[DepartureTime];

	IF(@IsWomenDriverOnly = 1)
	BEGIN
		DELETE FROM @RideInfo
		WHERE [DriverGender] != 'FEMALE'
	END

	IF(@VehicleType IS NOT NULL) -- TODO VALIDATION CHECK
	BEGIN
		DELETE FROM @RideInfo
		WHERE [DriverVehicleInfoVehicleType] != @VehicleType
	END

	SELECT * FROM @RideInfo

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
