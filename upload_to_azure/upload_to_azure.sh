## Azure CLI script that you can use to upload one or more files to Azure Storage with an access key ##
#1.) chmod +x upload_to_azure.sh
#2.) ./upload_to_azure.sh <file_path> or ./upload_to_azure.sh file1.txt file2.txt file3.txt
#3.) Replace <storage_account_name> and <storage_account_key> with the name and key for your Azure Storage account, and <container_name> with the name of the container where you want to upload the files.


# Set the storage account name and key as environment variables
export AZURE_STORAGE_ACCOUNT="<storage_account_name>"
export AZURE_STORAGE_ACCESS_KEY="<storage_account_key>"

# Set the container name
container_name="<container_name>"

# Loop through the list of files
for file in "$@"
do
  # Get the file name
  filename=$(basename "$file")

  # Upload the file to the container
  az storage blob upload -c "$container_name" -f "$file" -n "$filename"
done
