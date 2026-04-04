# Схема сети

```mermaid
flowchart TB
    Internet((Internet))
    Router[MikroTik<br/>dst-nat 443 → 192.168.163.40]
    GW[77gw - HAProxy<br/>192.168.77.40]
    LAN[Internal LAN<br/>192.168.77.0/24]
    DC[dc01<br/>192.168.77.151<br/>DNS]
    ZBX[zabbix<br/>192.168.77.132<br/>Zabbix HTTPS]
    GW01[gw01<br/>192.168.77.143<br/>TS Gateway]
    WSUS[wsus01<br/>192.168.77.144<br/>WSUS]
    USR[usr01<br/>192.168.77.140<br/>RDP host]

    Internet --> Router
    Router -->|порт 443| GW
    GW -->|SNI zabbix| ZBX
    GW -->|SNI rdp| GW01
    GW -->|default| GW01
    GW -.-> LAN
    LAN --> DC
    LAN --> ZBX
    LAN --> GW01
    LAN --> WSUS
    LAN --> USR
Поток трафика
Запрос	SNI	Направление
https://zabbix.alnmand.ru	zabbix.alnmand.ru	→ 192.168.77.132:443
rdp.alnmand.ru (mstsc)	rdp.alnmand.ru	→ 192.168.77.143:443
любой другой (без SNI)	отсутствует	default → 192.168.77.143:443
