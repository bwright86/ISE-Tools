Function Use-CurrentPathToClipboard {
    
    Set-Clipboard -Value $($psISE.CurrentFile.FullPath | Split-Path -Parent)
}
