function Convert-AltReportMissingMd {
   [CmdletBinding()]
   param (
      [Parameter(Mandatory = $true)]
      [string] $Path,
      [Parameter(Mandatory = $true)]
      [string] $Assistant
   )
   begin { . "$PSScriptRoot/../../begin.ps1" -InvocationInfo $MyInvocation }
   end { . "$PSScriptRoot/../../end.ps1" -InvocationInfo $MyInvocation }
    
   process {
      $assistans = Deploy-AltAssistants -Path ./data/assistants

      Get-ChildItem -Path $Path -Filter *.json | ForEach-Object {
         $transcription = Get-Content -Path $_.FullName
         $templateFilePath = "./data/assistants/${Assistant}/template-$($_.BaseName.Split('-')[0]).md"
         $template = Get-Content -Path $templateFilePath

         $reportFilePath = $_.FullName -replace '\.json$', '.report.md'

         if (-not (Test-Path $reportFilePath)) {
            $thread = New-Thread
            $thread = $thread | Add-ThreadMessage -Message "
         
Maak een gesprek verslag van de volgende conversatie en gebruik daarvoor onderstaande template. Probeer alle vragen in te vullen en als je iets niet weet geef dat dan aan met ONBEKEND.

Gesprekverslag:
\`\`\`json
${transcription}
\`\`\`

Template:
\`\`\`md
${template}
\`\`\`

" -PassThru

            $thread = Start-ThreadRun -Thread $thread -Assistant $assistans[$Assistant] | Wait-ThreadRun | Receive-ThreadRun -Wait
            $summary = $thread.Messages | Where-Object { $_.Role -eq 'assistant' } | Select-Object -Last 1 | ForEach-Object { $_.SimpleContent.Content }
            $summary | Out-File -FilePath $reportFilePath
         }
      } 
   }
}        