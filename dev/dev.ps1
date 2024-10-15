$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

Import-Module -Name $PSScriptRoot/../src/Alt.Assistant/Alt.Assistant.psd1

Remove-Item -Path ./artifacts -Recurse -Force -ErrorAction SilentlyContinue

Convert-AltAudioMissingMp3 -Path ./data/recording
Convert-AltAudioMissingJson -Path ./data/recording
$assistants = Get-AltAssistants -Path ./data/assistants

$thread = New-Thread
$thread = $thread | Add-ThreadMessage -Message "Maak een gesprek verslag van de volgende conversatie: # " -PassThru
$thread = Start-ThreadRun -Thread $thread -Assistant $assistants['gereatrisch-arts'] | Wait-ThreadRun | Receive-ThreadRun -Wait
$thread

# # Get the latest message from the assistant
# $message = $thread.Messages | Where-Object { $_.role -eq 'assistant' } | Sort-Object -Property created_at -Descending | Select-Object -First 1

# # Remove the thread
# Remove-Thread -ThreadId $thread.id

# # Download the image
# $message.content | Where-Object { $_.Type -eq 'image_file' } | ForEach-Object { 
#    $fileId = $_.image_file.file_id
#    Get-OpenAIFileContent -FileId $fileId -OutFile ./artifacts/$($thread.id)/$fileId.png
# }
