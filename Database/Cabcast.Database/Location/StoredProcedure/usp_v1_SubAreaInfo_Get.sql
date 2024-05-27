CREATE PROCEDURE [Location].[usp_v1_SubAreaInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER
	
AS

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @SubAreaInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
        [AreaInfoId] UNIQUEIDENTIFIER NOT NULL,
        [AreaInfoName] NVARCHAR(25) NOT NULL,
        [Name] NVARCHAR(25) NOT NULL,
        [SequenceId] INT NOT NULL IDENTITY, 
        [CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
        [CreatedDate] DATETIME2 NOT NULL,
        [ModifiedBy] UNIQUEIDENTIFIER NULL,
        [ModifiedDate] DATETIME2 NULL,
        [RowStatus] NVARCHAR(1) NOT NULL
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
