{{ .CHEKY_CRON_INTERVAL }} root /usr/local/bin/php /var/www/html/check.php > /var/log/cron.log 2>&1
