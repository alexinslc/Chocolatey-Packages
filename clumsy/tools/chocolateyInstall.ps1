$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# Add additional functions for packaging
. $(Join-Path $dest "functions.ps1")

# Install Zip
$packageName = 'clumsy'
$url = 'https://github.com/jagt/clumsy/releases/download/0.1/clumsy-0.1-win32.zip'
$url64 = 'https://github.com/jagt/clumsy/releases/download/0.1/clumsy-0.1-win64.zip'
$checksum = 'B8EB28C399F15F02112F5461F6465153'
$checksum64 = 'E75419E28321CDC2CB4CA6F9E4044FD0'
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64" -checksum $checksum -checksum64 $checksum64
$exePath = $dest + '\clumsy.exe'

# Install desktop shortcut
$desktop = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::DesktopDirectory))
$desktopLink = Join-Path $desktop "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $desktopLink -targetPath $exePath

# Install start menu shortcut
$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Programs))
$StartMenuGroup = Join-Path $startMenu "clumsy"
New-Item $StartMenuGroup -type directory -force
$startMenuLink = Join-Path $StartMenuGroup "$packageName.lnk"
Install-ChocolateyShortcut -shortcutFilePath $startMenuLink -targetPath $exePath
