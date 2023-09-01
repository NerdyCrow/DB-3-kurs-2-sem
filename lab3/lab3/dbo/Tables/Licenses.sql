CREATE TABLE [dbo].[Licenses] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (75) NOT NULL,
    [PaymentDate] DATETIME      DEFAULT (getdate()) NOT NULL,
    [ExpiryDate]  DATETIME      NOT NULL,
    [SoftwareId]  INT           NOT NULL,
    [CustomerId]  INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Licenses_Customers] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]),
    CONSTRAINT [FK_Licenses_Software] FOREIGN KEY ([SoftwareId]) REFERENCES [dbo].[Software] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Licenses_SoftwareId]
    ON [dbo].[Licenses]([SoftwareId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Licenses_CustomerId]
    ON [dbo].[Licenses]([CustomerId] ASC);


GO
CREATE TRIGGER Licenses_INSERT
ON Licenses
	AFTER INSERT
	AS
	INSERT INTO LicensesHistory
	(
	LicenseId,
	Title,
	PaymentDate,
	ExpiryDate,
	SoftwareId,
	CustomerId
	) 
	SELECT	i.Id, 
			i.Title,
			i.PaymentDate,
			i.ExpiryDate,
			i.SoftwareId,
			i.CustomerId
	FROM INSERTED i
	RETURN;

GO
create trigger trg_InsertLicenses 
ON Licenses AFTER insert AS select * from Licenses