# open-accident-map

Offene Daten der Unfallstatistik des BKG auf einer interaktiven webbasierten Karte



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


## Setup Server

Follow the instructions from corresponding programm

```
sudo apt install nginx-full certbot python3-certbot-nginx
sudo nginx -t
sudo certbot
sudo systemctl reload nginx.service
```
