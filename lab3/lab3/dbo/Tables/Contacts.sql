CREATE TABLE [dbo].[Contacts] (
    [Id]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (75) NOT NULL,
    [Email]   NVARCHAR (75) NOT NULL,
    [Address] NVARCHAR (75) NULL,
    [Phone]   NVARCHAR (75) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

