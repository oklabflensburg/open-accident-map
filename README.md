# Unfallkarte Deutschland

> Map mit Verkehrsunfällen mit Personenschaden im Zeitraum 2016 - 2023 mit Daten der Statistischen Ämter des Bundes und der Länder sowie des BKG aktualisiert. Unfälle, bei denen nur Sachschaden entsteht, werden nicht dargestellt.

![Screenshot Unfallkarte](https://raw.githubusercontent.com/oklabflensburg/open-accident-map/main/screenshot_unfallkarte.jpg)


## Prerequisites

Install system dependencies and packages

```
sudo apt update
sudo apt install wget
sudo apt install git git-lfs
sudo apt install python3 python3-pip python3-venv
sudo apt install postgresql-16 postgresql-postgis gdal-bin
```


## Clone Repo and import meta data


```sh
git clone https://github.com/oklabflensburg/open-accident-map.git
cd open-accident-map
```

To insert the accident meta data run this sql script

```sh
psql -U oklab -h localhost -d oklab -p 5432 < data/de_accident_meta_schema.sql
```


## Download and import data

Since November 2024, new table names and structures are used.

```sh
wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2023_EPSG25832_Shape.zip
unzip Unfallorte2023_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs shp/Unfallorte_2023_LR_BasisDLM.prj -t_srs EPSG:4326 shp/Unfallorte_2023_LR_BasisDLM.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2022_EPSG25832_Shape.zip
unzip Unfallorte2022_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs shp/Unfallorte2022_LinRef.prj -t_srs EPSG:4326 shp/Unfallorte2022_LinRef.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2021_EPSG25832_Shape.zip
unzip Unfallorte2021_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Unfallorte202_EPSG25832_Shape/shapefile/Unfallorte_2021_LR_BasisDLM.prj -t_srs EPSG:4326 Unfallorte202_EPSG25832_Shape/shapefile/Unfallorte_2021_LR_BasisDLM.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2020_EPSG25832_Shape.zip
unzip Unfallorte2020_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Shapefile/Unfallorte2020_LinRef.prj -t_srs EPSG:4326 Shapefile/Unfallorte2020_LinRef.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2019_EPSG25832_Shape.zip
unzip Unfallorte2019_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Shapefile/Unfallorte2019_LinRef.prj -t_srs EPSG:4326 Shapefile/Unfallorte2019_LinRef.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2018_EPSG25832_Shape.zip
unzip Unfallorte2018_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Shapefile/Unfallorte2018_LinRef.prj -t_srs EPSG:4326 Shapefile/Unfallorte2018_LinRef.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2017_EPSG25832_Shape.zip
unzip Unfallorte2017_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Shapefile/Unfallorte2017_LinRef.prj -t_srs EPSG:4326 Shapefile/Unfallorte2017_LinRef.shp

wget https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2016_EPSG25832_Shape.zip
unzip Unfallorte2016_EPSG25832_Shape.zip
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=oklab user=oklab" -lco GEOMETRY_NAME=geom -lco SPATIAL_INDEX=GIST -lco PRECISION=YES -nlt POINT -append -nln de_accident_points -s_srs Shapefile/Unfaelle_2016_LinRef.prj -t_srs EPSG:4326 Shapefile/Unfaelle_2016_LinRef.shp
```


---


## How to Contribute

Contributions are welcome! Please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) guide for details on how to get involved.


---


## License

This repository is licensed under [CC0-1.0](LICENSE).
