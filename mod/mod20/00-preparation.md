# Preparation before the session

1. Run the [Deploy to Azure button](https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51) to deploy the infrastructure.

2. Make sure to write down the following information:
  a. Navigate to the newly deployed Resource Group.
  b. Open the Azure SQL Database.
  c. Open the Connection strings blade.
  d. Make sure that the `ADO.NET` tab is selected and copy the connection string.

> For example it should look like this:

```
Server=tcp:lbtailwind-sqlsvr.database.windows.net,1433;Initial Catalog=lbtailwind-sqldb;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

**TO BE CONTINUED**

# TEMPO WORK IN PROGRESS

- Choose a region to deploy all the resources. Here below referred to as `Your region`. For example
	- West Europe
	- East US2

- Choose a unique prefix, for example your initials. Here below referred to as `[prefix]`.

- [Deploy to Azure button](https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51)
	- Microsoft
	- Ignite the Tour
	- Create New
	- `Mod20-[prefix]-TailwindTraders-Standalone`
	- `Mod20[prefix]TailwindTraders`
	- Your region
	- standalone
	- `tailwind`
	- `traderstraders42.`

## Additional work

### Virtual machines

- Create a Resource Group
	- `Mod20-[prefix]-TailwindTraders-Vms`

- Create and configure a [Virtual machine with MongoDB](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-mean-stack).

- Create and configure a [Virtual machine with SQL Server 2012](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-server-provision#1-configure-basic-settings).
	- SQL Server 2012 SP4 on Windows Server 2012 R2
	- Standard DS13 v2
	- Disk Premium SSD
	- Username `tailwind`
	- Password `traderstraders42.`
	- Open inbound TCP port 3389 RDP
	- Open inbound TCP port 80 HTTP
	- Open inbound TCP port 443 HTTPS
	- Open inbound TCP port 1433 SQL
	-  Enable SQL Authentication
		- Username tailwind
		- Password traderstraders42.
		- Disable Keyvault integration

### Other resources

In the `Mod20-[prefix]-TailwindTraders-Standalone` resource group:

- Create the Database Migration Service.
	- `Mod20[prefix]Dms`
	- Ignite the Tour subscription
	- Mod20-[prefix]-TailwindTraders-Standalone resource group
	- Your region
	- Virtual network of the VMs
	- Premium
	- Create

- Create a backup Cosmos DB
	- Ignite the Tour subscription
	- Mod20-[prefix]-TailwindTraders-Standalone resource group
	- `mod20[prefix]tailwind-mongo-bak` (lowercase)
	- Azure Cosmos DB for MongoDB API
	- Your region
	- Enable Geo-redundancy
	- Enable multi-region writes
	- Disable Availability zones
	- Review and create
	- Migrate to it using the DMS
		- Delete the migration project

- Create a backup SQL DB
	- Go to `mod20[prefix]tailwindtraders-sqlsvr` SQL server
	- New database
	- `mod20[prefix]tailwindtraders-sqldb-bak` (lowercase)
	- Blank database
	- Not now
	- Basic
	- Migrate to it using the DMS
		- Migration name `mig-sql`
		- Delete the schema migration activity
		- Keep the data migration activity
		- Keep the migration project

## Additional configuration

- Open the mod20[prefix]tailwindtraders App Service
	- Open the Configuration blade
	- Under Application settings, add a `New application setting`
		- Name: `DebugInformation__ShowDebug`
		- Value: `true`
		- Deployment slot setting: Leave unchecked.
		- OK
	- (To solve the bug where images don't appear in the website)
		- Name: `ProductImagesUrl`
		- Value: `https://raw.githubusercontent.com/microsoft/TailwindTraders-Backend/master/Source/Services/Tailwind.Traders.Product.Api/Setup/product-images/product-details`
		- Deployment slot setting: Leave unchecked.
		- OK
	- (Optional) Add a `New application setting`
		- Name: `DebugInformation__CustomText`
		- Value: `Any text you want to display`
		- Deployment slot setting: Leave unchecked.
		- OK
	- Save.
	- In the Overview blade of the App service, click on `Restart` then `Yes`.
	- After a few minutes, you will see a new debug header on top of the page at `https://mod20[prefix]tailwindtraders.azurewebsites.net` with the host information of the databases.
	
## Prep before session

	• Reboot
	• Check that MongoDB VM is up and running, CLOSE
	• In App Service, Connections strings set to IaaS VMs
	• Go back to Overview
	• Open cloud shell
	• ssh tailwind@40.68.7.220
	• Exit and clear
	• Minimize Cloud shell
	• Check that SQL VM is up and running
	• Connect using Remote Desktop
	• Minimize Remote Desktop
	• Close SQL VM
	• Make sure that the Tailwind Traders website works well
		○ Login
		○ Add an item to cart
		○ Clear cart
		○ Log off
	• Make sure that the Data Migration Assistant is installed and runs
		○ Delete all the projects if available
	• Make sure that the tables in the Azure SQL DB are dropped
	• Go back to overview
	• Make sure that the collections in the CosmosDB are dropped
	• Go back to overview
	• Open the DMS page and make sure it is running
		○ Delete all the projects
	• Start the presentation

