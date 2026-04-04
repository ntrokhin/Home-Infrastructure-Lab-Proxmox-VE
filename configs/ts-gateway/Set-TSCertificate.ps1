<#
.SYNOPSIS
    Устанавливает сертификат для TS Gateway (RD Gateway)
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$PfxPath,
    [Parameter(Mandatory=$true)]
    [string]$PfxPassword
)

$securePass = ConvertTo-SecureString $PfxPassword -AsPlainText -Force
Import-PfxCertificate -FilePath $PfxPath -CertStoreLocation Cert:\LocalMachine\My -Password $securePass

$cert = Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -eq "CN=alnmand.ru" }
if (-not $cert) {
    Write-Error "Сертификат CN=alnmand.ru не найден"
    exit 1
}

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\TSGateway\Parameters" -Name "SSLCertificateSHA1Hash" -Value $cert.Thumbprint
Restart-Service TSGateway -Force

Write-Host "Сертификат для TS Gateway установлен. Thumbprint: $($cert.Thumbprint)"
