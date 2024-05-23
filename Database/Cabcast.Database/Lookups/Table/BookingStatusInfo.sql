CREATE TABLE [Lookups].[BookingStatusInfo]
(
	[BookingStatus] NVARCHAR(15) NOT NULL,
	[BookingStatusValue] NVARCHAR(15) NOT NULL,
	[SequenceId] INT IDENTITY(1,1) NOT NULL,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
	CONSTRAINT [PK_Lookups_BookingStatusInfo] PRIMARY KEY NONCLUSTERED 
	(
		[BookingStatus] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CONSTRAINT [FK_BookingStatusInfo_RowStatusInfo] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_BookingStatusInfo_SequenceId] ON [Lookups].[BookingStatusInfo] ([SequenceId])