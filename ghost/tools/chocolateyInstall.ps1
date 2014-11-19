$packageName = 'ghost'
$url = 'https://ghost.org/zip/ghost-0.5.5.zip'
$url64 = $url
Install-ChocolateyZipPackage "$packageName" "$url" "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" "$url64"
