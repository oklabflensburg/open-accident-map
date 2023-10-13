# Unfallkarte Deutschland

Interaktive Karte von Unfällen mit Personenschaden der Statistischen Ämter des Bundes und der Länder in kombination mit den Verwaltungsgebieten des Bundesamtes für Kartographie und Geodäsie. Unfälle, bei denen nur Sachschaden entsteht, werden nicht dargestellt.


![Screenshot Unfallkarte Deutschland](https://raw.githubusercontent.com/oklabflensburg/open-accident-map/main/screenshot_unfallkarte_deutschland.jpg)


## Extract GeoJSON from Esri Shapefile

```sh
ogr2ogr -f GeoJSON -s_srs Unfallorte2022_LinRef.prj -t_srs EPSG:4326 accidents_2022.geojson Unfallorte2022_LinRef.shp
```


## Import Data from GeoJSON file

```sh
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/vg250.geojson" -nln vg250
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2016.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2017.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2018.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2019.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2020.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2021.geojson" -nln accidents -append
ogr2ogr -f "PostgreSQL" PG:"dbname=postgres user=postgres host=localhost port=5432 password=postgres" "data/accidents_2022.geojson" -nln accidents -append
```


## Create Indexes

```sql
ALTER TABLE accidents ADD COLUMN wkb_geometry GEOMETRY(GEOMETRY, 4326);
ALTER TABLE accidents ALTER COLUMN wkb_geometry TYPE GEOMETRY(GEOMETRY, 4326) USING ST_GeomFromGeoJSON(geometry);
CREATE INDEX IF NOT EXISTS accidents_wkb_geometry_geom_idx ON accidents USING gist (wkb_geometry);
CREATE INDEX IF NOT EXISTS vg250_wkb_geometry_geom_idx ON vg250 USING gist (wkb_geometry);
ALTER TABLE accidents DROP COLUMN geometry;
```


## Setup System

Install dependencies which been used by this project

```
sudo apt install gnupg2 git git-lfs
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > postgresql-keyring.gpg
sudo mv postgresql-keyring.gpg /etc/apt/trusted.gpg.d/
sudo chown root:root /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod ugo+r /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod go-w /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
echo "deb [arch=amd64, signed-by=/etc/apt/trusted.gpg.d/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgis postgresql-15-postgis-3
```


## Setup Database

Create table schemas and insert data

```sh
sudo -i -Hu postgres psql -U postgres -h localhost -d postgres -p 5432 < data/unfallorte_deutschland_schema.sql
```


## Setup Application

Clone repository and setup git lfs

```sh
sudo apt install nginx-full certbot python3 virtualenv
git clone https://github.com/oklabflensburg/open-accident-map.git
cd open-accident-map
git lfs pull
virtualenv venv
. venv/bin/activate
pip install -r requirements.txt
```


## Setup Service

```sh
sudo vim /etc/systemd/system/api-open-accident-map.service
```

```sh
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

```sh
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name www.open-accident-map.de open-accident-map.de;

    charset uft-8;

    add_header Content-Security-Policy "default-src 'self' https://nominatim.openstreetmap.org; script-src 'self' https://unpkg.com; img-src 'self' data: https://unpkg.com https://tile.openstreetmap.org; style-src 'self' 'unsafe-inline' https://unpkg.com; font-src 'self'; worker-src 'none'; object-src 'none'";

    root /opt/git/open-accident-map;
    index index.html;

    ssl_certificate /etc/letsencrypt/live/open-accident-map.de/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/open-accident-map.de/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```


Setup backend webserver configuration for nginx reverse proxy

```sh
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


Test your webserver configuration and install certificates

```sh
sudo nginx -t
sudo certbot
sudo systemctl start nginx.service
sudo systemctl status nginx.service
sudo systemctl enable nginx.service
```
