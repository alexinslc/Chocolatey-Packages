$packageName = 'wireedit'
$installerType = 'msi'
$url = 'https://wireedit.com/WireEditiWin7-0.11.430.msi'
$silentArgs = '/quiet' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
