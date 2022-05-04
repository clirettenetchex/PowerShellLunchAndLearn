[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, HelpMessage="Title to be used in the Pull Request")]
    [string]$Title,

    [Parameter(Mandatory=$true, HelpMessage="The repo to make a PR for")]
    [ValidateSet("PayHistory", "GeneralLedger")]
    [string]$Repo,

    [Parameter(Mandatory=$false, HelpMessage="Include James Parker and Liam Oliver among PR reviewers")]
    [Switch]$IncludeReviewers
)

$api = Get-Content C:\Users\Clirette\code\AzureDevopsPowershell\all-repos.json | Convertfrom-json | Where-Object { $_.name -like "*$Repo*" }
$apiName = $api | Select-Object -ExpandProperty name

Push-Location
Set-Location C:\Working\$apiName

$sourceBranch = git branch --show-current

$token = "57oo4mvqr2tpw7b5w3loeckwfu4o6nw3sihfcvvlwoxgqimlddza"
$headers = @{
    Authorization = "Basic {0}" -f [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$token"))
}

$workItemURL = "https://dev.azure.com/netchexonline/Netchex%20Rewrite/_apis/wit/workitems/$($sourceBranch.Split('.')[1])?api-version=6.0"
$workItemToLink = Invoke-RestMethod -Method 'Get' -Headers $headers -Uri $workItemURL


$targetBranch = $sourceBranch -replace '.dev', '.release'

$body = @{
    sourceRefName = "refs/heads/$sourceBranch"
    targetRefName = "refs/heads/$targetBranch"
    title = $title
    isDraft = $true
    workItemRefs = @(@{ id = $workItemToLink.id; url = $workItemToLink.url })
}

if ($IncludeReviewers)
{
    $reviewers = @(
        @{ isRequired = $false; id = "1f01dda8-312f-606c-8a4b-1be481535323" }, # liam
        @{ isRequired = $false; id = "af5ff616-d077-60d5-ab56-7d4e45f85b1a" }  # james
        )
        
    $body.reviewers = $reviewers
}
    
$jsonBody = $body | ConvertTo-Json
    
$apiId = $api | Select-Object -ExpandProperty id
$url = "https://dev.azure.com/netchexonline/Netchex%20Rewrite/_apis/git/repositories/$apiId/pullrequests?api-version=6.0"
$pr = Invoke-RestMethod -Uri $url -Headers $headers -Method 'POST' -Body $jsonBody -ContentType 'application/json'

$prURL = "https://dev.azure.com/netchexonline/Netchex%20Rewrite/_git/$apiName/pullrequest/$($pr.pullRequestId)"
Start-Process $prURL

Pop-Location