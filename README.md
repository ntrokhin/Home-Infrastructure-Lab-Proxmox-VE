# Home Infrastructure Lab (Proxmox VE)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen)]()

> Домашняя лабораторная инфраструктура на базе Proxmox VE с доменом `alnmand.ru`, reverse proxy HAProxy, Zabbix, TS Gateway, WSUS и Let's Encrypt.

## Компоненты

| Сервер | IP (внутр.) | Роль |
|--------|-------------|------|
| 77gw | 192.168.77.40 | Шлюз, NAT, HAProxy |
| dc01 | 192.168.77.151 | DC, DNS (split-DNS) |
| zabbix | 192.168.77.132 | Zabbix Server + Apache (HTTPS) |
| gw01 | 192.168.77.143 | TS Gateway (RD Gateway) |
| wsus01 | 192.168.77.144 | WSUS (IIS, порт 8531) |
| usr01 | 192.168.77.140 | Файловый сервер / RDP-хост |

## Доступ извне

- `https://zabbix.alnmand.ru` → Zabbix
- `rdp.alnmand.ru` → TS Gateway (RDP поверх HTTPS)

## Конфигурации

Все конфиги в папке [`configs/`](configs/).

## Мониторинг

Zabbix + скрипты проверки срока сертификата в [`scripts/monitoring/`](scripts/monitoring/).

## Связанные проекты

- **[proxmox-iac-terraform](https://github.com/ntrokhin/proxmox-iac-terraform)** — Infrastructure as Code: автоматизация развёртывания ВМ в Proxmox через Terraform и CI/CD (Gitea Actions).

## Автор

**ntrokhin**
