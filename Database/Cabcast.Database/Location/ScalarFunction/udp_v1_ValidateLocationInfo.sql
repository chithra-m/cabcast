CREATE FUNCTION [Location].[udp_v1_ValidateLocationInfo]
(
	@LocationInfoId UNIQUEIDENTIFIER
)
RETURNS BIT
AS
BEGIN

	DECLARE @EmptyGuid UNIQUEIDENTIFIER;
	SET @EmptyGuid = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER);
	
	RETURN CASE WHEN (@LocationInfoId IS NULL OR @LocationInfoId = @EmptyGuid OR NOT EXISTS(SELECT TOP 1 1 FROM [Location].[LocationInfo] 
	WHERE [Id] = @LocationInfoId)) THEN 0 ELSE 1 END;
END
