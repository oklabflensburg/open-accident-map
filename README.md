# Unfallkarte Deutschland

> Map mit Verkehrsunfällen mit Personenschaden im Zeitraum 2016 - 2022 mit Daten der Statistischen Ämter des Bundes und der Länder sowie des BKG aktualisiert. Unfälle, bei denen nur Sachschaden entsteht, werden nicht dargestellt.

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
sudo apt install postgresql-16 postgresql-16-postgis-3 postgresql-client-16

```


## Download Esri Shapefile from

```
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2016_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2017_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2018_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2019_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2020_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2021_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2022_EPSG25832_Shape.zip
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2023_EPSG25832_Shape.zip
```


## Extract GeoJSON from Esri Shapefile

```sh
ogr2ogr -f GeoJSON -s_srs Unfaelle_2016_LinRef.prj -t_srs EPSG:4326 accidents_2016.geojson Unfaelle_2016_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2017_LinRef.prj -t_srs EPSG:4326 accidents_2017.geojson Unfallorte2017_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2018_LinRef.prj -t_srs EPSG:4326 accidents_2018.geojson Unfallorte2018_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2019_LinRef.prj -t_srs EPSG:4326 accidents_2019.geojson Unfallorte2019_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2020_LinRef.prj -t_srs EPSG:4326 accidents_2020.geojson Unfallorte2020_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2021_LinRef.prj -t_srs EPSG:4326 accidents_2021.geojson Unfallorte2021_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte2022_LinRef.prj -t_srs EPSG:4326 accidents_2022.geojson Unfallorte2022_LinRef.shp
ogr2ogr -f GeoJSON -s_srs Unfallorte_2023_LR_BasisDLM.prj -t_srs EPSG:4326 accidents_2023.geojson Unfallorte_2023_LR_BasisDLM.shp
```


## Import Data from GeoJSON file

To use the prefered names and tools run this lines

```sh
git clone https://github.com/oklabflensburg/open-accident-map.git
cd open-accident-map
sudo -i -Hu postgres psql -U postgres -h localhost -d postgres -p 5432 < data/unfallorte_deutschland_schema.sql
cd tools
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
for i in {16..23}; do python3 ./insert_accidents.py ../data/accidents_20$i.geojson; done
deactivate
```

In case you dont want to use default import use this

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
    listen 80 default_server;
    listen [::]:80 default_server;

    charset uft-8;

    add_header Content-Security-Policy "default-src 'self' https://nominatim.openstreetmap.org; script-src 'self' https://unpkg.com; img-src 'self' data: https://unpkg.com https://tile.openstreetmap.org; style-src 'self' 'unsafe-inline' https://unpkg.com; font-src 'self'; worker-src 'none'; object-src 'none'";

    root /opt/git/open-accident-map;
    index index.html;
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
