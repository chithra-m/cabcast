CREATE TABLE [Setup].[RouteInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [StartLocation] UNIQUEIDENTIFIER NOT NULL, -- EITHER START OR END MUST BE OFFICE LOCATION
    [EndLocation] UNIQUEIDENTIFIER NOT NULL,
    [Distance] DECIMAL(10, 2) NOT NULL,
    [EstimatedDuration] TIME(0) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_RouteInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [FK_RouteInfo_StartLocation] FOREIGN KEY ([StartLocation]) REFERENCES [Location].[LocationInfo]([Id])
    CONSTRAINT [FK_RouteInfo_EndLocation] FOREIGN KEY ([EndLocation]) REFERENCES [Location].[LocationInfo]([Id])
    CONSTRAINT [FK_RouteInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_RouteInfo_SequenceId] ON [Setup].[RouteInfo] ([SequenceId])