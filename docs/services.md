# Описание сервисов

## Zabbix
- **URL**: https://zabbix.alnmand.ru
- **Внутренний сервер**: 192.168.77.132:443 (Apache с SSL)
- **Сертификат**: Let's Encrypt wildcard

## TS Gateway (RD Gateway)
- **Внешний адрес**: rdp.alnmand.ru
- **Внутренний сервер**: 192.168.77.143:443
- **Политики CAP/RAP**: разрешён доступ доменным пользователям ко всем RDP-хостам

## WSUS
- **Внутренний адрес**: https://wsus01.alnmand.ru:8531
- **Сертификат**: Let's Encrypt wildcard (привязка в IIS)

## RDP на конечных серверах
- **Серверы**: usr01.alnmand.ru, dc01.alnmand.ru
- **Сертификат**: установлен через PowerShell (CN=alnmand.ru)
