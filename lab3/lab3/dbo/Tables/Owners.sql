CREATE TABLE [dbo].[Owners] (
    [Id]        INT IDENTITY (1, 1) NOT NULL,
    [ContactId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Owners_Contacts] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Contacts] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Owners_ContactId]
    ON [dbo].[Owners]([ContactId] ASC);


GO

create trigger trg_InsertOwners 
ON Owners AFTER insert AS select * from Owners
