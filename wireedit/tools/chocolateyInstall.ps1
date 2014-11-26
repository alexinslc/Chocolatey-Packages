$packageName = 'wireedit'
$installerType = 'msi'
$url = 'https://wireedit.com/WireEditiWin7-0.11.430.msi'
$silentArgs = '/quiet'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
