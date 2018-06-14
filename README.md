# docker-ducky

Checky

Cheky vous permet de suivre gratuitement, en fonction de vos critères de recherche, les nouvelles annonces mises en ligne sur Leboncoin et Seloger.com. En outre, afin d'en conserver une trace, Cheky vous permet de sauvegarder les annonces Leboncoin.

À quoi sert cette application ?

Lorsqu'une ou plusieurs annonces sont mises en ligne, celle-ci sont envoyées via des alertes par différents moyens :

Recevoir des alertes mails sur vos recherches.
Générer des flux RSS pour vos recherches.
Recevoir des alertes SMS pour les abonnés Free Mobile.
Compléter vos recherches avec des filtres supplémentaires (multi-categories, multi-villes, etc.).

Démarrer l'application

Lancer l'image docker en l'expostant sur le port 80 et lier le volume /var/www/html/var/

$ docker run -d --name=cheky -p 80:80 -v <data_dir>:/var/www/html/var/ leto1210/docker-cheky:latest

Exemple Docker-compose file

checky:
  image: leto1210/docker-cheky:latest 
  container_name: checky
  restart: always
  environment: 
    - CHEKY_BASEURL=http://lbc.ndd.com/
    - CHEKY_ADMIN_PASSWORD=password
    - CHEKY_ADMIN_PASSWORD_SHA1=passwordsha1
    - CHEKY_MAILER_SMTP_HOST=host.ndd.com
    - CHEKY_MAILER_SMTP_PORT=587
    - CHEKY_MAILER_SMTP_USERNAME=mail@ndd.com
    - CHEKY_MAILER_SMTP_PASSWORD=X5zu3RRF7NTumo2
    - CHEKY_MAILER_SMTP_SECURE=tls
    - CHEKY_MAILER_FROM=mail@ndd.com
    - CHEKY_CRON_INTERVAL="*/5 * * * *"
  volumes:
    - /mnt/docker/checky:/var/www/html/var/

Environment variables

CHEKY_BASEURL : url de votre checky
CHEKY_ADMIN_PASSWORD : mot de passe du compte Administrateur
CHEKY_ADMIN_PASSWORD_SHA1 : mot de passe du compte Administrateur (ne pas l'oublier)
Ne pas oublier d'utiliser un mot de passe fort pour le compte administrateur!


Port
80 : HTTP Nextcloud port
Volumes
/var/www/html : Data de checky
