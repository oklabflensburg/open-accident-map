#!./venv/bin/python

import os
import click
import psycopg2
import json

from shapely import wkb
from psycopg2.errors import UniqueViolation
from shapely.geometry import shape, Point
from dotenv import load_dotenv
from pathlib import Path


env_path = Path('..')/'.env'
load_dotenv(dotenv_path=env_path)


try:
    conn = psycopg2.connect(
        database = os.getenv('DB_NAME'),
        password = os.getenv('DB_PASS'),
        user = os.getenv('DB_USER'),
        host = os.getenv('DB_HOST'),
        port = os.getenv('DB_PORT')
    )
    conn.autocommit = True
except Exception as e:
    print(e)


def insert_row(cur, properties, geometry):
    if geometry['type'].lower() == 'point':
        g = Point(shape(geometry))

    objectid = properties['OBJECTID']
    uland = properties['ULAND']
    uregbez = properties['UREGBEZ']
    ukreis = properties['UKREIS']
    ugemeinde = properties['UGEMEINDE']
    ujahr = properties['UJAHR']
    umonat = properties['UMONAT']
    ustunde = properties['USTUNDE']
    uwochentag = properties['UWOCHENTAG']
    ukategorie = properties['UKATEGORIE']
    uart = properties['UART']
    utyp1 = properties['UTYP1']
    ulichtverh = properties['ULICHTVERH']
    iststrasse = properties['IstStrasse']
    istrad = properties['IstRad']
    istpkw = properties['IstPKW']
    istfuss = properties['IstFuss']
    istkrad = properties['IstKrad']
    istgkfz = properties['IstGkfz']
    istsonstig = properties['IstSonstig']
    wkb_geometry = wkb.dumps(g, hex=True, srid=4326)
    ags = f'{uland}{uregbez}{ukreis}{ugemeinde}'

    sql = 'INSERT INTO accidents (objectid, ags, uland, uregbez, ukreis, ugemeinde, ujahr, umonat, ustunde, uwochentag, ukategorie, uart, utyp1, ulichtverh, iststrasse, istrad, istpkw, istfuss, istkrad, istgkfz, istsonstig, wkb_geometry) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'

    try:
        cur.execute(sql, (objectid, ags, uland, uregbez, ukreis, ugemeinde, ujahr, umonat, ustunde, uwochentag, ukategorie, uart, utyp1, ulichtverh, iststrasse, istrad, istpkw, istfuss, istkrad, istgkfz, istsonstig, wkb_geometry))
    except UniqueViolation as e:
        print(e)


@click.command()
@click.argument('file')
def main(file):
    cur = conn.cursor()

    with open(Path(file), 'r') as f:
        features = json.loads(f.read())['features']

        for feature in features:
            print(feature)
            insert_row(cur, feature['properties'], feature['geometry'])


if __name__ == '__main__':
    main()
