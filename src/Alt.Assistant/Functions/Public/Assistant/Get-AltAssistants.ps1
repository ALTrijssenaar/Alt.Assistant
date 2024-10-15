function Get-AltAssistants {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $Path
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      $assistantObjects = @(Get-Assistant -All)

      Get-ChildItem -Path $Path -Filter *.json | ForEach-Object {
         $assistantConfig = Get-Content -Path $_ | ConvertFrom-Json
         $assistantConfig | Add-Member -MemberType NoteProperty -Name Name -Value $_.BaseName

         $assistant = $assistantObjects | Where-Object { $_.name -eq $assistantConfig.Name } | Select-Object -First 1
         if (-not $assistant) {
            $assistant = $assistantConfig | New-AltAssistant
         }
      }

      # Convert object array to key value pair
      $assistants = @{}
      foreach ($assistant in $assistantObjects) {
         $assistants[$assistant.Name] = $assistant
      }
      return $assistants
   }
}