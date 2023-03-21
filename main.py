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
            -- 'id', CAST (objectid AS TEXT),
            'geometry', ST_AsGeoJSON(ST_Transform(a.wkb_geometry, 4326))::jsonb,
            'properties', COALESCE(to_jsonb(t), to_jsonb(tt)) ||
            COALESCE(to_jsonb(k), to_jsonb(kk)) ||
            COALESCE(to_jsonb(i), to_jsonb(ii)) ||
            COALESCE(to_jsonb(z), to_jsonb(zz)) ||
            COALESCE(to_jsonb(p), to_jsonb(pp)) ||
            COALESCE(to_jsonb(r), to_jsonb(rr)) ||
            COALESCE(to_jsonb(j), to_jsonb(jj)) ||
            COALESCE(to_jsonb(f), to_jsonb(ff)) ||
            COALESCE(to_jsonb(s), to_jsonb(ss)) ||
            COALESCE(to_jsonb(m), to_jsonb(mm)) ||
            COALESCE(to_jsonb(g), to_jsonb(gg))
        ) AS feature
        FROM postgis_unfallorte AS a
        JOIN postgis_verwaltungsgebiete AS v
        ON ST_WITHIN(a.wkb_geometry, v.wkb_geometry)
        LEFT JOIN postgis_uart AS t
        ON a.uart = CAST (t.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS uart) AS tt
        ON a.uart IS NULL
        LEFT JOIN postgis_ukategorie AS k
        ON a.ukategorie = CAST (k.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS ukategorie) AS kk
        ON a.ukategorie IS NULL
        LEFT JOIN postgis_istrad AS r
        ON a.istrad = CAST (r.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istrad) AS rr
        ON a.istrad IS NULL
        LEFT JOIN postgis_ulichtverh AS i
        ON a.ulichtverh = CAST (i.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS ulichtverh) AS ii
        ON a.ulichtverh IS NULL
        LEFT JOIN postgis_istpkw AS j
        ON a.istpkw = CAST (j.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istpkw) AS jj
        ON a.istpkw IS NULL
        LEFT JOIN postgis_istfuss AS f
        ON a.istfuss = CAST (f.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istfuss) AS ff
        ON a.istfuss IS NULL
        LEFT JOIN postgis_istsonstig AS s
        ON a.istsonstig = CAST (s.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istsonstig) AS ss
        ON a.istsonstig IS NULL
        LEFT JOIN postgis_istgkfz AS g
        ON a.istgkfz = CAST (g.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istgkfz) AS gg
        ON a.istgkfz IS NULL
        LEFT JOIN postgis_istkrad AS m
        ON a.istkrad = CAST (m.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS istkrad) AS mm
        ON a.istkrad IS NULL
        LEFT JOIN postgis_ustrzustan AS z
        ON a.ustrzustan = CAST (z.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS ustrzustan) AS zz
        ON a.ustrzustan IS NULL
        LEFT JOIN postgis_utyp1 AS p
        ON a.utyp1 = CAST (p.id AS TEXT)
        LEFT JOIN (SELECT 'xxx' AS utyp1) AS pp
        ON a.utyp1 IS NULL
        WHERE v.gen = %(geometry_string)s
    ) AS fc;
    '''

    # execute the query safely
    cur.execute(db_query, {'geometry_string': geometry_string})

    results = cur.fetchall()

    if len(results) > 0:
        return results[0][0]
    else:
        return {}
