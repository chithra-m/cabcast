CREATE TABLE [Setup].[LocationSpotInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    [AddressLine] NVARCHAR(50) NOT NULL,
    [RouteSubAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
    [RouteAreaInfoId] UNIQUEIDENTIFIER NOT NULL,
    [Pincode] NVARCHAR(6) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_LocationSpotInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CONSTRAINT [FK_LocationSpotInfo_RouteSubAreaInfo] FOREIGN KEY ([RouteSubAreaInfoId]) REFERENCES [Setup].[RouteSubAreaInfo]([Id]),
	CONSTRAINT [FK_LocationSpotInfo_RouteAreaInfo] FOREIGN KEY ([RouteAreaInfoId]) REFERENCES [Setup].[RouteAreaInfo]([Id]),
    CONSTRAINT [FK_LocationSpotInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_LocationSpotInfo_SequenceId] ON [Setup].[LocationSpotInfo] ([SequenceId])