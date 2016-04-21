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
CREATE PROCEDURE DeleteInstance
	@id uniqueIdentifier,
	@hostId uniqueIdentifier,
	@lockTimeout int,
	@result int output
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @now datetime;
	SET @now = getutcdate();

	DELETE FROM [dbo].[InstanceData]
		WHERE (id = @id) AND ((@lockTimeout < 0) OR ((lockOwner = @hostId) AND (lockExpiration >= @now)));

	IF @@rowcount = 1
		SET @result = 0; -- Success
	ELSE
	BEGIN
		IF EXISTS (SELECT 1 FROM [dbo].[InstanceData] WHERE id = @id)
			SET @result = 2; -- Could not acquire lock
		ELSE
			SET @result = 1; -- Instance not found
	END
END
GO
GRANT EXECUTE ON [dbo].[DeleteInstance] TO persistenceUsers
GO

--
-- LoadInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[LoadInstance]
GO
CREATE PROCEDURE LoadInstance
	@id uniqueidentifier,
	@lockInstance bit,
	@hostId uniqueidentifier,
	@lockTimeout int,
	@result int output
AS
BEGIN
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	DECLARE @createdTransaction bit;
	
	DECLARE @now datetime, @lockExpiration datetime;
	SET @now = getutcdate();
	SET @result = 0;

	IF (@lockTimeout < 0) OR (@lockInstance = 'FALSE')
	BEGIN
		SELECT 
			'instance' = instance,
			'instanceXml' = instanceXml,
			'isXml' = CASE
				WHEN instanceXml is NOT NULL THEN 1
				ELSE 0
			END
			FROM [dbo].[InstanceData]
			WHERE id = @id;

		IF @@rowcount = 0
			SET @result = 1; -- Instance not found
	END
	ELSE
	BEGIN
		IF @lockTimeout = 0
			SET @lockExpiration = '9999-12-31T23:59:59';
		ELSE 
			SET @lockExpiration = dateadd(second, @lockTimeout, @now);

		IF @@trancount = 0
		BEGIN
			SET @createdTransaction = 'TRUE';
			BEGIN TRANSACTION;
		END

		UPDATE [dbo].[InstanceData] SET
			lockOwner = @hostId,
			lockExpiration = @lockExpiration
			WHERE (id = @id) AND ((lockOwner is NULL) OR (lockOwner = @hostId) OR (lockExpiration < @now));

		IF @@rowcount = 1
		BEGIN
			SELECT 
				instance,
				instanceXml,
				'isXml' = CASE
					WHEN instanceXml is NOT NULL THEN 1
					ELSE 0
				END
				FROM [dbo].[InstanceData]
				WHERE id = @id;

			IF @@error <> 0
			BEGIN
				ROLLBACK TRANSACTION
				RETURN
			END
		END
		ELSE
		BEGIN 
			IF EXISTS (SELECT 1 FROM [dbo].[InstanceData] WHERE id = @id)
				SET @result = 2; -- Could not acquire lock
			ELSE
				SET @result = 1; -- Instance not found
		END

		IF @createdTransaction = 'TRUE'
			COMMIT TRANSACTION
	END
END
GO
GRANT EXECUTE ON [dbo].[LoadInstance] TO persistenceUsers
GO

--
-- InsertInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[InsertInstance]
GO
CREATE PROCEDURE InsertInstance
	@id uniqueidentifier,
	@instance image = NULL,
	@instanceXml xml = NULL,
	@unlockInstance bit,
	@hostId uniqueidentifier,
	@lockTimeout int,
	@result int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	SET @result = 0;

	DECLARE @now datetime, @lockExpiration datetime, @newOwner uniqueidentifier;
	SET @now = getutcdate();
	
	IF @lockTimeout < 0 OR @unlockInstance = 'TRUE'
	BEGIN
		SET @lockExpiration = NULL;
		SET @newOwner = NULL;
	END
	ELSE 
	BEGIN
		SET @newOwner = @hostId;

		IF @lockTimeout = 0
			SET @lockExpiration = '9999-12-31T23:59:59';
		ELSE
			SET @lockExpiration = dateadd(second, @lockTimeout, @now);
	END

	INSERT INTO [dbo].[InstanceData] (id, instance, instanceXml, created, lastUpdated, lockOwner, lockExpiration)
		VALUES (@id, @instance, @instanceXml, @now, @now, @newOwner, @lockExpiration);

	IF @@rowcount = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM [dbo].[InstanceData] WHERE id = @id)
			SET @result = 1; -- The instance already existed.
		ELSE
			SET @result = 2; -- Some other non-fatal error caused us not to insert
	END
END
GO
GRANT EXECUTE ON [dbo].[InsertInstance] TO persistenceUsers
GO

--
-- UpdateInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateInstance]
GO
CREATE PROCEDURE UpdateInstance
	@id uniqueidentifier,
	@instance image = NULL,
	@instanceXml xml = NULL,
	@unlockInstance bit,
	@hostId uniqueidentifier,
	@lockTimeout int,
	@result int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	SET @result = 0;

	DECLARE @now datetime, @lockExpiration datetime, @newOwner uniqueidentifier;
	SET @now = getutcdate();
	
	IF @lockTimeout < 0 OR @unlockInstance = 'TRUE'
	BEGIN
		SET @lockExpiration = NULL;
		SET @newOwner = NULL;
	END
	ELSE 
	BEGIN
		SET @newOwner = @hostId;

		IF @lockTimeout = 0
			SET @lockExpiration = '9999-12-31T23:59:59';
		ELSE
			SET @lockExpiration = dateadd(second, @lockTimeout, @now);
	END

	UPDATE [dbo].[InstanceData] SET
		instance = @instance,
		instanceXml = @instanceXml,
		lastUpdated = @now,
		lockOwner = @newOwner,
		lockExpiration = @lockExpiration
		WHERE (id = @id) AND ((@lockTimeout < 0) OR ((lockOwner = @hostId) AND (lockExpiration >= @now)));

	IF @@rowcount = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM [dbo].[InstanceData] WHERE id = @id)
			SET @result = 2; -- Did not have lock
		ELSE
			SET @result = 1; -- Instance was not found in the database for update
	END
END
GO
GRANT EXECUTE ON [dbo].[UpdateInstance] TO persistenceUsers
GO

--
-- UnlockInstance
--
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnlockInstance]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UnlockInstance]
GO
CREATE PROCEDURE UnlockInstance
	@id uniqueIdentifier,
	@hostId uniqueIdentifier,
	@lockTimeout int,
	@result int output
AS
BEGIN
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED

	DECLARE @now datetime;
	SET @now = getutcdate();

	UPDATE [InstanceData] SET
		lockOwner = NULL,
		lockExpiration = NULL
		WHERE (id = @id) AND ((@lockTimeout < 0) OR ((lockOwner = @hostId) AND (lockExpiration >= @now)));

	IF @@rowcount = 1
		SET @result = 0; -- Success
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM [dbo].[InstanceData] WHERE id = @id)
			SET @result = 2; -- Did not have lock
		ELSE
			SET @result = 1; -- Instance not found
	END
END
GO
GRANT EXECUTE ON [dbo].[UnlockInstance] TO persistenceUsers
GO
