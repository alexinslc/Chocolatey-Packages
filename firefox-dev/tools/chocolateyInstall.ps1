$packageName = 'firefox-dev' # arbitrary name for the package, used in messages
$installerType = 'exe'
$url = 'http://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora/firefox-35.0a2.en-US.win32.installer.exe'
$silentArgs = '-ms'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
