CREATE TABLE [Location].[LocationInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    [AddressLine] NVARCHAR(50) NOT NULL,
    [SubAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
    [AreaInfoId] UNIQUEIDENTIFIER NOT NULL,
    [Pincode] NVARCHAR(6) NOT NULL,
    [DistanceFromOfficeInKM] TINYINT NOT NULL,
    [DurationByOffice] TIME(0) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Location_LocationInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CONSTRAINT [FK_LocationInfo_SubAreaInfo] FOREIGN KEY ([SubAreaInfoId]) REFERENCES [Location].[SubAreaInfo]([Id]),
	CONSTRAINT [FK_LocationInfo_AreaInfo] FOREIGN KEY ([AreaInfoId]) REFERENCES [Location].[AreaInfo]([Id]),
    CONSTRAINT [FK_LocationInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_LocationInfo_SequenceId] ON [Location].[LocationInfo] ([SequenceId])