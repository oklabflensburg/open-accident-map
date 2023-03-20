#!./venv/bin/python

from fastapi import FastAPI
from pydantic import BaseSettings

import psycopg2


class Settings(BaseSettings):
    app_name: str = 'Open accident map'
    admin_email: str
    db_host: str
    db_user: str
    db_name: str
    db_port: int
    db_pass: str

    class Config:
        env_file = '.env'

app = FastAPI()
setting = Settings()


db_connection = psycopg2.connect(
    host = setting.db_host,
    port = setting.db_port,
    dbname = setting.db_name,
    password = setting.db_pass,
    user = setting.db_user
)

db_connection.set_session(readonly = True)
cur = db_connection.cursor()


@app.get('/query/{geometry_string}')
async def geometry_filter(geometry_string: str = None):
    # Note: for testing purposes f-strings or string concatenation are fine but never to be used in production!
    # Always use parametrized queries instead!

    db_query = '''
    SELECT jsonb_build_object(
        'type', 'FeatureCollection',
        'center', COUNT(fc),
        'features', jsonb_agg(fc.feature)
    )
    FROM (
        SELECT jsonb_build_object(
            'type', 'Feature',
            'id', objectid,
            'geometry', ST_AsGeoJSON(ST_Transform(a.wkb_geometry, 4326))::jsonb,
            'properties', to_jsonb(a) - 'objectid' - 'linrefx' - 'linrefy' - \
            'xgcswgs84' - 'ygcswgs84' - 'wkb_geometry' - 'uidentstla' - 'ogc_fid'
        ) AS feature
        FROM postgis_unfallorte AS a
        JOIN postgis_verwaltungsgebiete AS v
        ON ST_WITHIN(a.wkb_geometry, v.wkb_geometry)
        WHERE v.gen = %(geometry_string)s
    ) AS fc;
    '''

    # execute the query safely
    cur.execute(db_query, {'geometry_string': geometry_string})

    results = cur.fetchall()

    if len(results) > 0:
        return results[0]
    else:
        return {}
