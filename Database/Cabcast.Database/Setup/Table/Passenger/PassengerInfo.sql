CREATE TABLE [Setup].[PassengerInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [UserInfoId] UNIQUEIDENTIFIER NOT NULL,
    [HomeLocationInfoId] UNIQUEIDENTIFIER NOT NULL,
    [DepartureTime] TIME(0) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_PassengerInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [FK_PassengerInfo_UserInfo] FOREIGN KEY ([UserInfoId]) REFERENCES [Account].[UserInfo]([Id])
    CONSTRAINT [FK_PassengerInfo_LocationInfo] FOREIGN KEY ([HomeLocationInfoId]) REFERENCES [Location].[LocationInfo]([Id])
    CONSTRAINT [FK_PassengerInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_PassengerInfo_SequenceId] ON [Setup].[PassengerInfo] ([SequenceId])