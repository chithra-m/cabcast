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
	IF NOT EXISTS(SELECT 1 FROM [Base].[GenderInfo] WHERE [Gender] LIKE N'MALE')
	BEGIN
		INSERT INTO [Base].[GenderInfo]([Gender], [GenderValue]) VALUES (N'MALE', N'Male');
	END
	IF NOT EXISTS(SELECT 1 FROM [Base].[GenderInfo] WHERE [Gender] LIKE N'FEMALE')
	BEGIN
		INSERT INTO [Base].[GenderInfo]([Gender], [GenderValue]) VALUES (N'FEMALE', N'Female');
	END
	IF NOT EXISTS(SELECT 1 FROM [Base].[GenderInfo] WHERE [Gender] LIKE N'TRANS')
	BEGIN
		INSERT INTO [Base].[GenderInfo]([Gender], [GenderValue]) VALUES (N'TRANS', N'Trans');
	END
END
GO