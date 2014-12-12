$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageName = "pencilblue"
$packageVersion = "0.3.0"
$serviceName = "PencilBlue"
$zipFileName = "pencilblue-0.3.0.zip"
$packagesDir = ($env:ChocolateyInstall + "\lib\")
$fullPackageName = ($packageName + "." + $packageVersion)

Write-Host "Stopping the service `'$serviceName`'."
sc.exe stop $serviceName

cd $dest
Write-Host "Removing the service named `'$serviceName`'."
node .\DeleteService.js

Write-Host "Removing files."
Remove-Item $packagesDir\$fullPackageName -Recurse -Force

Write-ChocolateySuccess $packageName
