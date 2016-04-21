set ansi_nulls on
set quoted_identifier on
set nocount on
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[ParseBinaryPropertyValue]') and type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function [System.Activities.DurableInstancing].[ParseBinaryPropertyValue]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[GetExpirationTime]') and type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	drop function [System.Activities.DurableInstancing].[GetExpirationTime]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[CreateLockOwner]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[CreateLockOwner]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[DeleteLockOwner]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[DeleteLockOwner]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[ExtendLock]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[ExtendLock]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[AssociateKeys]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[AssociateKeys]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[CompleteKeys]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[CompleteKeys]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[FreeKeys]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[FreeKeys]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[CreateInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[CreateInstance]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[LockInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[LockInstance]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[RecoverInstanceLocks]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[RecoverInstanceLocks]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[DetectRunnableInstances]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[DetectRunnableInstances]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[TryLoadRunnableInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[TryLoadRunnableInstance]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[CreateServiceDeployment]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[CreateServiceDeployment]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[GetActivatableWorkflowsActivationParameters]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[GetActivatableWorkflowsActivationParameters]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[LoadInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[LoadInstance]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[DeleteInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[DeleteInstance]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[SaveInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[SaveInstance]
go

if exists (select * from sys.triggers where object_id = OBJECT_ID(N'[System.Activities.DurableInstancing].[DeleteInstanceTrigger]'))
	drop trigger [System.Activities.DurableInstancing].[DeleteInstanceTrigger]
go

if exists (select * from sys.triggers where object_id = OBJECT_ID(N'[System.Activities.DurableInstancing].[DeleteServiceDeploymentTrigger]'))
	drop trigger [System.Activities.DurableInstancing].[DeleteServiceDeploymentTrigger]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[InsertRunnableInstanceEntry]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[InsertRunnableInstanceEntry]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[InsertPromotedProperties]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[InsertPromotedProperties]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[UnlockInstance]') and type in (N'P', N'PC'))
	drop procedure [System.Activities.DurableInstancing].[UnlockInstance]
go
