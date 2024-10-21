function Remove-AltAssistants {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $Path
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      $assistants = Get-AltAssistants

      Get-ChildItem -Path $Path -Filter *.json | ForEach-Object {
         $assistant = $assistants[$_.BaseName]
         if ($assistant) {
            Remove-Assistant -AssistantId $assistant.id
         }
      }
   }
}