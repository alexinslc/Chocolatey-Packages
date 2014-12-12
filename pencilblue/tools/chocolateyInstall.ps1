# Install Zip
$packageName = "pencilblue"
$serviceName = "PencilBlue"
$packageVersion = "0.3.0"

# Build postUnzipDir could clean this up later with Join-Path
$packageDir = ($env:ChocolateyInstall + "\lib\" + $packageName + "." + $packageVersion)
$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$configDir = Join-Path $packageDir "config"
$url = "https://github.com/pencilblue/pencilblue/archive/0.3.0.zip"
$url64 = $url
$checksum = '1F0D63A6C47B6563C85F7F26EB5010B7'
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
