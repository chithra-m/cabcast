CREATE TABLE [Setup].[DriverRouteInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [DriverInfoId] UNIQUEIDENTIFIER NOT NULL,
    [RouteInfoId] UNIQUEIDENTIFIER NOT NULL,
	[DepartureTime] TIME(0) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_DriverRouteInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [FK_DriverRouteInfo_DriverInfo] FOREIGN KEY ([DriverInfoId]) REFERENCES [Setup].[DriverInfo]([Id])
    CONSTRAINT [FK_DriverRouteInfo_RouteInfo] FOREIGN KEY ([RouteInfoId]) REFERENCES [Setup].[RouteInfo]([Id])
	CONSTRAINT [FK_DriverRouteInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_DriverRouteInfo_SequenceId] ON [Setup].[DriverRouteInfo] ([SequenceId])