Function Use-CurrentPathToClipboard {
    
    if ($PSVersionTable['PSVersion'].Major -ge 5) {
        Set-Clipboard -Value $($psISE.CurrentFile.FullPath | Split-Path -Parent)
    } else {
        $psISE.CurrentFile.FullPath | Split-Path -Parent | Clip.exe
    }

}
