# Preparation before the session

1. Run the [Deploy to Azure button](TODO) to deploy the infrastructure.

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

