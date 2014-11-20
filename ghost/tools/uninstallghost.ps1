try {
  $packageName = "ghost"
  $serviceName = "ghost.exe"
  $binRoot = Get-BinRoot
  $ghostDir = Join-Path $binRoot $packageName
  if ($ghostDir) {
    cd $ghostDir
    Write-Host "Stopping the service `'$serviceName`'."
    & sc stop $serviceName
    Write-Host "Removing the service `'$serviceName`'."
    node .\DeleteService.js
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
