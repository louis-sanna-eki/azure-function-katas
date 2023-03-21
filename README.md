# Deployment


Replace the following variables with your own values
```shell
export resource_group="azure-function-katas"
export function_app_name="azfk-azure-function"
export zip_file_path="./funcApp.zip"
````

Deploy the zip file to the Function App
```shell
az functionapp deployment source config-zip --resource-group $resource_group --name $function_app_name --src $zip_file_path
```

# Check deployment

Go in Azure portal, you should find the function then use the "Get function URL" button to test.