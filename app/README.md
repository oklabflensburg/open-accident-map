# open-accident-map

Offene Daten der Unfallstatistik des BKG auf einer interaktiven webbasierten Karte


## Warning

[Demo beta](https://beta.open-accident-map.de/query/flensburg)

This version of our interactive map is based on Nuxt 3 and OpenLayers and has
breaking changes. Please be aware using this beta version on your own risk.


## Setup System

Install dependencies which been used by this project

```
sudo apt install gnupg2
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > postgresql-keyring.gpg
sudo mv postgresql-keyring.gpg /etc/apt/trusted.gpg.d/
sudo chown root:root /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod ugo+r /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod go-w /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
echo "deb [arch=amd64, signed-by=/etc/apt/trusted.gpg.d/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgis postgresql-14-postgis-3
```


## Setup Database

Now get your hands dirty

```
sudo apt install libpq-dev
sudo -i -u postgres
createuser --interactive --pwprompt
createdb postgis_db -O postgis_user
psql -d postgis_db
CREATE EXTENSION postgis;
SELECT PostGIS_version();
```

Change diretory to the path where your dump is stored

```
sudo -i -u postgres dropdb postgis_db
sudo -i -u postgres createdb -O postgis_user postgis_db
psql -h localhost -d postgis_db -U postgis_user -f meta.sql
sudo -i -u postgres psql -d postgis_db < dump.sql
```


## Setup Application

```
sudo apt install python3.10 virtualenv tree git jq
git clone https://github.com/p3t3r67x0/open-accident-map.git
cd open-accident-map
virtualenv venv
. venv/bin/activate
pip install -r requirements.txt
```


## Setup Service

```
sudo vim /etc/systemd/system/api-open-accident-map.service
```

```
[Unit]
Description=API instance to serve the backend
After=network.target
Requires=postgresql.service

[Service]
Type=simple
User=www-data
Group=www-data
DynamicUser=true

WorkingDirectory=/opt/git/open-accident-map
PrivateTmp=true

EnvironmentFile=/opt/git/open-accident-map/.env
ExecStart=/opt/git/open-accident-map/venv/bin/uvicorn \
        --proxy-headers \
        --forwarded-allow-ips='*' \
        --workers=4 \
        --port=5000 \
        main:app

ExecReload=/bin/kill -HUP ${MAINPID}
RestartSec=1
Restart=always

[Install]
WantedBy=multi-user.target
```


## Setup Server

Setup frontend webserver configuration for nginx

```
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name beta.open-accident-map.de;

    charset uft-8;

    add_header Content-Security-Policy "default-src 'self' https://beta.open-accident-map.de https://nominatim.openstreetmap.org; script-src 'self'; img-src 'self' data: https://tile.openstreetmap.org; style-src 'self' 'unsafe-inline'; font-src 'self'; worker-src 'none'; object-src 'none'; connect-src 'self' https://api.open-accident-map.de";

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;

        proxy_buffering on;
        proxy_cache_valid 200 5m;
        proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
        proxy_cache_bypass $http_cache_control;
        proxy_hide_header content-security-policy;

        add_header X-Proxy-Cache $upstream_cache_status;
        add_header X-Robots-Tag 'noindex, nofollow, nosnippet, noarchive';
        add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload" always;
    }

    ssl_certificate /etc/letsencrypt/live/beta.open-accident-map.de/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/beta.open-accident-map.de/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```


Setup backend webserver configuration for nginx reverse proxy

```
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name api.open-accident-map.de;

    charset uft-8;

    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; font-src 'self'; worker-src 'none'; object-src 'none'";

    root /opt/git/open-accident-map;

    location / {
        if ($request_method = 'OPTIONS') {
            add_header 'Access-Control-Allow-Origin' '*';
            #
            # Om nom nom cookies
            #
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';

            #
            # Custom headers and headers various browsers *should* be OK with but aren't
            #
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';

            #
            # Tell client that this pre-flight info is valid for 20 days
            #
            add_header 'Access-Control-Max-Age' 1728000;
            add_header 'Content-Type' 'text/plain charset=UTF-8';
            add_header 'Content-Length' 0;
            return 204;
        }

        if ($request_method = 'POST') {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        }

        if ($request_method = 'GET') {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        }

        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;

        proxy_buffering on;
        proxy_cache_valid 200 5m;
        proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
        proxy_cache_bypass $http_cache_control;
        add_header X-Proxy-Cache $upstream_cache_status;
        add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload" always;
    }

    ssl_certificate /etc/letsencrypt/live/api.open-accident-map.de/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/api.open-accident-map.de/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```

Follow the instructions from corresponding programm

```
sudo apt install nginx-full certbot python3-certbot-nginx
sudo nginx -t
sudo certbot
sudo systemctl reload nginx.service
```
