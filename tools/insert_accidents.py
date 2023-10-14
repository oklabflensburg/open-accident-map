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



def get_attribute(obj, key):
    attr = None

    if key in obj:
        attr = obj[key]

    return attr



def insert_row(cur, properties, geometry):
    if geometry['type'].lower() == 'point':
        g = Point(shape(geometry))

    ags = None
    objectid = get_attribute(properties, 'OBJECTID')
    uland = get_attribute(properties, 'ULAND')
    uregbez = get_attribute(properties, 'UREGBEZ')
    ukreis = get_attribute(properties, 'UKREIS')
    ugemeinde = get_attribute(properties, 'UGEMEINDE')
    ujahr = get_attribute(properties, 'UJAHR')
    umonat = get_attribute(properties, 'UMONAT')
    ustunde = get_attribute(properties, 'USTUNDE')
    uwochentag = get_attribute(properties, 'UWOCHENTAG')
    ukategorie = get_attribute(properties, 'UKATEGORIE')
    uart = get_attribute(properties, 'UART')
    utyp1 = get_attribute(properties, 'UTYP1')
    ulichtverh = get_attribute(properties, 'ULICHTVERH')
    iststrasse = get_attribute(properties, 'IstStrasse')
    istrad = get_attribute(properties, 'IstRad')
    istpkw = get_attribute(properties, 'IstPKW')
    istfuss = get_attribute(properties, 'IstFuss')
    istkrad = get_attribute(properties, 'IstKrad')
    istgkfz = get_attribute(properties, 'IstGkfz')
    istsonstig = get_attribute(properties, 'IstSonstig')
    wkb_geometry = wkb.dumps(g, hex=True, srid=4326)

    if uland and uregbez and ukreis and ugemeinde:
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
            insert_row(cur, feature['properties'], feature['geometry'])


if __name__ == '__main__':
    main()
