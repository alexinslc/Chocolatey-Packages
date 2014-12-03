$packageName = 'angryip'
$installerType = 'exe'
$url = 'http://github.com/angryziber/ipscan/releases/download/3.3.2/ipscan-3.3.2-setup.exe'
$url64 = $url
$silentArgs = '/S'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"
