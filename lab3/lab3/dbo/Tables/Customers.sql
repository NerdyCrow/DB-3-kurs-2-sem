CREATE TABLE [dbo].[Customers] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [ContactId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Customers_Contacts] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Contacts] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Customers_ContactId]
    ON [dbo].[Customers]([ContactId] ASC);

