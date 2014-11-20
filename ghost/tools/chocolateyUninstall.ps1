try {
  $dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

  $packageName = "ghost"
  $packageVersion = "0.5.5"
  $serviceName = "ghost.exe"
  $zipFileName = "ghost-0.5.5.zip"
  $postUnzipDir = ($env:ChocolateyInstall + "\lib\" + $packageName + "." + $packageVersion + 'tools\')

  Write-Host "Stopping the service `'$serviceName`'."
  sc stop $serviceName

  cd $postUnzipDir
  Write-Host "Removing the service `'$serviceName`'."
  node .\DeleteService.js

  # UnInstall Zip
  UnInstall-ChocolateyZipPackage "$packageName" "$zipFileName"

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
