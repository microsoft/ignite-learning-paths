# WORK IN PROGRESS

# Run the deployment from here

- Use the [Deploy to Azure button from here](https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51).

- Enter the following information:

    - Website name: Mod20TailwindTraders

- After deployment is complete, go to the App Service.

- Under Configuration / Application settings, add a new setting called `DebugInformation__ShowDebug` with the value `true`.

- After about one minute, start the website and verify that the debug header with connection information is shown.

![Debug header](TODO)

- Go to the CosmosDB instance `lbtailwindtraders-mongo`.

- Open Data Explorer.

- Follow the indications on the yellow header explaining how to update the Firewall.

![Updating the CosmosDB Firewall](TODO)

> Note that changes to the Firewall can take 15 minutes to be applied. Be patient and try again to access the Data Explorer later.

- Go to the Azure SQL Server instance.

- Open Firewalls and virtual networks

- Click Add client IP

- Click Save

![Control buttons](TODO)

- Open the Azure SQL DB instance.

- Open Query Editor and try to login.