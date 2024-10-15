function Convert-AltAudioM4a2Mp3 {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $SourceFilePath,
      [Parameter(Mandatory = $true)]
      [string] $TargetFilePath
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      if (-not (Test-Path $TargetFilePath)) {
         Write-AltLog -Message "Converting ${SourceFilePath} to ${TargetFilePath}..."
         Invoke-AltExecutable -ScriptBlock {
            ffmpeg -i ${SourceFilePath} -c:v copy -c:a libmp3lame -q:a 4 ${TargetFilePath}
         }
      }
   }
}