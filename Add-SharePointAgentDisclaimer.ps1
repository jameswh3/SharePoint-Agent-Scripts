# Update with Details for your site
$siteUrl = "https://contoso.sharepoint.com/sites/site"
$siteRelativePath = $siteUrl -replace "^(https?://[^/]+)", ""
$documentLibrary = "<<The Document Library and Folder Path of the Agent>>"
$fileName = "<<The Name of your agent file>>"
$clientId = "<<Your Microsoft Entra Client Id>>"

# Connect to SharePoint Online
Connect-PnPOnline -Url $siteUrl `
                  -ClientId $ClientId `
                  -Interactive `
                  -ForceAuthentication

# Get the file from the document library
$file = Get-PnPFile -Url "$siteRelativePath/$documentLibrary/$fileName" -AsString

# Convert the file content from JSON
$jsonContent = $file | ConvertFrom-Json

# Define the disclaimer text
$disclaimerText = " \n\n**** DISCLAIMER: Please note that responses from this agent are AI generated and may be incorrect. ****"

# Add the disclaimer text to the welcomeMessage text
$jsonContent.customCopilotConfig.conversationStarters.welcomeMessage.text += $disclaimerText


# Convert the updated JSON content back to a string
$updatedFileContent = $jsonContent | ConvertTo-Json -Depth 10
$updatedFileContent = $updatedFileContent.Replace( "\\n","\n") #added this because PowerShell ConvertTo-Json escapes the new line characters

# Save the updated file back to the document library
Add-PnPFile -FileName $fileName -Folder $documentLibrary -Content $updatedFileContent