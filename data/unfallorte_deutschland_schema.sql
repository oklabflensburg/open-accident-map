/* POSTGIS ERWEITERUNG LADEN */
CREATE EXTENSION IF NOT EXISTS postgis;


CREATE TABLE IF NOT EXISTS istfuss (
    id INT,
    istfuss NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS istgkfz (
    id INT,
    istgkfz NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS istkrad (
    id INT,
    istkrad NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS istpkw (
    id INT,
    istpkw NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS istrad (
    id INT,
    istrad NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS istsonstig (
    id INT,
    istsonstig NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS accidents (
    ogc_fid INT NOT NULL,
    objectid INT,
    uidentstla VARCHAR,
    uland VARCHAR,
    uregbez VARCHAR,
    ukreis VARCHAR,
    ugemeinde VARCHAR,
    ujahr VARCHAR,
    umonat VARCHAR,
    ustunde VARCHAR,
    uwochentag VARCHAR,
    ukategorie VARCHAR,
    uart VARCHAR,
    utyp1 VARCHAR,
    ulichtverh VARCHAR,
    istrad VARCHAR,
    istpkw VARCHAR,
    istfuss VARCHAR,
    istkrad VARCHAR,
    istgkfz VARCHAR,
    istsonstig VARCHAR,
    ustrzustan VARCHAR,
    wkb_geometry GEOMETRY,
    PRIMARY KEY(objectid)
);


CREATE TABLE IF NOT EXISTS vg250 (
    ogc_fid INT NOT NULL,
    objid VARCHAR,
    beginn date,
    ade INT,
    gf INT,
    bsg INT,
    ars VARCHAR,
    ags VARCHAR,
    sdv_ars VARCHAR,
    gen VARCHAR,
    bez VARCHAR,
    ibz INT,
    bem VARCHAR,
    nbd VARCHAR,
    sn_l VARCHAR,
    sn_r VARCHAR,
    sn_k VARCHAR,
    sn_v1 VARCHAR,
    sn_v2 VARCHAR,
    sn_g VARCHAR,
    fk_s3 VARCHAR,
    nuts VARCHAR,
    ars_0 VARCHAR,
    ags_0 VARCHAR,
    wsk DATE,
    wkb_geometry GEOMETRY,
    PRIMARY KEY(objid)
);


CREATE TABLE IF NOT EXISTS uart (
    id INT,
    uart NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS ukategorie (
    id INT,
    ukategorie NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS uland (
    id INT,
    uland NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS ulichtverh (
    id INT,
    ulichtverh NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS umonat (
    id INT,
    umonat NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS ustrzustan (
    id INT,
    ustrzustan NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS utyp1 (
    id INT,
    utyp1 NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE IF NOT EXISTS uwochentag (
    id INT,
    uwochentag NUMERIC NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY(id)
);


CREATE INDEX IF NOT EXISTS accidents_wkb_geometry_geom_idx ON accidents USING gist (wkb_geometry);
CREATE INDEX IF NOT EXISTS vg250_wkb_geometry_geom_idx ON vg250 USING gist (wkb_geometry);
