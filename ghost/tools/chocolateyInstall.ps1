try {
  $toolsDir ="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  Start-ChocolateyProcessAsAdmin "& $($toolsDir)\installghost.ps1"

  Write-ChocolateySuccess 'ghost'
} catch {
  Write-ChocolateyFailure 'ghost' "$($_.Exception.Message)"
  throw
}
