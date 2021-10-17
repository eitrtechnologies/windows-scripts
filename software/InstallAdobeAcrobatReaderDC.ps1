# Silently install Adobe Reader DC with Microsoft Intune

# Check if Software is installed already in registry.
$CheckADCReg = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.DisplayName -like "Adobe Acrobat Reader DC*"}

# If Adobe Reader is not installed continue with script
If ($CheckADCReg -eq $null) {

# Path for the temporary download folder
$InstallDir = "C:\Temp\install_adobe"
New-Item -Path $InstallDir -ItemType directory

# Get the latest version from the Release Notes
$HTTPContent = Invoke-WebRequest "https://www.adobe.com/devnet-docs/acrobatetk/tools/ReleaseNotesDC/index.html#continuous-track" -UseBasicParsing
$Version = $HTTPContent.Links | ForEach {$_.outerHTML} | Select-String Next | ForEach {$_.Line.split()} | Select-String title | ForEach {$_.Line.split('"')[1] -replace '[.]',''}

# Download the installer from the Adobe website
$Source = "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/{0}/AcroRdrDC{0}_en_US.exe" -f $Version
$Destination = "$InstallDir\AcroRdrDC_en_US.exe"
Invoke-WebRequest $Source -OutFile $Destination

# Start the installation when download is finished
Start-Process -FilePath "$Destination" -ArgumentList "/sAll /rs /rps /msi /norestart /quiet EULA_ACCEPT=YES"

# Wait for the installation to finish.
Start-Sleep -s 240

# Cleanup
rm -Recurse -Force $Installdir
}
