﻿CREATE TABLE [Account].[UserInfo]
(
	[Id] UNIQUEIDENTIFIER NOT NULL,
	[AspNetUserId] NVARCHAR(36) NOT NULL,
	[ComcastEmployeeId] NVARCHAR(450) NOT NULL,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Email] NVARCHAR(256) NULL,
	[PhoneNumber] NVARCHAR(10) NULL,
	[Gender] NVARCHAR(15) NOT NULL,
	[ManagerId] UNIQUEIDENTIFIER NULL,
	[IsRider] BIT NOT NULL,
	[SequenceId] INT NOT NULL IDENTITY,
	[CreatedBy] UNIQUEIDENTIFIER NOT NULL,	
	[CreatedDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedDate] DATETIME2,
	[RowStatus] NVARCHAR(1) NOT NULL DEFAULT 'A'
	CONSTRAINT [PK_account_UserInfo] PRIMARY KEY NONCLUSTERED 
	(
		[Id] ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY], 
    CONSTRAINT [FK_UserInfo_AspNetUsers] FOREIGN KEY ([AspNetUserId]) REFERENCES [Auth].[AspNetUsers]([Id]),
    CONSTRAINT [FK_UserInfo_Manager] FOREIGN KEY ([ManagerId]) REFERENCES [Account].[UserInfo]([Id]),
    CONSTRAINT [FK_UserInfo_Gender] FOREIGN KEY ([Gender]) REFERENCES [Lookups].[GenderInfo]([Gender]),
    CONSTRAINT [FK_UserInfo_RowStatus] FOREIGN KEY ([RowStatus]) REFERENCES [Metadata].[RowStatusInfo]([RowStatus])
) ON [PRIMARY];
GO
CREATE UNIQUE CLUSTERED INDEX [IX_UserInfo_SequenceId] ON [Account].[UserInfo] ([SequenceId])
GO