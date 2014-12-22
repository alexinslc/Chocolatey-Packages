$packageName = 'wireedit'
$installerType = 'msi'
$url = 'https://wireedit.com/0.11.462/WireEditWin7-0.11.462.msi'
$silentArgs = '/quiet'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
