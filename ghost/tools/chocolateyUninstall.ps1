$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageName = "ghost"
$packageVersion = "0.5.5"
$serviceName = "Ghost"
$zipFileName = "ghost-0.5.5.zip"
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
