CREATE TABLE [Lookups].[VehicleTypeInfo]
(
	[VehicleType] NVARCHAR(15) NOT NULL,
	[VehicleTypeValue] NVARCHAR(15) NOT NULL,
	[SequenceId] INT IDENTITY(1,1) NOT NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
	CONSTRAINT [PK_Lookups_VehicleTypeInfo] PRIMARY KEY NONCLUSTERED 
	(
		[VehicleType] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CONSTRAINT [FK_VehicleTypeInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_VehicleTypeInfo_SequenceId] ON [Lookups].[VehicleTypeInfo] ([SequenceId])