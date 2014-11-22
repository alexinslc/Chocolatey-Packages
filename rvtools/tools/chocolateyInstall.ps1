$packageName = 'rvtools'
$installerType = 'msi' #only one of these: exe, msi, msu
$url = 'http://robware.net/download/501D8EE9-B871-45FB-B2A1-9BE0B7BFF025/RVTools.msi' # download url
$silentArgs = '/quiet' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
