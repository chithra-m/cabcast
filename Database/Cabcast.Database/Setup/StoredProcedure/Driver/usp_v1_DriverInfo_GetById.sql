CREATE PROCEDURE [Setup].[usp_v1_DriverInfo_GetById]
	@Id UNIQUEIDENTIFIER,
	@LoggedInUserId UNIQUEIDENTIFIER

AS
DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY 

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @DriverInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[UserInfoId] UNIQUEIDENTIFIER NOT NULL,
		[AspNetUserId] NVARCHAR(450) NOT NULL,
		[ComcastEmployeeId]  NVARCHAR(450) NOT NULL,
		[UserName] [nvarchar](256) NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[LastName] NVARCHAR(50) NOT NULL,
		[Email] [nvarchar](256) NULL,
		[PhoneNumber] [nvarchar](max) NULL,
		[Gender] NVARCHAR(15) NOT NULL,
		[GenderValue] NVARCHAR(15) NOT NULL,
		[LicenseNumber] NVARCHAR(20) UNIQUE NULL,
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
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL 
    );

	INSERT INTO @DriverInfo(
		[Id], [UserInfoId], [AspNetUserId], [ComcastEmployeeId], [UserName], [FirstName], [LastName], [Email], [PhoneNumber],
		[Gender], [GenderValue], [LicenseNumber], [ManagerId], [ManagerFirstName], [ManagerLastName],
		[HomeLocationInfoId], [HomeLocationInfoName], [HomeLocationInfoAddressLine],[HomeLocationInfoSubAreaInfoId],
		[HomeLocationInfoSubAreaInfoName], [HomeLocationInfoAreaInfoId], [HomeLocationInfoAreaInfoName],[HomeLocationInfoPincode],    
		[SequenceId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
    )
	SELECT	
	[DI].[Id],
	[DI].[UserInfoId],
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
	[DI].[HomeLocationInfoId],
	[LI].[Name],
	[LI].[AddressLine],
	[LI].[SubAreaInfoId],
	[SAI].[Name],
	[LI].[AreaInfoId],
	[AI].[Name],
	[LI].[Pincode],
	[DI].[SequenceId],
	[DI].[CreatedBy],
	[DI].[CreatedDate],
	[DI].[ModifiedBy],
	[DI].[ModifiedDate],
	[DI].[RowStatus]
	FROM [Setup].[DriverInfo] [DI]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [DI].[UserInfoId]
	LEFT JOIN [Auth].[AspNetUsers] [ANU] ON [UI].[Id] = [ANU].[Id]
	LEFT JOIN [Lookups].[GenderInfo] [GI] ON [UI].[Gender] = [GI].[Gender]
	LEFT JOIN [Account].[UserInfo] [MI] ON [UI].[ManagerId] = [MI].[Id]
	LEFT JOIN [Location].[SubAreaInfo] [SAI] ON [SAI].Id = [DI].[Id]
	LEFT JOIN [Location].[AreaInfo] [AI] ON [AI].Id = [DI].[Id]
	LEFT JOIN [Location].[LocationInfo] [LI] ON [DI].[HomeLocationInfoId] = [LI].[Id]
	WHERE [DI].[Id] = @Id AND [DI].[RowStatus] = 'A' AND [DI].CreatedBy = @LoggedInUserId;

	SELECT * FROM @DriverInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;