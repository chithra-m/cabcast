CREATE TABLE [Setup].[RoutePointInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [RouteInfoId] UNIQUEIDENTIFIER NOT NULL,
    [LocationSpotInfoId] UNIQUEIDENTIFIER NOT NULL,
    [RouteOrderNumber] INT NOT NULL, 
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_RoutePointInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CONSTRAINT [FK_RoutePointInfo_RouteInfo] FOREIGN KEY ([RouteInfoId]) REFERENCES [Setup].[RouteInfo]([Id]),
	CONSTRAINT [FK_RoutePointInfo_LocationSpotInfo] FOREIGN KEY ([LocationSpotInfoId]) REFERENCES [Setup].[LocationSpotInfo]([Id]),
    CONSTRAINT [FK_RoutePointInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_RoutePointInfo_SequenceId] ON [Setup].[RoutePointInfo] ([SequenceId])