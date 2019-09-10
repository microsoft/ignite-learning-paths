# Session outline

|Title|Duration|Timing|
|-----|--------|------|
|Introduction, Why migrate now, Tools|5'|0:05|
|Tailwind traders before / after|2'|0:07|
|About CosmosDB|3'|0:10|
|[Demo Migrate MongoDB -> Cosmos DB](#demomigratemongodb)|11'|0:21|
|Migration assessment with DMA|2'|0:23|
|[Demo Assessment, Migration SQL part 1](#demoassessment)|8'|0:31|
|About SQL, Managed Instance|6'|0:37|
|Demo Migration SQL part 2|3'|0:40|
|PostgreSQL, MySQL, MariaDB|2'|0:42|

<a id="demomigratemongodb"></a>
## Demo Migrate MongoDB -> Cosmos DB

- Show the website with debug header
- Show the Remote Desktop connected to SQL Server VM
- Show SSH into the MongoDB VM
- On website, show the products, login
- Add items to cart, modify quantity
- Show the CosmosDB target, no collections
- Show the DMS
- Create and run the migration project with connection strings
- Switch the connection string to the new CosmosDB in App Service
- Show the new collection in CosmosDB
- Give a quick tour of CosmosDB, replicate data globally
- Go back to the website, refresh
- Show the new connection string
- Go to the cart
- Go to CosmosDB data explorer
- Add a new document (see commands.md)
- Go back to the cart to show it works

<a id="demoassessment"></a>
## Demo Assessment, Migration SQL part 1

- Show the TailwindTraders website header pointing to IP
- Show the target Azure SQL Database, it is empty
- Go back to DMS
- Create new migration project
- Show that it requires the DMA first to assess and migrate the schema
