CREATE PROCEDURE [Location].[usp_v1_SubAreaInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER
	
AS

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @SubAreaInfo TABLE(
		[Id] UNIQUEIDENTIFIER,
        [AreaInfoId] UNIQUEIDENTIFIER,
        [AreaInfoName] NVARCHAR(25),
        [Name] NVARCHAR(25),
        [SequenceId] INT,
        [CreatedBy] UNIQUEIDENTIFIER,
        [CreatedDate] DATETIME2,
        [ModifiedBy] UNIQUEIDENTIFIER,
        [ModifiedDate] DATETIME2,
        [RowStatus] NVARCHAR(1)
    );

	INSERT INTO @SubAreaInfo(
		[Id], [AreaInfoId], [AreaInfoName], [Name], [SequenceId], [CreatedBy], [CreatedDate],
        [ModifiedBy], [ModifiedDate], [RowStatus]
	)
	SELECT	
		[SAI].[Id],
        [SAI].[AreaInfoId],
        [AI].[Name],
        [SAI].[Name],
        [SAI].[SequenceId],
        [SAI].[CreatedBy],
        [SAI].[CreatedDate],
        [SAI].[ModifiedBy],
        [SAI].[ModifiedDate],
        [SAI].[RowStatus]
	FROM [Location].[SubAreaInfo] [SAI]
    LEFT JOIN [Location].[AreaInfo] [AI] ON [SAI].[AreaInfoId] = [AI].[Id]
	WHERE [SAI].[RowStatus] = 'A'
	ORDER BY [SAI].[Name];

	SELECT * FROM @SubAreaInfo

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
