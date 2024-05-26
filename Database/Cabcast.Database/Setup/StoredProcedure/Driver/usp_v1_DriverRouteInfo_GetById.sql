CREATE PROCEDURE [Setup].[usp_V1_DriverRouteInfo_GetById]
	@Id UNIQUEIDENTIFIER,
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
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[DriverInfoId] UNIQUEIDENTIFIER NOT NULL,
		[UserInfoId] UNIQUEIDENTIFIER NOT NULL,
		[AspNetUserId] NVARCHAR(450) NOT NULL,
		[UserName] [nvarchar](256) NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[LastName] NVARCHAR(50) NOT NULL,
		[PhoneNumber] [nvarchar](max) NULL,
		[Gender] NVARCHAR(15) NOT NULL,
		[GenderValue] NVARCHAR(15) NOT NULL,
		[ComcastEmployeeId] NVARCHAR(450) NOT NULL,
		[HomeLocationInfoId] UNIQUEIDENTIFIER NOT NULL,
		[DepartureTime] TIME(0) NOT NULL,
		[RouteInfoId] UNIQUEIDENTIFIER NOT NULL,
		[StartLocation] UNIQUEIDENTIFIER NOT NULL, -- EITHER START OR END MUST BE OFFICE LOCATION
		[EndLocation] UNIQUEIDENTIFIER NOT NULL,
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL
    );

	INSERT INTO @DriverRouteInfo(
		[Id], [DriverInfoId], [UserInfoId], [AspNetUserId], [UserName], [FirstName], [LastName], [PhoneNumber],
		[Gender], [GenderValue], [ComcastEmployeeId], [HomeLocationInfoId], [DepartureTime],
		[RouteInfoId], [StartLocation], [EndLocation], [Distance],[EstimatedDuration],
		[SequenceId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
    )
	SELECT	
		[DRI].[Id],
		[DRI].[DriverInfoId],
		[DI].[UserInfoId],
		[UI].[AspNetUserId],
		[UI].[ComcastEmployeeId],
		[ANU].[UserName],
		[UI].[FirstName],
		[UI].[LastName],
		[ANU].[PhoneNumber],
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
	LEFT JOIN [Auth].[AspNetUsers] [ANU] ON [UI].[Id] = [ANU].[Id]
	LEFT JOIN [Lookups].[GenderInfo] [GI] ON [UI].[Gender] = [GI].[Gender]
	LEFT JOIN [Account].[UserInfo] [MI] ON [UI].[ManagerId] = [MI].[Id]
	LEFT JOIN Setup.[RouteInfo] [RI] ON [DRI].[RouteInfoId] = [RI].[Id]
	WHERE [DRI].[Id] = @Id AND [DRI].[DriverInfoId] = @DriverInfoId AND [DRI].[RowStatus] = 'A' AND [DRI].CreatedBy = @LoggedInUserId

	SELECT * FROM @DriverRouteInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
