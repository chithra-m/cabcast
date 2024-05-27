CREATE PROCEDURE [Location].[usp_v1_AreaInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER
	
AS

BEGIN TRY

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @AreaInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[Name] NVARCHAR(25) NOT NULL,
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL
    );

	INSERT INTO @AreaInfo(
		[Id], [Name], [SequenceId], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RowStatus]
	)
	SELECT	
		[AI].[Id],
		[AI].[Name],
		[AI].[SequenceId],
		[AI].[CreatedBy],
		[AI].[CreatedDate],
		[AI].[ModifiedBy],
		[AI].[ModifiedDate],
		[AI].[RowStatus]
	FROM [Location].[AreaInfo] [AI]
	WHERE [AI].[RowStatus] = 'A'
	ORDER BY [AI].[Name];

	SELECT * FROM @AreaInfo

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
