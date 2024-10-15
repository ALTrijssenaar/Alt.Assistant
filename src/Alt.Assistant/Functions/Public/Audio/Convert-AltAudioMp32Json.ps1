function Convert-AltAudioMp32Json {
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
         Request-AudioTranscription -File ${SourceFilePath} -Format json -Model whisper-1 -Language nl-NL -TimestampGranularities segment | Set-Content -Path ${TargetFilePath}
      }
   }
}