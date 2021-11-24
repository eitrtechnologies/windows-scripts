# EITR Windows Scripts
Some (hopefully) helpful Windows scripts.

## GCC High

### `EnableInformationProtectionLabels.ps1`

Enable Sensitivity Labels on GCC High. This script modifies the Azure AD directory settings and then synchronizes with
Office through the Exchange Online Management module.

## Software

### `InstallAdobeAcrobatReaderDC.ps1`

Install Adobe Acrobat Reader DC unattended on a Windows host. This script can be referenced in an Azure VM Extension or
as an Microsoft Endpoint Manager script. The latest version found in the Adobe Release Notes will be used.
