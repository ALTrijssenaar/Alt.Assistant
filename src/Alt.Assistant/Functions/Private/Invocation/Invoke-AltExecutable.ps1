function Invoke-AltExecutable {
   [CmdletBinding(SupportsShouldProcess)]
   param (
      [Parameter(Mandatory = $true)]
      [scriptblock] $ScriptBlock
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      if ($PSCmdlet.ShouldProcess($ScriptBlock)) {
         Invoke-Command -ScriptBlock $ScriptBlock
         if ($LASTEXITCODE) { 
            throw "Detected a non zero exit code. The exit code was $LASTEXITCODE."
         }
      }
   }
}