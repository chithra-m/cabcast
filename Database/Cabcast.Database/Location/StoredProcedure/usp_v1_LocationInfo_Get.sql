CREATE PROCEDURE [Location].[usp_v1_LocationInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER
AS

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @LocationInfo TABLE(
		[Id] UNIQUEIDENTIFIER,
		[Name] NVARCHAR(50),
		[AddressLine] NVARCHAR(50),
		[SubAreaInfoId] UNIQUEIDENTIFIER,
		[SubAreaInfoName] NVARCHAR(25),
		[AreaInfoId] UNIQUEIDENTIFIER,
		[AreaInfoName] NVARCHAR(25),
		[Pincode] NVARCHAR(6),
		[DistanceFromOfficeInKM] TINYINT,
		[DurationByOffice] TIME(0),
		[SequenceId] INT, 
		[CreatedBy] UNIQUEIDENTIFIER,	
		[CreatedDate] DATETIME2,
		[ModifiedBy] UNIQUEIDENTIFIER,
		[ModifiedDate] DATETIME2,
		[RowStatus] NVARCHAR(1)
    );


	INSERT INTO @LocationInfo([Id], [Name], [AddressLine], [SubAreaInfoId], [SubAreaInfoName], [AreaInfoId], [AreaInfoName], [Pincode], [DistanceFromOfficeInKM], [DurationByOffice], [SequenceId], [CreatedBy], [CreatedDate],[ModifiedBy], [ModifiedDate], [RowStatus])
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
