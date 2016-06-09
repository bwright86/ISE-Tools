
# Load addons
Get-ChildItem (Join-Path $PSScriptRoot "\ISEAddOns") -Recurse -File -Filter "*.PS1" | foreach {. "$($_.FullName)"}

