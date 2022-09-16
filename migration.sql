IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Guilds] (
    [ID] int NOT NULL IDENTITY,
    [DiscordId] nvarchar(max) NULL,
    [AllowDirectMessage] bit NOT NULL,
    CONSTRAINT [PK_Guilds] PRIMARY KEY ([ID])
);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180726032554_InitialCreate', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [UseUserIdentifiers] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180903043025_Added UserIdentfie', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [UserIdentifierSeed] int NOT NULL DEFAULT 0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20180908141038_GuildUserIdentifierSeed', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [AllowedRole] nvarchar(max) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20181005012009_AddAllowedRole', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [BannedIdentifiers] (
    [ID] int NOT NULL IDENTITY,
    [Identifier] nvarchar(max) NULL,
    [GuildID] int NULL,
    CONSTRAINT [PK_BannedIdentifiers] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_BannedIdentifiers_Guilds_GuildID] FOREIGN KEY ([GuildID]) REFERENCES [Guilds] ([ID]) ON DELETE NO ACTION
);
GO

CREATE INDEX [IX_BannedIdentifiers_GuildID] ON [BannedIdentifiers] ([GuildID]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190220044024_BannedUsers', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [SubscriptionId] nvarchar(max) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190312035652_SubscriptionId', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [AdminRole] nvarchar(max) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190319045013_AddAdminRole', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [MessagesSentThisMonth] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [Guilds] ADD [TrackingMonth] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20191006234916_MessageLimit', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Guilds] ADD [UseEmbed] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20201025184258_AddEmbedOption', N'6.0.0');
GO

COMMIT;
GO
