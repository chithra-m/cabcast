CREATE TABLE [Auth].[AspNetUsers]
(
	[Id] NVARCHAR(36) NOT NULL,
	[UserName] NVARCHAR(256) NULL,
	[NormalizedUserName] NVARCHAR(256) NULL,
	[Email] NVARCHAR(256) NULL,
	[NormalizedEmail] NVARCHAR(256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] NVARCHAR(MAX) NULL,
	[SecurityStamp] NVARCHAR(MAX) NULL,
	[ConcurrencyStamp] NVARCHAR(MAX) NULL,
	[PhoneNumber] NVARCHAR(10) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	 CONSTRAINT [PK_Auth_AspNetUsers] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
) ON [PRIMARY];
GO;
CREATE INDEX [EmailIndex] ON [Auth].[AspNetUsers] ([NormalizedEmail])