CREATE TABLE [Rides].[RideBookingInfo]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [RideInfoId] UNIQUEIDENTIFIER NOT NULL,
    [PassengerInfoId] UNIQUEIDENTIFIER NOT NULL,
    [PickupRoutePointInfoId] UNIQUEIDENTIFIER NOT NULL,
	[BookingDate] DATETIME2 NOT NULL,
    [BookingStatus] NVARCHAR(15) NOT NULL,
    [SequenceId] INT NOT NULL IDENTITY, 
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2 NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
    CONSTRAINT [PK_Setup_RideBookingInfo] PRIMARY KEY NONCLUSTERED 
    (
       [Id] ASC
     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    CONSTRAINT [FK_RideBookingInfo_RideInfo] FOREIGN KEY ([RideInfoId]) REFERENCES [Rides].[RideInfo]([Id])
    CONSTRAINT [FK_RideBookingInfo_PassengerInfo] FOREIGN KEY ([PassengerInfoId]) REFERENCES [Setup].[PassengerInfo]([Id])
    CONSTRAINT [FK_RideBookingInfo_PickupRoutePointInfoId] FOREIGN KEY ([PickupRoutePointInfoId]) REFERENCES [Setup].[RoutePointInfo]([Id])
	CONSTRAINT [FK_RideBookingInfo_BookingStatusInfo] FOREIGN KEY ([BookingStatus]) REFERENCES [Lookups].[BookingStatusInfo]([BookingStatus])
	CONSTRAINT [FK_RideBookingInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_RideBookingInfo_SequenceId] ON [Rides].[RideBookingInfo] ([SequenceId])