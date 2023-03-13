Param(
    [Parameter(Mandatory=$true, HelpMessage='prompt:')]
    [Alias('p')]
    [string]$prompt
)
# Defining a Parameter block
# Source - https://liuhongbo.medium.com/how-to-use-chatgpt-cli-with-powershell-d941cb3d7a3c
# Reading the JSON file which holds the apikey
$json = (Get-Content "openai_api.json" -Raw) | ConvertFrom-Json
$apikey = $json.apikey

$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $apikey"
}

$body = @{
    "model" = "text-davinci-003"
    "prompt" = $prompt
    "temperature" = 0.5
    "max_tokens" = 2049
} | ConvertTo-Json

$url = "https://api.openai.com/v1/completions"

$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $body

foreach ($choice in $response.choices){    
    Write-Output($choice.Text.Trim(" ","`r","`n"))
}