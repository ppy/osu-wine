set ansi_nulls on
set quoted_identifier on
set nocount on
go

if exists (select * from sys.views where object_id = object_id(N'[System.Activities.DurableInstancing].[Instances]'))
	drop view [System.Activities.DurableInstancing].[Instances]
go

if exists (select * from sys.views where object_id = object_id(N'[System.Activities.DurableInstancing].[ServiceDeployments]'))
	drop view [System.Activities.DurableInstancing].[ServiceDeployments]
go

if exists (select * from sys.views where object_id = object_id(N'[System.Activities.DurableInstancing].[InstancePromotedProperties]'))
      drop view [System.Activities.DurableInstancing].[InstancePromotedProperties]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[InstancesTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[InstancesTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[RunnableInstancesTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[RunnableInstancesTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[KeysTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[KeysTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[LockOwnersTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[LockOwnersTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[InstanceMetadataChangesTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[InstanceMetadataChangesTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[ServiceDeploymentsTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[ServiceDeploymentsTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[InstancePromotedPropertiesTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[InstancePromotedPropertiesTable]
go

if exists (select * from sys.objects where object_id = object_id(N'[System.Activities.DurableInstancing].[SqlWorkflowInstanceStoreVersionTable]') and type in (N'U'))
	drop table [System.Activities.DurableInstancing].[SqlWorkflowInstanceStoreVersionTable]
go

if exists (select * from sys.schemas where name = N'System.Activities.DurableInstancing')
	exec ('drop schema [System.Activities.DurableInstancing]')
go

if exists (select 1 from [dbo].[sysusers] where name=N'System.Activities.DurableInstancing.InstanceStoreUsers' and issqlrole=1 )
	drop role [System.Activities.DurableInstancing.InstanceStoreUsers]
go

if exists (select 1 from [dbo].[sysusers] where name=N'System.Activities.DurableInstancing.WorkflowActivationUsers' and issqlrole=1 )
	drop role [System.Activities.DurableInstancing.WorkflowActivationUsers]
go

if exists (select 1 from [dbo].[sysusers] where name=N'System.Activities.DurableInstancing.InstanceStoreObservers' and issqlrole=1 )
	drop role [System.Activities.DurableInstancing.InstanceStoreObservers]
go
