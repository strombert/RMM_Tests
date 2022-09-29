<#
      .SYNOPSIS
      Install Multiple Winget Software via .json File
      .DESCRIPTION
      For installing packages using winget.
      .PARAMETER URL
      Direct URL .json File
      .NOTES
      29/09/2020 V 1.0
#>


param (
    [string] $URL
    )

## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Variables

$Folder = "C:\Temp"
$FolderContent = $Folder + "\*"

## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Create Folder on C: if it not exists, else delete it's content

If (!(Test-Path -Path $Folder))
{
   New-Item -ItemType Directory -Force -Path $Folder
   Write-Host "Folder created"
   }
Else
{
}
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Download the .json

Import-Module BitsTransfer
Start-BitsTransfer -Source $Url -Destination $Folder
Write-Host ".json download.."



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Run Winget

$wingetloc=(Get-Childitem -Path "C:\Program Files\WindowsApps" -Include winget.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -Last 1 | %{$_.FullName} | Split-Path)
cd $wingetloc

$ErrorCount = 0


./winget.exe import -i C:\Temp\winget.json --accept-source-agreements --accept-package-agreements

Write-Host "Winget started!"
Exit 0
