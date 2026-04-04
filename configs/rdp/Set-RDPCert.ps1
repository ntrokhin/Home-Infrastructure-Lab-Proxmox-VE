<#
.SYNOPSIS
    Устанавливает сертификат для служб удалённых рабочих столов (RDP)
#>
param(
    [string]$PfxPath = "C:\certs\alnmand.ru.pfx",
    [string]$PfxPassword = "CHANGE_ME"
)

$securePass = ConvertTo-SecureString $PfxPassword -AsPlainText -Force
Import-PfxCertificate -FilePath $PfxPath -CertStoreLocation Cert:\LocalMachine\My -Password $securePass

$thumb = (Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -eq "CN=alnmand.ru" }).Thumbprint

wmic /namespace:\\root\cimv2\TerminalServices PATH Win32_TSGeneralSetting Set SSLCertificateSHA1Hash="$thumb"
Restart-Service TermService -Force
Write-Host "RDP сертификат установлен. Перезапущена служба TermService."
