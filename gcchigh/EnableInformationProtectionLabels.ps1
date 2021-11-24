# Enable Information Protection Labels on GCC High

# Exchange Module
Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement

# Connect for the Sync later in this process
Connect-IPPSSession -ConnectionUri https://ps.compliance.protection.office365.us/powershell-liveid/

# Azure AD Module
Install-Module AzureADPreview -AllowClobber
Import-Module AzureADPreview

# Connect to US Gov Azure AD
Connect-AzureAD -AzureEnvironmentName AzureUSGovernment

# Get directory settings in order to modify them
$unified= (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ)
$template = Get-AzureADDirectorySettingTemplate -Id 62375ab9-6b52-47ed-826b-58e47e0e304b
$setting = $template.CreateDirectorySetting()

# Show the current values
$setting.Values

# Turn on Information Protection
$setting["EnableMIPLabels"] = "True"

# Update the directory settings
Set-AzureADDirectorySetting -DirectorySetting $setting –Id $unified.Id

# Execute the label sync
Execute-AzureAdLabelSync

# Disconnect from everything
Disconnect-ExchangeOnline
Disconnect-AzureAD
