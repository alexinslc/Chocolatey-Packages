$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# Add additional functions for packaging
. $(Join-Path $dest "functions.ps1")

# Install Zip
$packageName = 'clumsy'
$url = 'https://github.com/jagt/clumsy/releases/download/0.2/clumsy-0.2-win32.zip'
$url64 = 'https://github.com/jagt/clumsy/releases/download/0.2/clumsy-0.2-win64.zip'
$checksum = '9AAB0D257661A4F75831A7186254725B'
$checksum64 = 'C5117EDAD320930D14D18C1CAC2A4CCD'
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
