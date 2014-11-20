try {
  $packageName = "ghost"
  $serviceName = "ghost.exe"
  $binRoot = Get-BinRoot
  $ghostInstallDir = Join-Path $binRoot $packageName
  $toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $ghostPackageDir = Join-Path $toolsDir $packageName
  if ($ghostInstallDir) {
    Write-Host "$packageName is already installed. Nothing to do."
  }
  else {
    Copy-Item $ghostPackageDir\* $ghostInstallDir -Force -Recurse
    cd $ghostInstallDir
    Write-Host "Installing $packageName..."
    npm install --production
    Write-Host ("Creating the " + $packageName + " service as " + $serviceName)
    node .\CreateService.js
    Write-ChocolateySuccess $packageName
  }
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
