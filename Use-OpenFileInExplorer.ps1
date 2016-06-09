<#
.Synopsis
    Short description
.DESCRIPTION
    Long description



    --- Script Details ---
    Author: Brent Wright
    Date Created: mm/dd/yyyy
    Date Updated: mm/dd/yyyy

   

.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.NOTES
    Updates:
      mm/dd/yyyy - UserName - Fixed a bug, or added a feature, etc...

#>

Function Use-OpenFileInExplorer {
    explorer $($psISE.CurrentFile.FullPath | Split-Path -Parent) | Out-Null
}