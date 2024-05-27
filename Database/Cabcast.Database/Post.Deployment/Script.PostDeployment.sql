IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Metadata' AND T.TABLE_NAME = 'RowStatusInfo') 
BEGIN
	IF NOT EXISTS(SELECT 1 FROM [Metadata].[RowStatusInfo] WHERE [RowStatus] LIKE N'A')
	BEGIN
		INSERT INTO [Metadata].[RowStatusInfo]([RowStatus], [RowStatusValue]) VALUES (N'A', N'Active');
	END
	IF NOT EXISTS(SELECT 1 FROM [Metadata].[RowStatusInfo] WHERE [RowStatus] LIKE N'I')
	BEGIN
		INSERT INTO [Metadata].[RowStatusInfo]([RowStatus], [RowStatusValue]) VALUES (N'I', N'Inactive');
	END
	IF NOT EXISTS(SELECT 1 FROM [Metadata].[RowStatusInfo] WHERE [RowStatus] LIKE N'T')
	BEGIN
		INSERT INTO [Metadata].[RowStatusInfo]([RowStatus], [RowStatusValue]) VALUES (N'T', N'Trashed');
	END
    IF NOT EXISTS(SELECT 1 FROM [Metadata].[RowStatusInfo] WHERE [RowStatus] LIKE N'D')
	BEGIN
		INSERT INTO [Metadata].[RowStatusInfo]([RowStatus], [RowStatusValue]) VALUES (N'D', N'Deleted');
	END
END
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Lookups' AND T.TABLE_NAME = 'GenderInfo') 
BEGIN
	IF NOT EXISTS(SELECT 1 FROM [Lookups].[GenderInfo] WHERE [Gender] LIKE N'MALE')
	BEGIN
		INSERT INTO [Lookups].[GenderInfo]([Gender], [GenderValue]) VALUES (N'MALE', N'Male');
	END
	IF NOT EXISTS(SELECT 1 FROM [Lookups].[GenderInfo] WHERE [Gender] LIKE N'FEMALE')
	BEGIN
		INSERT INTO [Lookups].[GenderInfo]([Gender], [GenderValue]) VALUES (N'FEMALE', N'Female');
	END
	IF NOT EXISTS(SELECT 1 FROM [Lookups].[GenderInfo] WHERE [Gender] LIKE N'TRANS')
	BEGIN
		INSERT INTO [Lookups].[GenderInfo]([Gender], [GenderValue]) VALUES (N'TRANS', N'Trans');
	END
END
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Lookups' AND T.TABLE_NAME = 'ColorInfo') 
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'WHITE')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'WHITE', N'White');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'BLACK')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'BLACK', N'Black');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'SILVER')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'SILVER', N'Silver');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'GRAY')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'GRAY', N'Gray');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'BLUE')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'BLUE', N'Blue');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'RED')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'RED', N'Red');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'GREEN')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'GREEN', N'Green');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'YELLOW')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'YELLOW', N'Yellow');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'ORANGE')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'ORANGE', N'Orange');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'BROWN')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'BROWN', N'Brown');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'BEIGE')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'BEIGE', N'Beige');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'GOLD')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'GOLD', N'Gold');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'PURPLE')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'PURPLE', N'Purple');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[ColorInfo] WHERE [Color] LIKE N'PINK')
    BEGIN
        INSERT INTO [Lookups].[ColorInfo]([Color], [ColorValue]) VALUES (N'PINK', N'Pink');
    END
END
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Lookups' AND T.TABLE_NAME = 'VehicleTypeInfo') 
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[VehicleTypeInfo] WHERE [VehicleType] LIKE N'CAR')
    BEGIN
        INSERT INTO [Lookups].[VehicleTypeInfo]([VehicleType], [VehicleTypeValue]) VALUES (N'CAR', N'Car');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[VehicleTypeInfo] WHERE [VehicleType] LIKE N'BIKE')
    BEGIN
        INSERT INTO [Lookups].[VehicleTypeInfo]([VehicleType], [VehicleTypeValue]) VALUES (N'BIKE', N'Bike');
    END
END
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Lookups' AND T.TABLE_NAME = 'BookingStatusInfo') 
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'ACCEPTED')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'ACCEPTED', N'Accepted');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'REJECTED')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'REJECTED', N'Rejected');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'PENDING')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'PENDING', N'Pending');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'CANCELLED')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'CANCELLED', N'Cancelled');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'COMPLETED')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'COMPLETED', N'Completed');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'ON_HOLD')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'ON_HOLD', N'On Hold');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'WAITLISTED')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'WAITLISTED', N'Waitlisted');
    END
    IF NOT EXISTS(SELECT 1 FROM [Lookups].[BookingStatusInfo] WHERE [BookingStatus] LIKE N'NO_SHOW')
    BEGIN
        INSERT INTO [Lookups].[BookingStatusInfo]([BookingStatus], [BookingStatusValue]) VALUES (N'NO_SHOW', N'No show');
    END    
