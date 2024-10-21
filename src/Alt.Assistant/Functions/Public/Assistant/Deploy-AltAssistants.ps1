function Deploy-AltAssistants {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $Path
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      $assistants = Get-AltAssistants 

      $modified = $false
      Get-ChildItem -Path $Path -Filter *.json | ForEach-Object {
         $assistantConfig = Get-Content -Path $_ | ConvertFrom-Json
         $assistantConfig | Add-Member -MemberType NoteProperty -Name Name -Value $_.BaseName

         $assistant = $assistants[$_.BaseName]
         if (-not $assistant) {
            $assistant = $assistantConfig | New-AltAssistant
            $modified = $true
         }
      }

      if ($modified) {
         $assistants = Get-AltAssistants
      }

      return ($assistants)
   }
}