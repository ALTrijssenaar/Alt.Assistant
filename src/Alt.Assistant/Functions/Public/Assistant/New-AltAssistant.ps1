function New-AltAssistant {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
      [string] $Name,
      [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
      [string] $Instructions,
      [Parameter(ValueFromPipelineByPropertyName = $true)]
      [bool] $UseCodeInterpreter,
      [Parameter(ValueFromPipelineByPropertyName = $true)]
      [string] $Model,
      [Parameter(ValueFromPipelineByPropertyName = $true)]
      [string] $Temperature
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      return New-Assistant -Name $Name -Instructions $Instructions -UseCodeInterpreter:$UseCodeInterpreter -Model $Model -Temperature $Temperature
   }
}