<#
.Synopsis
    Opens a module in Powershell ISE
.DESCRIPTION
    Opens a dialog for users to select a .PSD1 file.
    It opens all the files found in the module into a new powershell tab.



    --- Script Details ---
    Author: Brent Wright
    Date Created: 06/04/2016
    Date Updated: mm/dd/yyyy

   

.EXAMPLE
    Open-Module
.NOTES
    Updates:
      mm/dd/yyyy - UserName - Fixed a bug, or added a feature, etc...

#>

Function Use-OpenModule {
    
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $extToIgnore = @('.dll')
    
    #region Prepare file dialog

    $FileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $FileDialog.Title = "Open Module"
    $FileDialog.InitialDirectory = $profile | Split-Path -Leaf
    $FileDialog.Filter = "PSD1|*.PSD1"
    $FileDialog.ValidateNames = $false
    $FileDialog.CheckFileExists = $true
    $FileDialog.CheckPathExists = $true

    Write-Verbose "Showing OpenFileDialog window"
    $userChoice = $FileDialog.ShowDialog()
    
    #endregion Prepare file dialog

    
    #region Open selected module.
    
    Write-Debug "User clicked: $userChoice"

    if ($userChoice -eq [System.Windows.Forms.DialogResult]::OK) {

        $selectedFolder = $FileDialog.FileName | Split-Path -Parent
        $selectedModuleManifest = $FileDialog.FileName
        
        $counter = 0

        Write-Verbose "User chose: $selectedFolder"

        $moduleName = $selectedFolder | Split-Path -Leaf

        if (Test-Path $selectedModuleManifest) {


            $newTab = $psISE.PowerShellTabs.Add()
            $newTab.DisplayName = $moduleName
            
            Get-ChildItem $selectedFolder -Recurse -File | ForEach-Object {
                
                if ($_.Extension -in $extToIgnore) {
                    
                    Write-Verbose "Ignoring file `"$($_.Name)`" - Extension is on ignore list."

                } else {
                    
                    Write-Verbose "Opening file `"$($_.Name)`""
                    $newTab.Files.Add($_.FullName) | Out-Null

                    $counter++
                }
                
            }

            # Set the active page to new tab, and the first file in the module.
            $newTab.ExpandedScript = $true
            $newtab.files.SelectedFile = $newTab.Files[0]
            $psISE.PowerShellTabs.SelectedPowerShellTab = $newTab

            Write-Verbose "$counter file(s) opened for $moduleName."


        } else {
            [System.Windows.Forms.MessageBox]::Show("Unable to open module.`n$moduleName.PSD1 file not present in folder.", "Open Module") | Out-Null

            Write-Verbose "ModuleManifest not found"
        }

    }
    

    #endregion Open selected module.

}
