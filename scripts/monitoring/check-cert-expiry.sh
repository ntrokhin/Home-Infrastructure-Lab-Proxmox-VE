#!/bin/bash
# Проверка срока действия сертификата для Zabbix (возвращает количество дней)
CERT_FILE="/etc/letsencrypt/live/alnmand.ru/fullchain.pem"
if [ ! -f "$CERT_FILE" ]; then
    echo "0"
    exit 1
fi

EXPIRY_DATE=$(openssl x509 -enddate -noout -in "$CERT_FILE" | cut -d= -f2)
EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s)
NOW_EPOCH=$(date +%s)
DAYS_LEFT=$(( ($EXPIRY_EPOCH - $NOW_EPOCH) / 86400 ))

echo $DAYS_LEFT
