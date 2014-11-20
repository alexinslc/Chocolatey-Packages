# Install Zip
$packageName = "ghost"
$serviceName = "Ghost"
$packageVersion = "0.5.5"

# Build postUnzipDir could clean this up later with Join-Path
$packageDir = ($env:ChocolateyInstall + "\lib\" + $packageName + "." + $packageVersion)
$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$configDir = Join-Path $packageDir "config"
$url = "https://ghost.org/zip/ghost-0.5.5.zip"
$url64 = $url
$checksum = '066B9A1377128C325829657FE7441BCE'
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64" -checksum $checksum
# Copy over special configuration files
Copy-Item $configDir\* $dest -Force

# Install the node_modules via npm
Write-Host "Installing node modules."
cd $dest
npm config set loglevel silent
npm install --production
npm config set loglevel warn

# Create the windows service
Write-Host "Creating the service for `'$packageName`' with the name of `'$serviceName`'"
node .\CreateService.js

Write-ChocolateySuccess $packageName
