try {
  # Install Zip
  $packageName = "ghost"
  $serviceName = "ghost.exe"
  $packageVersion = "0.5.5"

  # Build postUnzipDir could clean this up later with Join-Path
  $postUnzipDir = ($env:ChocolateyInstall + "\lib\" + $packageName + "." + $packageVersion)
  $dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $url = "https://ghost.org/zip/ghost-0.5.5.zip"
  $url64 = $url
  $checksum = '066B9A1377128C325829657FE7441BCE'
  Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64" -checksum $checksum

  # Copy over special configuration files
  Copy-Item $dest\CreateService.js $postUnzipDir > $null
  Copy-Item $dest\DeleteService.js $postUnzipDir > $null
  Copy-Item $dest\index.js $postUnzipDir -Force > $null
  Copy-Item $dest\package.json $postUnzipDir -Force > $null

  # Install the node_modules via npm
  Write-Host "Installing node modules."
  cd $postUnzipDir
  npm install --production

  # Create the windows service
  Write-Host ("Creating the " + $packageName + " service as " + $serviceName)
  node .\CreateService.js

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
