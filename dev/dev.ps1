$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

Import-Module -Name $PSScriptRoot/../src/Alt.Assistant/Alt.Assistant.psd1
Remove-Item -Path ./artifacts -Recurse -Force -ErrorAction SilentlyContinue

Remove-AltAssistants -Path ./data/assistants
Convert-AltAudioMissingMp3 -Path ./data/recording
Convert-AltAudioMissingJson -Path ./data/recording
Convert-AltReportMissingMd -Path ./data/recording -Assistant gereatrisch-arts