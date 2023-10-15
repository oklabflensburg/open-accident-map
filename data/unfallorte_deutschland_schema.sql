DROP TABLE IF EXISTS uland;

CREATE TABLE IF NOT EXISTS uland (
  id SERIAL PRIMARY KEY,
  uland VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS umonat;

CREATE TABLE IF NOT EXISTS umonat (
  id SERIAL PRIMARY KEY,
  umonat VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS uwochentag;

CREATE TABLE IF NOT EXISTS uwochentag (
  id SERIAL PRIMARY KEY,
  uwochentag VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ukategorie;

CREATE TABLE IF NOT EXISTS ukategorie (
  id SERIAL PRIMARY KEY,
  ukategorie VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS uart;

CREATE TABLE IF NOT EXISTS uart (
  id SERIAL PRIMARY KEY,
  uart VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS utyp1;

CREATE TABLE IF NOT EXISTS utyp1 (
  id SERIAL PRIMARY KEY,
  utyp1 VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ulichtverh;

CREATE TABLE IF NOT EXISTS ulichtverh (
  id SERIAL PRIMARY KEY,
  ulichtverh VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istrad;

CREATE TABLE IF NOT EXISTS istrad (
  id SERIAL PRIMARY KEY,
  istrad VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istpkw;

CREATE TABLE IF NOT EXISTS istpkw (
  id SERIAL PRIMARY KEY,
  istpkw VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istfuss;

CREATE TABLE IF NOT EXISTS istfuss (
  id SERIAL PRIMARY KEY,
  istfuss VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istkrad;

CREATE TABLE IF NOT EXISTS istkrad (
  id SERIAL PRIMARY KEY,
  istkrad VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istgkfz;

CREATE TABLE IF NOT EXISTS istgkfz (
  id SERIAL PRIMARY KEY,
  istgkfz VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istsonstig;

CREATE TABLE IF NOT EXISTS istsonstig (
  id SERIAL PRIMARY KEY,
  istsonstig VARCHAR(255) NOT NULL
);


-- ULAND Bundesland
INSERT INTO uland(id, uland) VALUES (1, 'Schleswig-Holstein');
INSERT INTO uland(id, uland) VALUES (2, 'Hamburg');
INSERT INTO uland(id, uland) VALUES (3, 'Niedersachsen');
INSERT INTO uland(id, uland) VALUES (4, 'Bremen');
INSERT INTO uland(id, uland) VALUES (5, 'Nordrhein-Westfalen');
INSERT INTO uland(id, uland) VALUES (6, 'Hessen');
INSERT INTO uland(id, uland) VALUES (7, 'Rheinland-Pfalz');
INSERT INTO uland(id, uland) VALUES (8, 'Baden-Württemberg');
INSERT INTO uland(id, uland) VALUES (9, 'Bayern');
INSERT INTO uland(id, uland) VALUES (10, 'Saarland');
INSERT INTO uland(id, uland) VALUES (11, 'Berlin');
INSERT INTO uland(id, uland) VALUES (12, 'Brandenburg');
INSERT INTO uland(id, uland) VALUES (13, 'Mecklenburg-Vorpommern');
INSERT INTO uland(id, uland) VALUES (14, 'Sachsen');
INSERT INTO uland(id, uland) VALUES (15, 'Sachsen-Anhalt');
INSERT INTO uland(id, uland) VALUES (16, 'Thüringen');

-- UMONAT Unfallmonat
INSERT INTO umonat(id, umonat) VALUES (1, 'Januar');
INSERT INTO umonat(id, umonat) VALUES (2, 'Februar');
INSERT INTO umonat(id, umonat) VALUES (3, 'März');
INSERT INTO umonat(id, umonat) VALUES (4, 'April');
INSERT INTO umonat(id, umonat) VALUES (5, 'Mai');
INSERT INTO umonat(id, umonat) VALUES (6, 'Juni');
INSERT INTO umonat(id, umonat) VALUES (7, 'Juli');
INSERT INTO umonat(id, umonat) VALUES (8, 'August');
INSERT INTO umonat(id, umonat) VALUES (9, 'September');
INSERT INTO umonat(id, umonat) VALUES (10, 'Oktober');
INSERT INTO umonat(id, umonat) VALUES (11, 'November');
INSERT INTO umonat(id, umonat) VALUES (12, 'Dezember');

-- UWOCHENTAG Wochentag
INSERT INTO uwochentag(id, uwochentag) VALUES (1, 'Sonntag');
INSERT INTO uwochentag(id, uwochentag) VALUES (2, 'Montag');
INSERT INTO uwochentag(id, uwochentag) VALUES (3, 'Dienstag');
INSERT INTO uwochentag(id, uwochentag) VALUES (4, 'Mittwoch');
INSERT INTO uwochentag(id, uwochentag) VALUES (5, 'Donnerstag');
INSERT INTO uwochentag(id, uwochentag) VALUES (6, 'Freitag');
INSERT INTO uwochentag(id, uwochentag) VALUES (7, 'Samstag');

-- UKATEGORIE Unfallkategorie
INSERT INTO ukategorie(id, ukategorie) VALUES (1, 'Unfall mit Getöteten');
INSERT INTO ukategorie(id, ukategorie) VALUES (2, 'Unfall mit Schwerverletzten');
INSERT INTO ukategorie(id, ukategorie) VALUES (3, 'Unfall mit Leichtverletzten');

-- UART Unfallart
INSERT INTO uart(id, uart) VALUES (1, 'Zusammenstoß mit anfahrendem/anhaltendem/ruhendem Fahrzeug');
INSERT INTO uart(id, uart) VALUES (2, 'Zusammenstoß mit vorausfahrendem / wartendem Fahrzeug');
INSERT INTO uart(id, uart) VALUES (3, 'Zusammenstoß mit seitlich in gleicher Richtung fahrendem Fahrzeug');
INSERT INTO uart(id, uart) VALUES (4, 'Zusammenstoß mit entgegenkommendem Fahrzeug');
INSERT INTO uart(id, uart) VALUES (5, 'Zusammenstoß mit einbiegendem / kreuzendem Fahrzeug');
INSERT INTO uart(id, uart) VALUES (6, 'Zusammenstoß zwischen Fahrzeug und Fußgänger');
INSERT INTO uart(id, uart) VALUES (7, 'Aufprall auf Fahrbahnhindernis');
INSERT INTO uart(id, uart) VALUES (8, 'Abkommen von Fahrbahn nach rechts');
INSERT INTO uart(id, uart) VALUES (9, 'Abkommen von Fahrbahn nach links');
INSERT INTO uart(id, uart) VALUES (0, 'Unfall anderer Art');

-- UTYP1 Unfalltyp
INSERT INTO utyp1(id, utyp1) VALUES (1, 'Fahrunfall');
INSERT INTO utyp1(id, utyp1) VALUES (2, 'Abbiegeunfall');
INSERT INTO utyp1(id, utyp1) VALUES (3, 'Einbiegen / Kreuzen-Unfall');
INSERT INTO utyp1(id, utyp1) VALUES (4, 'Überschreiten-Unfall');
INSERT INTO utyp1(id, utyp1) VALUES (5, 'Unfall durch ruhenden Verkehr');
INSERT INTO utyp1(id, utyp1) VALUES (6, 'Unfall im Längsverkehr');
INSERT INTO utyp1(id, utyp1) VALUES (7, 'sonstiger Unfall');

-- ULICHTVERH Lichtverhältnisse:
INSERT INTO ulichtverh(id, ulichtverh) VALUES (0, 'Tageslicht');
INSERT INTO ulichtverh(id, ulichtverh) VALUES (1, 'Dämmerung');
INSERT INTO ulichtverh(id, ulichtverh) VALUES (2, 'Dunkelheit');

-- IstRad Unfall mit Rad
INSERT INTO istrad(id, istrad) VALUES (0, 'Unfall ohne Fahrradbeteiligung');
INSERT INTO istrad(id, istrad) VALUES (1, 'Unfall mit Fahrradbeteiligung');

-- IstPKW Unfall mit Pkw
INSERT INTO istpkw(id, istpkw) VALUES (0, 'Unfall ohne PKW-Beteiligung');
INSERT INTO istpkw(id, istpkw) VALUES (1, 'Unfall mit PKW-Beteiligung');

-- IstFuss Unfall mit Fußgänger
INSERT INTO istfuss(id, istfuss) VALUES (0, 'Unfall ohne Fußgängerbeteiligung');
INSERT INTO istfuss(id, istfuss) VALUES (1, 'Unfall mit Fußgängerbeteiligung');

-- IstKrad Unfall mit Kraftrad
INSERT INTO istkrad(id, istkrad) VALUES (0, 'Unfall ohne Kraftradbeteiligung');
INSERT INTO istkrad(id, istkrad) VALUES (1, 'Unfall mit Kraftradbeteiligung');

-- IstGkfz Unfall mit Güterkraftfahrzeug (GKFZ)
INSERT INTO istgkfz(id, istgkfz) VALUES (0, 'Unfall ohne Güterkraftfahrzeugbeteiligung');
INSERT INTO istgkfz(id, istgkfz) VALUES (1, 'Unfall mit Güterkraftfahrzeugbeteiligung');

-- IstSonstig Unfall mit Sonstigen
INSERT INTO istsonstig(id, istsonstig) VALUES (0, 'Unfall ohne Beteiligung eines oben nicht genannten Verkehrsmittels');
INSERT INTO istsonstig(id, istsonstig) VALUES (1, 'Unfall mit Beteiligung eines oben nicht genannten Verkehrsmittels');

-- Accidents
DROP TABLE IF EXISTS accidents CASCADE;

CREATE TABLE IF NOT EXISTS accidents (
  id SERIAL PRIMARY KEY,
  objectid VARCHAR,
  ags VARCHAR,
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
  iststrasse VARCHAR,
  istrad VARCHAR,
  istpkw VARCHAR,
  istfuss VARCHAR,
  istkrad VARCHAR,
  istgkfz VARCHAR,
  istsonstig VARCHAR,
  wkb_geometry GEOMETRY(GEOMETRY, 4326)
);

CREATE INDEX IF NOT EXISTS accidents_ags_idx ON accidents (ags);


-- GEOMETRY INDEX
CREATE INDEX IF NOT EXISTS accidents_wkb_geometry_geom_idx ON accidents USING gist (wkb_geometry);
CREATE INDEX IF NOT EXISTS vg250_wkb_geometry_geom_idx ON vg250 USING gist (wkb_geometry);
