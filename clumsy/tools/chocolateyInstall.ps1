$dest = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

# Add additional functions for packaging
. $(Join-Path $dest "functions.ps1")

# Install Zip
$packageName = 'clumsy' # arbitrary name for the package, used in messages
$url = 'https://github.com/jagt/clumsy/releases/download/0.1/clumsy-0.1-win64.zip' # download url
$url64 = $url # 64bit URL here or remove - if installer decides, then use $url
Install-ChocolateyZipPackage "$packageName" "$url" "$dest" "$url64"
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
