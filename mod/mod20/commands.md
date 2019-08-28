# Preparation

## Mongo VM connection string

```
mongodb://40.68.7.220:27017
```

## SQL Server 2012 connection string

```
Server=tcp:13.69.120.223,1433;Initial Catalog=tailwindsql;Persist Security Info=False;User ID=tailwind;Password=traderstraders42.;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;
```

## Mongo DB VM

```
ssh tailwind@40.68.7.220
password: tailwindtraders42.
```

## Remote desktop SQL Server VM

```
Username: tailwind
Password: tailwindtraders42.
```

## Tailwindtraders website

```
Username: cxa@microsoft.com
Password: [any password works]
```

## Azure SQL DB

```
Username: tailwind
Password: traders42.
```

# MongoDB to CosmosDB migration

## Mongo DB VM

```
ssh tailwind@40.68.7.220
password: tailwindtraders42.
```

## Tailwindtraders website

```
Username: cxa@microsoft.com
Password: [any password works]
```

## Source connection string

```
mongodb://40.68.7.220:27017
```

## Target connection string

```
mongodb://lbtailwind-mongo:b0Nl0QQz1mUQA782f6VRFzRO6e2GTkdf0NWnxfPpAwXUA3jys6oluhkAn8T8XA9oXknnIo4wTc2qFCH749M0Bw==@lbtailwind-mongo.documents.azure.com:10255/?ssl=true&replicaSet=globaldb
```

## Cart item:

```
{
	"_id" : "5d665a5689c79d19d44b4799",
	"productId" : 99,
	"email" : "cxa@microsoft.com",
	"imageUrl" : "https://github.com/ashleymcnamara/Developer-Advocate-Bit/blob/master/BitDevAdvocate.png?raw=true",
	"name" : "Cloud Advocate Mascot",
	"price" : "999",
	"qty" : 3,
	"id" : "f2729f14-090d-4b40-8e45-e5dcdb58c0a2"
}
```

# SQL to Azure SQL DB migration

## Source SQL

```
IP: 13.69.120.223
Username: tailwind
Password: traderstraders42.
```

## Target SQL

```
Host name: lbtailwind-sqlsvr.database.windows.net
Username: tailwind
Password: traders42.

SQL Connection string

Server=tcp:lbtailwind-sqlsvr.database.windows.net,1433;Initial Catalog=lbtailwind-sqldb;Persist Security Info=False;User ID=tailwind;Password=traders42.;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```
