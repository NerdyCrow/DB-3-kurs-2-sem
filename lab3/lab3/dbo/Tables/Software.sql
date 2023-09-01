CREATE TABLE [dbo].[Software] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (75) NOT NULL,
    [Version]     NVARCHAR (75) NOT NULL,
    [Price]       MONEY         NOT NULL,
    [OwnerId]     INT           NOT NULL,
    [DateCreated] DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Software_Owners] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[Owners] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Software_OwnerId]
    ON [dbo].[Software]([OwnerId] ASC);

