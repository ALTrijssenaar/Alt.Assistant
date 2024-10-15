
function Get-AltComputerInfo {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [ValidateSet('OsName', 'OsType')]
      [string] $Property
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }

   process {
      Write-AltLog -Message "Getting computer info for property [$Property]..."

      (Get-ComputerInfo -Property $Property).$Property

      Write-AltLog -Message "Get computer info for property [$Property]"
   }
}