try {
  $packageName = "ghost"
  $serviceName = "ghost.exe"
  $binRoot = Get-BinRoot
  $ghostDir = Join-Path $binRoot $packageName

  # If Ghost is installed, uninstall it. Else, give a message.
  if ($ghostDir) {
    # Enter the ghost directory for uninstallation
    cd $ghostDir

    # Stop the ghost windows service
    Write-Host "Stopping the service `'$serviceName`'."
    & sc stop $serviceName

    # Remove the ghost windows service
    Write-Host "Removing the service `'$serviceName`'."
    node .\DeleteService.js

    # Remove the installation files
    Write-Host "Removing files at `'$ghostDir`'."
    Remove-Item $ghostDir -Recurse -Force

    Write-ChocolateySuccess $packageName
  } else {
      Write-Host "$packageName is not installed on the system. Nothing to do."
  }
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
