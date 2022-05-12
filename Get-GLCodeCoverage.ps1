Push-Location
Set-Location C:\Working\Netchex.GeneralLedger.Api

Start-Process -Wait dotnet -ArgumentList 'test', '--collect:"XPlat Code Coverage"' -NoNewWindow

$reportID =  Get-ChildItem .\src\Tests\TestResults\ | Select-Object -ExpandProperty Name

Start-Process -Wait reportgenerator -ArgumentList "-reports:`"C:\Working\Netchex.GeneralLedger.Api\src\Tests\TestResults\$($reportID)\coverage.cobertura.xml`" -targetdir:`"coveragereport`" -reporttypes:Html" -NoNewWindow
Start-Process -Wait .\coveragereport\index.html

Remove-Item -Recurse C:\Working\Netchex.GeneralLedger.Api\src\Tests\TestResults
Pop-Location





































# SIG # Begin signature block
# MIIFlAYJKoZIhvcNAQcCoIIFhTCCBYECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXALq7BmotJPL7+aAvw+Edeiv
# 7HigggMiMIIDHjCCAgagAwIBAgIQUBgRLbuX0rJLs6GH/OgehzANBgkqhkiG9w0B
# AQsFADAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MB4X
# DTIyMDUwNjE5Mzg1M1oXDTIzMDUwNjE5NTg1M1owJzElMCMGA1UEAwwcUG93ZXJT
# aGVsbCBDb2RlIFNpZ25pbmcgQ2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBAL/aV5lH/+auyAohVNCdkHAQVnrbXgSNVWVkgABY12tewTrZtmP/Dh3C
# IW3dj1zwploCNHKYbjE6EHBXaa2a1141F/A+OYtvpvesMXlhhA4CEZDG9Sajuxjj
# r6BU6OA+NW+wxoMgJUvp2i1tWIMraOPPo9OXoOvJ4Q6xYNYu1tUqPEMUUlu70bLX
# swqPFEffP3Ed4JTC8byprHh+iM9iF9P1S+5PWG5sAXm5rkCqn2D8csxYeWrqJaT8
# 5GgLvV1BxHxgjl2wn0HfSfNGevW3kziQlVP3VtcNALOscbqXJtIk3RVhUyjNUnQm
# 1ZlVWV6PstGvOSm4gnK7PZSTClvH3y0CAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSW5M1Ib3QPiYia1UI6sol1
# 0s2Y6DANBgkqhkiG9w0BAQsFAAOCAQEAsJCKTzD+Ay0kuVGAvmAZ5Zgw4Qc81TcZ
# nTWtxXja96e0nFWhAN14rYMEIcHNnhL5G0VtaT8wH1ae/aqJzk0Z7fFgAYmH2FNI
# AZv8VwQxZSSD4datZIPwrc79dHOrEu+MhDFRqfsI/SgOyVJudlLDZ+RN2ZTcnJpu
# +AblXU8OIUIXpG4yBYHDMMUUDoC0GXNeiuApvrIQJ5SKB8CQGb/ssSFT+ErUSgA8
# dU5MDgGF0PAii+gIyodERo7qywZ+sYSbRZnmgY0nSU+/Zyn9fFTkbgsJ1A0IZxIB
# OMF1fd7V44+nRbKRZTZaQHTptWD6MEOfHrR0O9i/yzLoHbHDolf/tzGCAdwwggHY
# AgEBMDswJzElMCMGA1UEAwwcUG93ZXJTaGVsbCBDb2RlIFNpZ25pbmcgQ2VydAIQ
# UBgRLbuX0rJLs6GH/OgehzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUKJ9Q5BmuWijQDrgc2OPV
# N7hGLGMwDQYJKoZIhvcNAQEBBQAEggEAki3KFqtGi/erlI88zaTFQT1ZeC25/SdD
# kBFW8aSPJDejwGu3bEVo/rj1nHQbnzXn7R84NLiDSAk476AylwGBnbkMXeiKC2Ba
# KcmIhE7OAEUZFvZUuMTJoCM9jj8ENLkDCdbw0UPyf9ZTzbQWIkUGcowF87Eqc7Ln
# ApqgBKtHw9ZNdHH9uvFBx4z2M5JpKHxnVAPYsFcW1wEMDstqTqgRi1K59h4fxIWG
# MTrktrmHeT3d3gY4ITIfF/WTtWfnXWDYeHtrkTAsaaUk11QnvShNxiEP1R+ve7RB
# o3YIO4noQzchAddhP1RuAZLrj8cILe8JWUfJor1NsKfm4roiEiiirA==
# SIG # End signature block
