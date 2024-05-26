CREATE PROCEDURE [Setup].[usp_V1_DriverVehicleInfo_Get]
	@LoggedInUserId UNIQUEIDENTIFIER

AS
DECLARE @EmptyGuid UNIQUEIDENTIFIER;
SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);

BEGIN TRY 

	IF([Auth].[udp_v1_ValidateLoggedInUser](@LoggedInUserId) = 0)
	BEGIN
		RAISERROR('INVALID_PARAM_LOGGED_IN_USER_ID', 16, 1);
	END

	DECLARE @DriverVehicleInfo TABLE(
		[Id] UNIQUEIDENTIFIER NOT NULL,
		[DriverInfoId] UNIQUEIDENTIFIER NOT NULL,
		[UserInfoId] UNIQUEIDENTIFIER NOT NULL,
		[AspNetUserId] NVARCHAR(450) NOT NULL,
		[ComcastEmployeeId]  NVARCHAR(450) NOT NULL,
		[VehicleType] NVARCHAR(15) NOT NULL,
		[VehicleTypeValue] NVARCHAR(15) NOT NULL,
		[VehicleNumber] NVARCHAR(10) NOT NULL,
		[VehicleColor] NVARCHAR(15) NOT NULL,
		[MaximumSeats] TINYINT NOT NULL,
		[SequenceId] INT NOT NULL IDENTITY, 
		[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
		[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
		[ModifiedBy] UNIQUEIDENTIFIER NULL,
		[ModifiedDate] DATETIME2 NULL,
		[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    );

	INSERT INTO @DriverVehicleInfo(
		[Id], [DriverInfoId], [UserInfoId], [AspNetUserId], [ComcastEmployeeId], [VehicleType], 
		[VehicleTypeValue], [VehicleNumber], [VehicleColor], [MaximumSeats], [SequenceId], 
		[CreatedBy], [CreatedDate],[ModifiedBy], [ModifiedDate], [RowStatus] 
    )
	SELECT	
		[DVI].[Id],
		[DVI].[DriverInfoId],
		[DI].[UserInfoId],
		[UI].[AspNetUserId],
		[UI].[ComcastEmployeeId],
		[DVI].[VehicleType],
		[VTI].[VehicleTypeValue],
		[DVI].[VehicleNumber],
		[DVI].[VehicleColor],
		[DVI].[MaximumSeats],
		[DVI].[SequenceId],
		[DVI].[CreatedBy],
		[DVI].[CreatedDate],
		[DVI].[ModifiedBy],
		[DVI].[ModifiedDate],
		[DVI].[RowStatus] 
	FROM [Setup].[DriverVehicleInfo] [DVI]
	LEFT JOIN [Setup].[DriverInfo] [DI] ON [DVI].[DriverInfoId] = [DI].[Id]
	LEFT JOIN [Account].[UserInfo] [UI] ON [UI].[Id] = [DI].[UserInfoId]
	LEFT JOIN [Auth].[AspNetUsers] [ANU] ON [UI].[Id] = [ANU].[Id]
	LEFT JOIN [Lookups].[VehicleTypeInfo] [VTI] ON [DVI].[VehicleType] = [VTI].[VehicleType]
	WHERE [DVI].[RowStatus] = 'A' AND [DVI].CreatedBy = @LoggedInUserId
	ORDER BY [UI].[FirstName];

	SELECT * FROM @DriverVehicleInfo;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()   
     
	-- Raise Exception  
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;
