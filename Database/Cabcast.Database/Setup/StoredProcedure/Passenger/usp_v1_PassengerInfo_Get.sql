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
		[UserInfoId] UNIQUEIDENTIFIER,
		[AspNetUserId] NVARCHAR(36),
		[ComcastEmployeeId] NVARCHAR(450),
		[FirstName] NVARCHAR(50),
		[LastName] NVARCHAR(50),
		[Email] NVARCHAR(256),
		[PhoneNumber] NVARCHAR(MAX),
		[Gender] NVARCHAR(15),
		[GenderValue] NVARCHAR(15),
		[ManagerId] UNIQUEIDENTIFIER,
		[ManagerFirstName] NVARCHAR(50),
		[ManagerLastName] NVARCHAR(50),
		[HomeLocationInfoId] UNIQUEIDENTIFIER,
		[HomeLocationInfoName] NVARCHAR(50),
		[HomeLocationInfoAddressLine] NVARCHAR(50),
		[HomeLocationInfoSubAreaInfoId] UNIQUEIDENTIFIER,
		[HomeLocationInfoSubAreaInfoName] NVARCHAR(25),
		[HomeLocationInfoAreaInfoId] UNIQUEIDENTIFIER,
		[HomeLocationInfoAreaInfoName] NVARCHAR(25),
		[HomeLocationInfoPincode] NVARCHAR(6),
		[DepartureTime] TIME(0),
		[SequenceId] INT,
		[CreatedBy] UNIQUEIDENTIFIER,
		[CreatedDate] DATETIME2,
		[ModifiedBy] UNIQUEIDENTIFIER,
		[ModifiedDate] DATETIME2,
		[RowStatus] NVARCHAR(1)
	);

	INSERT INTO @PassengerInfo([Id], [UserInfoId], [AspNetUserId], [ComcastEmployeeId], [Email], [PhoneNumber]
	, [FirstName], [LastName], [Gender], [GenderValue], [ManagerId], [ManagerFirstName], [ManagerLastName]
	, [HomeLocationInfoId], [HomeLocationInfoName], [HomeLocationInfoAddressLine], [HomeLocationInfoSubAreaInfoId], [HomeLocationInfoSubAreaInfoName]
	, [HomeLocationInfoAreaInfoId], [HomeLocationInfoAreaInfoName], [HomeLocationInfoPincode], [DepartureTime], [SequenceId], [CreatedBy], [CreatedDate]
	, [ModifiedBy], [ModifiedDate], [RowStatus])
	SELECT	
	[PI].[Id], 
	[PI].[UserInfoId],
	[UI].[AspNetUserId],
	[UI].[ComcastEmployeeId],
	[UI].[FirstName],
	[UI].[LastName],
	[UI].[Email],
	[UI].[PhoneNumber],
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
