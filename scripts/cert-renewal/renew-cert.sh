#!/bin/bash
# Обновление сертификата Let's Encrypt на шлюзе 77gw
# Запуск через cron: 0 2 * * * /usr/local/bin/renew-cert.sh

set -e
LOGFILE="/var/log/cert-renewal.log"

echo "$(date) - Renew started" >> $LOGFILE

# Обновление (учётные данные хранятся в /etc/letsencrypt/regru.ini с правами 600)
certbot renew --quiet --dns-regru --dns-regru-credentials /etc/letsencrypt/regru.ini

# Сборка PEM для HAProxy
cat /etc/letsencrypt/live/alnmand.ru/fullchain.pem \
    /etc/letsencrypt/live/alnmand.ru/privkey.pem \
    > /etc/ssl/private/haproxy-alnmand.ru.pem
chmod 600 /etc/ssl/private/haproxy-alnmand.ru.pem
systemctl reload haproxy

echo "$(date) - HAProxy updated" >> $LOGFILE

# Генерация PFX (пароль должен быть в защищённом файле, здесь заглушка)
# openssl pkcs12 -export -in /etc/letsencrypt/live/alnmand.ru/fullchain.pem -inkey /etc/letsencrypt/live/alnmand.ru/privkey.pem -out /tmp/alnmand.ru.pfx -password pass:$PFX_PASS -certfile /etc/letsencrypt/live/alnmand.ru/chain.pem

echo "$(date) - Done" >> $LOGFILE
