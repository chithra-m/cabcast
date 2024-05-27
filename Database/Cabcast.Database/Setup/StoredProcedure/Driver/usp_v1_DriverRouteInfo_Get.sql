CREATE PROCEDURE [Setup].[usp_V1_DriverRouteInfo_Get]
	@DriverInfoId UNIQUEIDENTIFIER,
	@LoggedInUserId UNIQUEIDENTIFIER

AS
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

	DECLARE @DriverRouteInfo TABLE(
		[Id] UNIQUEIDENTIFIER,
		[DriverInfoId] UNIQUEIDENTIFIER,
		[UserInfoId] UNIQUEIDENTIFIER,
		[AspNetUserId] NVARCHAR(36),
		[ComcastEmployeeId] NVARCHAR(450),
		[FirstName] NVARCHAR(50),
		[LastName] NVARCHAR(50),
		[PhoneNumber] NVARCHAR(MAX),
		[Gender] NVARCHAR(15),
		[GenderValue] NVARCHAR(15),
		[HomeLocationInfoId] UNIQUEIDENTIFIER,
		[DepartureTime] TIME(0),
		[RouteInfoId] UNIQUEIDENTIFIER,
		[StartLocation] UNIQUEIDENTIFIER, -- EITHER START OR END MUST BE OFFICE LOCATION
		[EndLocation] UNIQUEIDENTIFIER,
		[SequenceId] INT, 
		[CreatedBy] UNIQUEIDENTIFIER,	
		[CreatedDate] DATETIME2,
		[ModifiedBy] UNIQUEIDENTIFIER,
		[ModifiedDate] DATETIME2,
		[RowStatus] NVARCHAR(1)
    );

	INSERT INTO @DriverRouteInfo(
		[Id], [DriverInfoId], [UserInfoId], [AspNetUserId], [ComcastEmployeeId], [FirstName], [LastName], [PhoneNumber],
		[Gender], [GenderValue], [HomeLocationInfoId], [DepartureTime], [RouteInfoId], [StartLocation], [EndLocation], [SequenceId], 
		[CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
    )
	SELECT	
		[DRI].[Id],
		[DRI].[DriverInfoId],
		[DI].[UserInfoId],
		[UI].[AspNetUserId],
		[UI].[ComcastEmployeeId],
		[UI].[FirstName],
		[UI].[LastName],
		[UI].[PhoneNumber],
		[UI].[Gender],
		[GI].[GenderValue],
		[DI].[HomeLocationInfoId],
		[DRI].[DepartureTime],
		[DRI].[RouteInfoId],
		[RI].[StartLocation],
		[RI].[EndLocation],
		[DRI].[SequenceId],
		[DRI].[CreatedBy],
		[DRI].[CreatedDate],
		[DRI].[ModifiedBy],
		[DRI].[ModifiedDate],
		[DRI].[RowStatus]
	FROM [Setup].[DriverRouteInfo] [DRI]
	LEFT JOIN [Setup].[DriverInfo] [DI] ON [DRI].[DriverInfoId] = [DI].[Id]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [DI].[UserInfoId]
	LEFT JOIN [Lookups].[GenderInfo] [GI] ON [UI].[Gender] = [GI].[Gender]
	LEFT JOIN [Account].[UserInfo] [MI] ON [UI].[ManagerId] = [MI].[Id]
	LEFT JOIN Setup.[RouteInfo] [RI] ON [DRI].[RouteInfoId] = [RI].[Id]
	WHERE [DRI].[DriverInfoId] = @DriverInfoId AND [DRI].[RowStatus] = 'A' AND [DRI].CreatedBy = @LoggedInUserId
	ORDER BY [UI].[FirstName];

	SELECT * FROM @DriverRouteInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
