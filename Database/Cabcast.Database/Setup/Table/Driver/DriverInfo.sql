CREATE TABLE [Setup].[DriverInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [UserInfoId] UNIQUEIDENTIFIER NOT NULL,
    [LicenseNumber] NVARCHAR(20) UNIQUE NULL,
    [HomeLocationInfoId] UNIQUEIDENTIFIER NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_DriverInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [UC_DriverInfo_LicenseNumber] UNIQUE([LicenseNumber])
    CONSTRAINT [FK_DriverInfo_UserInfo] FOREIGN KEY ([UserInfoId]) REFERENCES [Account].[UserInfo]([Id])
    CONSTRAINT [FK_DriverInfo_LocationInfo] FOREIGN KEY ([HomeLocationInfoId]) REFERENCES [Location].[LocationInfo]([Id])
	CONSTRAINT [FK_DriverInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_DriverInfo_SequenceId] ON [Setup].[DriverInfo] ([SequenceId])