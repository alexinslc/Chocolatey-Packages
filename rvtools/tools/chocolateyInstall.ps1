$packageName = 'rvtools'
$installerType = 'msi'
$url = 'http://robware.net/download/501D8EE9-B871-45FB-B2A1-9BE0B7BFF024/RVTools3.9.3.msi'
$silentArgs = '/quiet'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
