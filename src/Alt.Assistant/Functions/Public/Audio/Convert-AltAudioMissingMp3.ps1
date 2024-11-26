function Convert-AltAudioMissingMp3 {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $Path
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      Get-ChildItem -Path $Path -Filter *.m4a | ForEach-Object {
         $sourceFilePath = $_.FullName
         $targetFilePath = $_.FullName -replace '\.m4a$', '.mp3'
      
         Convert-AltAudioM4a2Mp3 -SourceFilePath $sourceFilePath -TargetFilePath $targetFilePath
      }  
   }
}