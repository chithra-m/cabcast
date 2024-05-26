CREATE PROCEDURE [Setup].[usp_v1_DriverVehicleInfo_Save]
	@Id UNIQUEIDENTIFIER,
	@DriverInfoId UNIQUEIDENTIFIER,
	@VehicleType NVARCHAR(15),
	@VehicleNumber NVARCHAR(10),
	@VehicleColor NVARCHAR(15),
	@MaximumSeats TINYINT,
	@IsSupportsAC BIT = 0,
	@LoggedInUserId UNIQUEIDENTIFIER,
	@Result UNIQUEIDENTIFIER OUTPUT
AS
DECLARE @Response INT = 0;

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

	IF (@VehicleNumber IS NULL OR LEN(@VehicleNumber) <= 0)
	BEGIN
		RAISERROR('INVALID_PARAM_VEHICLE_NUMBER', 16, 1);
	END

	DECLARE @DriverVehicleInfoId UNIQUEIDENTIFIER = CASE WHEN (@Id IS NULL OR @Id = @EmptyGuid) THEN NEWID() ELSE @Id END;

    IF(@Id IS NULL OR @Id = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Setup].[DriverVehicleInfo] WHERE [Id] = @Id))
	BEGIN
		INSERT INTO [Setup].[DriverVehicleInfo]
		([Id], [DriverInfoId], [VehicleType], [VehicleNumber], [VehicleColor], [MaximumSeats], [IsSupportsAC], [CreatedBy])
		VALUES 
		(@DriverVehicleInfoId, @DriverInfoId, @VehicleType, @VehicleNumber, @VehicleColor, @MaximumSeats, @IsSupportsAC, @LoggedInUserId);
	END
	ELSE
	BEGIN  
		UPDATE [Setup].[DriverVehicleInfo]
		SET	
			[VehicleType] = @VehicleType, 
			[VehicleNumber] = @VehicleNumber, 
			[VehicleColor] = @VehicleColor, 
			[MaximumSeats] = @MaximumSeats, 
			[IsSupportsAC] = @IsSupportsAC, 
			[ModifiedBy] = @LoggedInUserId,
			[ModifiedDate] = GETUTCDATE()
		WHERE [Id] = @DriverVehicleInfoId AND [RowStatus] = 'A';
	END

	SET @Result = @DriverInfoId;
	RETURN @Response;

END TRY  
BEGIN CATCH  
	DECLARE @ErrorNumber INT = ERROR_NUMBER();  
	DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE()
     
	RAISERROR('%s', 16, 1, @ErrorMessage)  
END CATCH;