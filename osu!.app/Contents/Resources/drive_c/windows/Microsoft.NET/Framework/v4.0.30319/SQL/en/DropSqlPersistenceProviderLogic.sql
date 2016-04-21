SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--
-- DeleteInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteInstance]
GO

--
-- LoadInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[LoadInstance]
GO

--
-- LockInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LockInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[LockInstance]
GO

--
-- InsertInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[InsertInstance]
GO

--
-- UpdateInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateInstance]
GO

--
-- UnlockInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnlockInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UnlockInstance]
GO
