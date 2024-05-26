CREATE PROCEDURE [Location].[usp_v1_LocationInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER
AS

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @LocationInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[Name] NVARCHAR(50) NOT NULL,
		[AddressLine] NVARCHAR(50) NOT NULL,
		[SubAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[AreaInfoId] UNIQUEIDENTIFIER NOT NULL,
		[Pincode] NVARCHAR(6) NOT NULL,
		[DistanceFromOfficeInKM] TINYINT NOT NULL,
		[DurationByOffice] TIME(0) NOT NULL,
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    );


	INSERT INTO @LocationInfo([Id], [Name], [AddressLine], [SubAreaInfoId], [AreaInfoId], [Pincode], [DistanceFromOfficeInKM], [DurationByOffice], [SequenceId], 
		[CreatedBy], [CreatedDate],[ModifiedBy], [ModifiedDate], [RowStatus])
	SELECT	
		[LI].[Id],
		[LI].[Name],
		[LI].[AddressLine],
		[LI].[SubAreaInfoId],
		[SAI].[Name],
		[LI].[AreaInfoId],
		[AI].[Name],
		[LI].[Pincode],
		[LI].[DistanceFromOfficeInKM],
		[LI].[DurationByOffice],
		[LI].[SequenceId],
		[LI].[CreatedBy],
		[LI].[CreatedDate],
		[LI].[ModifiedBy],
		[LI].[ModifiedDate],
		[LI].[RowStatus]
	FROM [Location].[LocationInfo] [LI]
	LEFT JOIN [Location].[SubAreaInfo] [SAI] ON [LI].[SubAreaInfoId] = [SAI].[Id]
	LEFT JOIN [Location].[AreaInfo] [AI] ON [LI].[AreaInfoId] = [AI].[Id]
	WHERE [LI].[RowStatus] = 'A' AND [LI].CreatedBy = @LoggedInUserId
	ORDER BY [LI].[Name];

	SELECT * FROM @LocationInfo

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
