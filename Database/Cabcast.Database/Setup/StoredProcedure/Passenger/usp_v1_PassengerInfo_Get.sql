CREATE PROCEDURE [Setup].[usp_V1_PassengerInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER

AS
DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY 

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @PassengerInfo TABLE(
		[Id] UNIQUEIDENTIFIER,
		[UserInfoId] UNIQUEIDENTIFIER NOT NULL,
		[AspNetUserId] NVARCHAR(450) NOT NULL,
		[ComcastEmployeeId] NVARCHAR(450) NOT NULL,
		[UserName] [nvarchar](256) NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[LastName] NVARCHAR(50) NOT NULL,
		[Email] [nvarchar](256) NULL,
		[PhoneNumber] [nvarchar](max) NULL,
		[Gender] NVARCHAR(15) NOT NULL,
		[GenderValue] NVARCHAR(15) NOT NULL,
		[ManagerId] UNIQUEIDENTIFIER NOT NULL,
		[ManagerFirstName] NVARCHAR(50) NOT NULL,
		[ManagerLastName] NVARCHAR(50) NOT NULL,
		[HomeLocationInfoId] UNIQUEIDENTIFIER NOT NULL,
		[HomeLocationInfoName] NVARCHAR(50) NOT NULL,
		[HomeLocationInfoAddressLine] NVARCHAR(50) NOT NULL,
		[HomeLocationInfoSubAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[HomeLocationInfoSubAreaInfoName] NVARCHAR(25) NOT NULL,
		[HomeLocationInfoAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[HomeLocationInfoAreaInfoName] NVARCHAR(25) NOT NULL,
		[HomeLocationInfoPincode] NVARCHAR(6) NOT NULL,
		[DepartureTime] TIME(0) NOT NULL,
		[SequenceId] INT,
		[CreatedBy] UNIQUEIDENTIFIER,
		[CreatedDate] DATETIME2,
		[ModifiedBy] UNIQUEIDENTIFIER,
		[ModifiedDate] DATETIME2,
		[RowStatus] NVARCHAR(1)
	);

	INSERT INTO @PassengerInfo([Id], [UserInfoId], [AspNetUserId], [ComcastEmployeeId], [UserName], [Email], [PhoneNumber]
	, [FirstName], [LastName], [Gender], [GenderValue], [ManagerId], [ManagerFirstName], [ManagerLastName]
	, [HomeLocationInfoId], [HomeLocationInfoName], [HomeLocationInfoAddressLine], [HomeLocationInfoSubAreaInfoId], [HomeLocationInfoSubAreaInfoName]
	, [HomeLocationInfoAreaInfoId], [HomeLocationInfoAreaInfoName], [HomeLocationInfoPincode], [DepartureTime], [SequenceId], [CreatedBy], [CreatedDate]
	, [ModifiedBy], [ModifiedDate], [RowStatus])
	SELECT	
	[PI].[Id], 
	[PI].[UserInfoId],
	[UI].[AspNetUserId],
	[UI].[ComcastEmployeeId],
	[ANU].[UserName],
	[UI].[FirstName],
	[UI].[LastName],
	[ANU].[Email],
	[ANU].[PhoneNumber],
	[UI].[Gender],
	[GI].[GenderValue],
	[UI].[ManagerId],
	[MI].[FirstName],
	[MI].[LastName],
	[PI].[HomeLocationInfoId],
	[LI].[Name],
	[LI].[AddressLine],
	[LI].[SubAreaInfoId],
	[SAI].[Name],
	[LI].[AreaInfoId],
	[AI].[Name],
	[LI].[Pincode],
	[PI].[DepartureTime],
	[PI].[SequenceId],
	[PI].[CreatedBy],
	[PI].[CreatedDate],
	[PI].[ModifiedBy],
	[PI].[ModifiedDate],
	[PI].[RowStatus]
	FROM [Setup].[PassengerInfo] [PI]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [PI].[UserInfoId]
	LEFT JOIN [Auth].[AspNetUsers] [ANU] ON [UI].[Id] = [ANU].[Id]
	LEFT JOIN [Lookups].[GenderInfo] [GI] ON [UI].[Gender] = [GI].[Gender]
	LEFT JOIN [Account].[UserInfo] [MI] ON [UI].[ManagerId] = [MI].[Id]
	LEFT JOIN [Location].[SubAreaInfo] [SAI] ON [SAI].Id = [MI].[Id]
	LEFT JOIN [Location].[AreaInfo] [AI] ON [AI].Id = [MI].[Id]
	LEFT JOIN [Location].[LocationInfo] [LI] ON [PI].[HomeLocationInfoId] = [LI].[Id]
	WHERE PI.[RowStatus] = 'A' AND PI.CreatedBy = @LoggedInUserId
	ORDER BY [UI].[FirstName];

	SELECT * FROM @PassengerInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
