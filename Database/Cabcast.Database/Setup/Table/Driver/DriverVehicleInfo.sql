CREATE TABLE [Setup].[DriverVehicleInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [DriverInfoId] UNIQUEIDENTIFIER NOT NULL,
	[VehicleType] NVARCHAR(15) NOT NULL,
	[VehicleNumber] NVARCHAR(10) NOT NULL,
	[VehicleColor] NVARCHAR(15) NOT NULL,
	[MaximumSeats] TINYINT NOT NULL,
	[IsSupportsAC] BIT NOT NULL DEFAULT 0,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_DriverVehicleInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [UC_DriverVehicleInfo_VehicleNumber] UNIQUE([VehicleNumber])
	CONSTRAINT [FK_DriverVehicleInfo_DriverInfo] FOREIGN KEY ([DriverInfoId]) REFERENCES [Setup].[DriverInfo]([Id])
	CONSTRAINT [FK_DriverVehicleInfo_VehicleTypeInfo] FOREIGN KEY ([VehicleType]) REFERENCES [Lookups].[VehicleTypeInfo]([VehicleType])
	CONSTRAINT [FK_DriverVehicleInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_DriverVehicleInfo_SequenceId] ON [Setup].[DriverVehicleInfo] ([SequenceId])