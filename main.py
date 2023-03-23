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




@app.get('/settings')
async def geometry_settings():
    db_query = '''
    SELECT json_build_array(
        json_build_object(
            'istfuss', (
                SELECT json_agg(row_to_json(f))
                FROM postgis_istfuss AS f
            )
        ),
        json_build_object(
            'istgkfz', (
                SELECT json_agg(row_to_json(g))
                FROM postgis_istgkfz AS g
            )
        ),
        json_build_object(
            'istkrad', (
                SELECT json_agg(row_to_json(k))
                FROM postgis_istkrad AS k
            )
        ),
        json_build_object(
            'istpkw', (
                SELECT json_agg(row_to_json(p))
                FROM postgis_istpkw AS p
            )
        ),
        json_build_object(
            'istrad', (
                SELECT json_agg(row_to_json(r))
                FROM postgis_istrad AS r
            )
        ),
        json_build_object(
            'istsonstig', (
                SELECT json_agg(row_to_json(s))
                FROM postgis_istsonstig AS s
            )
        ),
        json_build_object(
            'uart', (
                SELECT json_agg(row_to_json(a))
                FROM postgis_uart AS a
            )
        ),
        json_build_object(
            'ukategorie', (
                SELECT json_agg(row_to_json(c))
                FROM postgis_ukategorie AS c
            )
        ),
        json_build_object(
            'uland', (
                SELECT json_agg(row_to_json(l))
                FROM postgis_uland AS l
            )
        ),
        json_build_object(
            'ulichtverh', (
                SELECT json_agg(row_to_json(y))
                FROM postgis_ulichtverh AS y
            )
        ),
        json_build_object(
            'ustrzustan', (
                SELECT json_agg(row_to_json(z))
                FROM postgis_ustrzustan AS z
            )
        ),
        json_build_object(
            'utyp1', (
                SELECT json_agg(row_to_json(t))
                FROM postgis_utyp1 AS t
            )
        )
    );
    '''
    
    cur.execute(db_query)

    return cur.fetchall()[0]


@app.get('/query/{geometry_string}')
async def geometry_results(geometry_string: str = None):
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
            -- 'id', objectid::text,
            'geometry', ST_AsGeoJSON(ST_Transform(a.wkb_geometry, 4326))::jsonb,
            'properties', to_jsonb(ul) || to_jsonb(uw) || to_jsonb(um) ||
            jsonb_build_object('ags', concat(a.uland, a.uregbez, a.ukreis, a.ugemeinde),
            'ujahr', a.ujahr, 'ustunde', a.ustunde) ||
            COALESCE(to_jsonb(t), to_jsonb(tt)) ||
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

        LEFT JOIN postgis_uwochentag AS uw
        ON a.uwochentag = uw.id::text

        LEFT JOIN postgis_uland AS ul
        ON a.uland = LPAD(ul.id::text, 2, '0')

        LEFT JOIN postgis_umonat AS um
        ON a.umonat = LPAD(um.id::text, 2, '0')

        LEFT JOIN postgis_uart AS t
        ON a.uart = t.id::text
        LEFT JOIN (SELECT '' AS uart) AS tt
        ON a.uart IS NULL

        LEFT JOIN postgis_ukategorie AS k
        ON a.ukategorie = k.id::text
        LEFT JOIN (SELECT '' AS ukategorie) AS kk
        ON a.ukategorie IS NULL

        LEFT JOIN postgis_istrad AS r
        ON a.istrad = r.id::text
        LEFT JOIN (SELECT '' AS istrad) AS rr
        ON a.istrad IS NULL

        LEFT JOIN postgis_ulichtverh AS i
        ON a.ulichtverh = i.id::text
        LEFT JOIN (SELECT '' AS ulichtverh) AS ii
        ON a.ulichtverh IS NULL

        LEFT JOIN postgis_istpkw AS j
        ON a.istpkw = j.id::text
        LEFT JOIN (SELECT '' AS istpkw) AS jj
        ON a.istpkw IS NULL

        LEFT JOIN postgis_istfuss AS f
        ON a.istfuss = f.id::text
        LEFT JOIN (SELECT '' AS istfuss) AS ff
        ON a.istfuss IS NULL

        LEFT JOIN postgis_istsonstig AS s
        ON a.istsonstig = s.id::text
        LEFT JOIN (SELECT '' AS istsonstig) AS ss
        ON a.istsonstig IS NULL

        LEFT JOIN postgis_istgkfz AS g
        ON a.istgkfz = g.id::text
        LEFT JOIN (SELECT '' AS istgkfz) AS gg
        ON a.istgkfz IS NULL

        LEFT JOIN postgis_istkrad AS m
        ON a.istkrad = m.id::text
        LEFT JOIN (SELECT '' AS istkrad) AS mm
        ON a.istkrad IS NULL

        LEFT JOIN postgis_ustrzustan AS z
        ON a.ustrzustan = z.id::text
        LEFT JOIN (SELECT '' AS ustrzustan) AS zz
        ON a.ustrzustan IS NULL

        LEFT JOIN postgis_utyp1 AS p
        ON a.utyp1 = p.id::text
        LEFT JOIN (SELECT '' AS utyp1) AS pp
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
