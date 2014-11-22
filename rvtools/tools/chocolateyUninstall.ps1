$packageName = 'rvtools'
$packageVersion = '3.6.4'

try {
  $app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq $packageName  -and ($_.Version -eq $packageVersion) }
  $result = $app.Uninstall();

  Write-ChocolateySuccess $packageName
}
catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}
