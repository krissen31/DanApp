CREATE TABLE [dbo].[Registration] (
    [RegistrationId]  INT             IDENTITY (0, 1) NOT NULL,
    [FirstName]       NVARCHAR (255)  NOT NULL,
    [LastName]        NVARCHAR (255)  NOT NULL,
    [Email]           NVARCHAR (255)  NOT NULL,
    [Password]        NVARCHAR (50)   NOT NULL,
    [Gender]          NVARCHAR (50)   NOT NULL,
    [Age]             TINYINT         NOT NULL,
    [Country]         NVARCHAR (250)  CONSTRAINT [DF_Registration_Country] DEFAULT ('') NOT NULL,
    [City]            NVARCHAR (250)  CONSTRAINT [DF_Registration_City] DEFAULT ('') NOT NULL,
    [PostCode]        NVARCHAR (50)   CONSTRAINT [DF_Registration_PostCode] DEFAULT ('') NOT NULL,
    [UserDescription] NVARCHAR (4000) CONSTRAINT [DF_Registration_UserDescription] DEFAULT ('') NOT NULL,
    [FBLink]          NVARCHAR (255)  CONSTRAINT [DF_Registration_FBLink] DEFAULT ('') NOT NULL,
    [IGLink]          NVARCHAR (255)  CONSTRAINT [DF_Registration_IGLink] DEFAULT ('') NOT NULL,
    [Picture]         NVARCHAR (MAX)  CONSTRAINT [DF_Registration_Picture] DEFAULT ('') NOT NULL,
    [ModifiedDate]    SMALLDATETIME   CONSTRAINT [DF_Registration_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED ([RegistrationId] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Registration]
    ON [dbo].[Registration]([FirstName] ASC, [LastName] ASC, [Email] ASC);