END
GO

--IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Setup' AND T.TABLE_NAME = 'RouteInfo') 
--BEGIN
--    IF NOT EXISTS(SELECT 1 FROM [Setup].[RouteInfo] WHERE [Id] LIKE N'1')
--    BEGIN
--        INSERT INTO[Setup].[RouteInfo]([VehicleType], [VehicleTypeValue]) VALUES (N'CAR', N'Car');
--    END
--    IF NOT EXISTS(SELECT 1 FROM [Setup].[RouteInfo] WHERE [Id] LIKE N'2')
--    BEGIN
--        INSERT INTO [Setup].[RouteInfo]([VehicleType], [VehicleTypeValue]) VALUES (N'BIKE', N'Bike');
--    END
--END
--GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Location' AND T.TABLE_NAME = 'AreaInfo') 
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [Location].[AreaInfo] WHERE [Id] LIKE N'7601957B-D037-4886-8C03-74BA9BE80348')
    BEGIN
        INSERT INTO [Location].[AreaInfo]([Id], [Name]) VALUES (N'7601957B-D037-4886-8C03-74BA9BE80348', N'Navalur ');
    END                                    
    IF NOT EXISTS(SELECT 1 FROM [Location].[AreaInfo] WHERE [Id] LIKE N'D2A0B2CC-F767-47FE-A9BE-94B8E2B1BDC1')
    BEGIN 
        INSERT INTO [Location].[AreaInfo]([Id], [Name]) VALUES (N'D2A0B2CC-F767-47FE-A9BE-94B8E2B1BDC1', N'Sithalapakkam');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[AreaInfo] WHERE [Id] LIKE N'98AF09F2-41E7-44D3-B53F-CA8B1F4457EB')
    BEGIN 
        INSERT INTO [Location].[AreaInfo]([Id], [Name]) VALUES (N'98AF09F2-41E7-44D3-B53F-CA8B1F4457EB', N'Sholinganallur');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[AreaInfo] WHERE [Id] LIKE N'953D3123-9DD3-4FA6-ADFD-A5F1BF8A7A07')
    BEGIN 
        INSERT INTO [Location].[AreaInfo]([Id], [Name]) VALUES (N'953D3123-9DD3-4FA6-ADFD-A5F1BF8A7A07', N'Karapakkam');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[AreaInfo] WHERE [Id] LIKE N'55DF324D-D9C4-4D0B-B9E9-02819489CE94')
    BEGIN 
        INSERT INTO [Location].[AreaInfo]([Id], [Name]) VALUES (N'55DF324D-D9C4-4D0B-B9E9-02819489CE94', N'Thoraipakkam');
    END
END
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES T WHERE T.TABLE_SCHEMA = 'Location' AND T.TABLE_NAME = 'SubAreaInfo') 
BEGIN
    IF NOT EXISTS(SELECT 1 FROM [Location].[SubAreaInfo] WHERE [Id] LIKE N'7601957B-D037-4886-8C03-74BA9BE80348')
    BEGIN
        INSERT INTO [Location].[SubAreaInfo]([Id], [AreaInfoId], [Name]) VALUES (N'7601957B-D037-4886-8C03-74BA9BE80348', N'Navalur ');
    END                                    
    IF NOT EXISTS(SELECT 1 FROM [Location].[SubAreaInfo] WHERE [Id] LIKE N'D2A0B2CC-F767-47FE-A9BE-94B8E2B1BDC1')
    BEGIN 
        INSERT INTO [Location].[SubAreaInfo]([Id], [AreaInfoId], [Name]) VALUES (N'D2A0B2CC-F767-47FE-A9BE-94B8E2B1BDC1', N'Sithalapakkam');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[SubAreaInfo] WHERE [Id] LIKE N'98AF09F2-41E7-44D3-B53F-CA8B1F4457EB')
    BEGIN 
        INSERT INTO [Location].[SubAreaInfo]([Id], [AreaInfoId], [Name]) VALUES (N'98AF09F2-41E7-44D3-B53F-CA8B1F4457EB', N'Sholinganallur');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[SubAreaInfo] WHERE [Id] LIKE N'953D3123-9DD3-4FA6-ADFD-A5F1BF8A7A07')
    BEGIN 
        INSERT INTO [Location].[SubAreaInfo]([Id], [AreaInfoId], [Name]) VALUES (N'953D3123-9DD3-4FA6-ADFD-A5F1BF8A7A07', N'Karapakkam');
    END
    IF NOT EXISTS(SELECT 1 FROM [Location].[SubAreaInfo] WHERE [Id] LIKE N'55DF324D-D9C4-4D0B-B9E9-02819489CE94')
    BEGIN 
        INSERT INTO [Location].[SubAreaInfo]([Id], [AreaInfoId], [Name]) VALUES (N'55DF324D-D9C4-4D0B-B9E9-02819489CE94', N'Thoraipakkam');
    END
END
GO