function Get-AltAssistants {
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      $assistantObjects = @(Get-Assistant -All)

      $assistants = @{}
      foreach ($assistant in $assistantObjects) {
         $assistants[$assistant.Name] = $assistant
      }
      return $assistants
   }
}