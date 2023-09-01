CREATE TABLE [dbo].[LicensesHistory] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [LicenseId]   INT           NOT NULL,
    [Title]       NVARCHAR (75) NOT NULL,
    [PaymentDate] DATETIME      DEFAULT (getdate()) NOT NULL,
    [ExpiryDate]  DATETIME      NOT NULL,
    [SoftwareId]  INT           NOT NULL,
    [CustomerId]  INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

