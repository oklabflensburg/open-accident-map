# Unfallkarte Deutschland

Interaktive Karte von Unfällen mit Personenschaden der Statistischen Ämter des Bundes und der Länder in kombination mit den Verwaltungsgebieten des Bundesamtes für Kartographie und Geodäsie. Unfälle, bei denen nur Sachschaden entsteht, werden nicht dargestellt.


![Screenshot Unfallkarte](https://raw.githubusercontent.com/oklabflensburg/open-accident-map/main/screenshot_unfallkarte.jpg)


## Prerequisites

Install system dependencies and packages

```
sudo apt install gnupg2 gdal-bin git git-lfs
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > postgresql-keyring.gpg
sudo mv postgresql-keyring.gpg /etc/apt/trusted.gpg.d/
sudo chown root:root /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod ugo+r /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
sudo chmod go-w /etc/apt/trusted.gpg.d/postgresql-keyring.gpg
echo "deb [arch=amd64, signed-by=/etc/apt/trusted.gpg.d/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install postgis postgresql-15-postgis-3
```


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


## Reindex GIST

```sql
REINDEX INDEX accidents_wkb_geometry_geom_idx;
REINDEX INDEX vg250_wkb_geometry_geom_idx;
```


## Insert Metadata

Create schema and insert meta data

```sh
sudo -i -Hu postgres psql -U postgres -h localhost -d postgres -p 5432 < data/unfallorte_deutschland_schema.sql
```


## Prepare Application

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


## Webserver

Setup frontend webserver configuration for nginx

```sh
server {
    # listen 443 ssl http2;
    # listen [::]:443 ssl http2;
    server_name www.open-accident-map.de open-accident-map.de;

    charset uft-8;

    add_header Content-Security-Policy "default-src 'self' https://nominatim.openstreetmap.org; script-src 'self' https://unpkg.com; img-src 'self' data: https://unpkg.com https://tile.openstreetmap.org; style-src 'self' 'unsafe-inline' https://unpkg.com; font-src 'self'; worker-src 'none'; object-src 'none'";

    root /opt/git/open-accident-map;
    index index.html;

    listen 80;
    ssl_certificate /etc/letsencrypt/live/open-accident-map.de/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/open-accident-map.de/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```


## Test configuration

Test configuration and install certificates, make sure to uncomment `http2` after certbot run.

```sh
sudo nginx -t
sudo certbot
```


## Start webserver

```sh
sudo systemctl start nginx.service
sudo systemctl status nginx.service
sudo systemctl enable nginx.service
```
