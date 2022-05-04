#Requires -Version 7
#Requires -PSEdition Core

$cloneDirectoryName = 'temporaryCloneDirectory'

$remoteUrl = "https://netchexonline@dev.azure.com/netchexonline/Netchex%20Rewrite/_git/Netchex.GeneralLedger.Api"
$targetBranch = "main"
$sourceBranch = "release.candidate"

$clonePath = $PSScriptRoot | Join-Path -ChildPath $cloneDirectoryName

Write-Host "Cloning into Netchex.GeneralLedger.Api... `n"

git clone $remoteUrl $clonePath --quiet

Push-Location
Set-Location $clonePath

git checkout $sourceBranch --quiet

$diffs = git cherry main 
    | Where-Object { $_.StartsWith("+") } 
    | ForEach-Object { 
        $commitSha = $_.Substring(2)
        $author = git show -s --format='%an' $commitSha
        $date = git show -s --format='%ci' $commitSha
        [pscustomobject]@{ commit = $commitSha; author = $author; date = $date } } 
    | Sort-Object -Property date -Descending

if ($diffs.Count -gt 0)
{
    Write-Host "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
    Write-Host "🚀 Eligible for release!  🚀"
    Write-Host "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀`n"
    Write-Host "Found $($diffs.Count) commits in $sourceBranch that are not in $targetBranch"
    Write-Host "Authors in order of most recent changes:`n"
    Write-Host "$($diffs | Select-Object -ExpandProperty author -Unique | Join-String -Separator `n)"
    Write-Host
}
else
{
    Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
    Write-Host "❌ No changes slated for release  ❌"
    Write-Host "❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌`n"
}

Pop-Location
Remove-Item $clonePath -Recurse -Force
