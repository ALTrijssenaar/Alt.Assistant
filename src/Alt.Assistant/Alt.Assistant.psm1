$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# Install and import PSOpenAI if not done yet
if (-not (Get-Module -Name PSOpenAI -ListAvailable)) {
   Install-Module -Name PSOpenAI -Scope CurrentUser -Force -AllowClobber
}

# Load all private functions
$privateScripts = Get-ChildItem -Path $PSScriptRoot/Functions/Private -File -Filter '*.ps1' -Recurse -Exclude '*.Tests.ps1'
foreach ($script in $privateScripts) {
   . $script.FullName
}

# Load all public functions and export them
$publicScripts = Get-ChildItem -Path $PSScriptRoot/Functions/Public -File -Filter '*.ps1' -Recurse -Exclude '*.Tests.ps1'
foreach ($script in $publicScripts) {
   . $script.FullName
   Export-ModuleMember -Function $script.BaseName
}