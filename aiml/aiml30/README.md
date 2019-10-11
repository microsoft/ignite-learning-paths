# AIML30 -Start Building Machine Learning Models Faster than You Think -Train the trainer

Tailwind Traders uses custom machine learning models to fix their inventory issues – without changing their Software Development Life Cycle! How? Azure Machine Learning Visual Interface.
 
In this session, you’ll learn the data science process that Tailwind Traders’ uses and get an introduction to Azure Machine Learning Visual Interface. You’ll see how to find, import, and prepare data, select a machine learning algorithm, train and test the model, and deploy a complete model to an API. Get the tips, best practices, and resources you and your development team need to continue your machine learning journey, build your first model, and more.


## Demo Environment Deployment
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcassieview%2Fignite-learning-paths-training-aiml%2Fmaster%2Faiml30%2Fdeploy.json" rel="nofollow">
 <img src="https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67" data-canonical-src="http://azuredeploy.net/deploybutton.png" style="max-width:100%;">
</a>


## Create Additional Resources Needed
Once you have created the base Azure Machine Learning Service Workspace we need to add additional compute resources.
### Create Compute Targets
1. Create Machine Learning Compute
    * Click on the nav "Compute"
    * Click "New"
    * Enter a name for the resource
    * Select "Machine Learning Compute" from the dropdown
    * Select the machine size
    * Enter the min and max nodes (recommend min of 0 and max of 5)
    * Click "Create"
    ![Create Compute](https://globaleventcdn.blob.core.windows.net/assets/aiml/aiml30/CreateMlCompute.gif)
2. Create Kubernetes Compute
    * Click on the nav "Compute"
    * Click "New"
    * Enter a name for the resource
    * Select "Kubernetes Service" from the dropdown
    * Click "Create"
    ![Create Kubernetes](https://globaleventcdn.blob.core.windows.net/assets/aiml/aiml30/CreateKubService.gif)


## Build Model with Azure Machine Learning Visual Designer

### 1. Upload the dataset to the Datasets in AML
* Download dataset to local from [here](https://globaleventcdn.blob.core.windows.net/assets/aiml/aiml30/datasets/ForecastingData.csv)
* Click `Datasets`
* Click `Create from local`
* Fill out the form and upload the dataset

### 2. Start Building the  Model

* Click `Visual Interface` from the left nav
* Click `Launch Visual Interface`
* Click `New` from the bottom left corner
* Click `Blank Experiment`
* Expand `Datasets` and `My Datasets`
* Drag and drop the uploaded dataset onto the experiment workspace
* Drag the `Select Columns in Dataset` onto the workspace
    * Click `Edit columns` from the properties menu on the right side.
    * Click `All Columns`
    * Click `Exclude`
    * Click `column names`
    * Exclude the `Time` column
    * Exclude the `DatesInWeek`
    * NOTE: Optionally exclude these columns in the data edit feature when uploading the dataset to the workspace in the data prep steps during upload.
* Drag the `Split Data` onto the workspace
    * Edit the properties to split the data 70/30. 
    * Discuss that this is not a rule and can change base on different model needs.
* Drag the `Train Model` onto the workspace
    * Select the label column name `Values` from the properties on the right
* Drag the `Boosted Decision Tree Regression` onto the workspace
* Drag the `Score Model` onto the workspace
* Drag the `Evaluate` onto the workspace
* Connect the `Split Data` module to `Train Model` for the training data and `Score Model` for scoring the predicted results with unseen data.
* Connect `Train Model` to the training algorithm `Boosted Decision Tree Regression` module.
* Connect `Score Model` with the `Evaluate` module.
* Click the `Run` button in the bottom nav and select compute. 

* Drag the `Execute Python Script` module onto the workspace and connect the `Score Model` module to it. 
* Copy and paste this code in:
    * `import pandas as pd` </br>
       `import numpy as np` </br>
        `def azureml_main(dataframe1 = None, dataframe2 = None):` </br>
            `print(f'Input pandas.DataFrame #1: {dataframe1}')`</br>
            `df = dataframe1`</br>
            `df['Value'] = np.exp(df['Value'])`</br>
            `df['Forecast'] = np.exp(df['Scored Labels'])`</br>
            `return df`
* Drag the `Select Columns in Dataset`
* Select columns `ID1`, `ID2`, `Value` and `Forecast`
* These are the columns the data demo app will be expecting when we post to get a result from the completed and deployed model.
* Run the training

### 4. Create Predictive Experiment and Deploy the Model

* Click `Create` predictive experiment. Think of the `Predictive Experiment` model as the production model that gets deployed to the web service. The `Training Experiment` as the dev model.
* Add the `Execute Python Script` and `Select Columns in Dataset` modules to the created predictive experiment.
* Run the experiment
* Click `Deploy Web Service`
* Navigate to the deployed web service from the left nav.
* Click on the name of the web service created.
* Click `Test` and to see how it performs on a scored data item.
* Click `Consume` and show the sample code provided for integrating the web service.

### 5. Testing API with C# console app (dotnet core)

1. [Download VS Code here](https://code.visualstudio.com/download)
2. Clone the app with the following command
    * `git clone https://github.com/microsoft/ignite-learning-paths.git`
3. Navigate to project path
    * `cd ignite-learning-paths\aiml\aiml30\C#\IgniteAimlDataApp`
4. Open the project in VS Code
    * `code .`
5. Replace the local dataset with the downloaded dataset from the step above in the `IgniteAimlDataApp/Datasets` Folder.
6. To run the test
    * Copy the API key from the `Consume` tab
    * Open the `App.config` and paste it in the value attribute
    * Copy the `Request-Response Url` from the `Consume` tab
    * Open the `Program.cs` and paste the value in  `client.BaseAddress = new Uri("");`
    * Right click `Program.cs` and select `Open in Terminal`
    * Type the command `dotnet run` to run the console app
    * To use the default values of StoreID (ID1) of 2 and ItemID    (ID2) of 1 and the number of weeks to predict. Just type `y`
    * This will run and should return the predicted values for the  next 4 weeks.

## Delivery assets

The following asset can be used for delivering this talk:

- [PowerPoint deck](https://globaleventcdn.blob.core.windows.net/assets/aiml/aiml30/AIML30_How%20to%20Build%20Machine%20Learning%20Models.pptx)
- [Demonstration videos](https://www.youtube.com/watch?v=u1ppYaZuNmo&feature=youtu.be)

## Resources and Continue Learning

Here is a list of related training and documentation.

- [Design for availability and recoverability in Azure](https://docs.microsoft.com/en-us/learn/modules/design-for-availability-and-recoverability-in-azure/)
- [Create a build pipeline](https://docs.microsoft.com/en-us/learn/modules/create-a-build-pipeline/)

## Feedback loop

Do you have a comment, feedback, suggestion? Currently, the best feedback loop for content changes/suggestions/feedback is to create a new issue on this GitHub repository. To get all the details about how to create an issue please refer to the [Contributing](../../contributing.md) docs
