DROP TABLE IF EXISTS postgis_uland;

CREATE TABLE postgis_uland (
  id SERIAL PRIMARY KEY,
  uland VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_umonat;

CREATE TABLE postgis_umonat (
  id SERIAL PRIMARY KEY,
  umonat VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_uwochentag;

CREATE TABLE postgis_uwochentag (
  id SERIAL PRIMARY KEY,
  uwochentag VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_ukategorie;

CREATE TABLE postgis_ukategorie (
  id SERIAL PRIMARY KEY,
  ukategorie VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_uart;

CREATE TABLE postgis_uart (
  id SERIAL PRIMARY KEY,
  uart VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_utyp1;

CREATE TABLE postgis_utyp1 (
  id SERIAL PRIMARY KEY,
  utyp1 VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_ulichtverh;

CREATE TABLE postgis_ulichtverh (
  id SERIAL PRIMARY KEY,
  ulichtverh VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istrad;

CREATE TABLE postgis_istrad (
  id SERIAL PRIMARY KEY,
  istrad VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istpkw;

CREATE TABLE postgis_istpkw (
  id SERIAL PRIMARY KEY,
  istpkw VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istfuss;

CREATE TABLE postgis_istfuss (
  id SERIAL PRIMARY KEY,
  istfuss VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istkrad;

CREATE TABLE postgis_istkrad (
  id SERIAL PRIMARY KEY,
  istkrad VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istgkfz;

CREATE TABLE postgis_istgkfz (
  id SERIAL PRIMARY KEY,
  istgkfz VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_istsonstig;

CREATE TABLE postgis_istsonstig (
  id SERIAL PRIMARY KEY,
  istsonstig VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS postgis_ustrzustan;

CREATE TABLE postgis_ustrzustan (
  id SERIAL PRIMARY KEY,
  ustrzustan VARCHAR(255) NOT NULL
);

-- ULAND Bundesland
INSERT INTO postgis_uland(id, uland) VALUES (1, 'Schleswig-Holstein');
INSERT INTO postgis_uland(id, uland) VALUES (2, 'Hamburg');
INSERT INTO postgis_uland(id, uland) VALUES (3, 'Niedersachsen');
INSERT INTO postgis_uland(id, uland) VALUES (4, 'Bremen');
INSERT INTO postgis_uland(id, uland) VALUES (5, 'Nordrhein-Westfalen');
INSERT INTO postgis_uland(id, uland) VALUES (6, 'Hessen');
INSERT INTO postgis_uland(id, uland) VALUES (7, 'Rheinland-Pfalz');
INSERT INTO postgis_uland(id, uland) VALUES (8, 'Baden-Württemberg');
INSERT INTO postgis_uland(id, uland) VALUES (9, 'Bayern');
INSERT INTO postgis_uland(id, uland) VALUES (10, 'Saarland');
INSERT INTO postgis_uland(id, uland) VALUES (11, 'Berlin');
INSERT INTO postgis_uland(id, uland) VALUES (12, 'Brandenburg');
INSERT INTO postgis_uland(id, uland) VALUES (13, 'Mecklenburg-Vorpommern');
INSERT INTO postgis_uland(id, uland) VALUES (14, 'Sachsen');
INSERT INTO postgis_uland(id, uland) VALUES (15, 'Sachsen-Anhalt');
INSERT INTO postgis_uland(id, uland) VALUES (16, 'Thüringen');

-- UMONAT Unfallmonat
INSERT INTO postgis_umonat(id, umonat) VALUES (1, 'Januar');
INSERT INTO postgis_umonat(id, umonat) VALUES (2, 'Februar');
INSERT INTO postgis_umonat(id, umonat) VALUES (3, 'März');
INSERT INTO postgis_umonat(id, umonat) VALUES (4, 'April');
INSERT INTO postgis_umonat(id, umonat) VALUES (5, 'Mai');
INSERT INTO postgis_umonat(id, umonat) VALUES (6, 'Juni');
INSERT INTO postgis_umonat(id, umonat) VALUES (7, 'Juli');
INSERT INTO postgis_umonat(id, umonat) VALUES (8, 'August');
INSERT INTO postgis_umonat(id, umonat) VALUES (9, 'September');
INSERT INTO postgis_umonat(id, umonat) VALUES (10, 'Oktober');
INSERT INTO postgis_umonat(id, umonat) VALUES (11, 'November');
INSERT INTO postgis_umonat(id, umonat) VALUES (12, 'Dezember');

-- UWOCHENTAG Wochentag
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (1, 'Sonntag');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (2, 'Montag');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (3, 'Dienstag');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (4, 'Mittwoch');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (5, 'Donnerstag');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (6, 'Freitag');
INSERT INTO postgis_uwochentag(id, uwochentag) VALUES (7, 'Samstag');

-- UKATEGORIE Unfallkategorie
INSERT INTO postgis_ukategorie(id, ukategorie) VALUES (1, 'Unfall mit Getöteten');
INSERT INTO postgis_ukategorie(id, ukategorie) VALUES (2, 'Unfall mit Schwerverletzten');
INSERT INTO postgis_ukategorie(id, ukategorie) VALUES (3, 'Unfall mit Leichtverletzten');

-- UART Unfallart
INSERT INTO postgis_uart(id, uart) VALUES (1, 'Zusammenstoß mit anfahrendem/anhaltendem/ruhendem Fahrzeug');
INSERT INTO postgis_uart(id, uart) VALUES (2, 'Zusammenstoß mit vorausfahrendem / wartendem Fahrzeug');
INSERT INTO postgis_uart(id, uart) VALUES (3, 'Zusammenstoß mit seitlich in gleicher Richtung fahrendem Fahrzeug');
INSERT INTO postgis_uart(id, uart) VALUES (4, 'Zusammenstoß mit entgegenkommendem Fahrzeug');
INSERT INTO postgis_uart(id, uart) VALUES (5, 'Zusammenstoß mit einbiegendem / kreuzendem Fahrzeug');
INSERT INTO postgis_uart(id, uart) VALUES (6, 'Zusammenstoß zwischen Fahrzeug und Fußgänger');
INSERT INTO postgis_uart(id, uart) VALUES (7, 'Aufprall auf Fahrbahnhindernis');
INSERT INTO postgis_uart(id, uart) VALUES (8, 'Abkommen von Fahrbahn nach rechts');
INSERT INTO postgis_uart(id, uart) VALUES (9, 'Abkommen von Fahrbahn nach links');
INSERT INTO postgis_uart(id, uart) VALUES (0, 'Unfall anderer Art');

-- UTYP1 Unfalltyp
INSERT INTO postgis_utyp1(id, utyp1) VALUES (1, 'Fahrunfall');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (2, 'Abbiegeunfall');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (3, 'Einbiegen / Kreuzen-Unfall');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (4, 'Überschreiten-Unfall');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (5, 'Unfall durch ruhenden Verkehr');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (6, 'Unfall im Längsverkehr');
INSERT INTO postgis_utyp1(id, utyp1) VALUES (7, 'sonstiger Unfall');

-- ULICHTVERH Lichtverhältnisse:
INSERT INTO postgis_ulichtverh(id, ulichtverh) VALUES (0, 'Tageslicht');
INSERT INTO postgis_ulichtverh(id, ulichtverh) VALUES (1, 'Dämmerung');
INSERT INTO postgis_ulichtverh(id, ulichtverh) VALUES (2, 'Dunkelheit');

-- IstRad Unfall mit Rad
INSERT INTO postgis_istrad(id, istrad) VALUES (0, 'Unfall ohne Fahrradbeteiligung');
INSERT INTO postgis_istrad(id, istrad) VALUES (1, 'Unfall mit Fahrradbeteiligung');

-- IstPKW Unfall mit Pkw
INSERT INTO postgis_istpkw(id, istpkw) VALUES (0, 'Unfall ohne PKW-Beteiligung');
INSERT INTO postgis_istpkw(id, istpkw) VALUES (1, 'Unfall mit PKW-Beteiligung');

-- IstFuss Unfall mit Fußgänger
INSERT INTO postgis_istfuss(id, istfuss) VALUES (0, 'Unfall ohne Fußgängerbeteiligung');
INSERT INTO postgis_istfuss(id, istfuss) VALUES (1, 'Unfall mit Fußgängerbeteiligung');

-- IstKrad Unfall mit Kraftrad
INSERT INTO postgis_istkrad(id, istkrad) VALUES (0, 'Unfall ohne Kraftradbeteiligung');
INSERT INTO postgis_istkrad(id, istkrad) VALUES (1, 'Unfall mit Kraftradbeteiligung');

-- IstGkfz Unfall mit Güterkraftfahrzeug (GKFZ)
INSERT INTO postgis_istgkfz(id, istgkfz) VALUES (0, 'Unfall ohne Güterkraftfahrzeugbeteiligung');
INSERT INTO postgis_istgkfz(id, istgkfz) VALUES (1, 'Unfall mit Güterkraftfahrzeugbeteiligung');

-- IstSonstig Unfall mit Sonstigen
INSERT INTO postgis_istsonstig(id, istsonstig) VALUES (0, 'Unfall ohne Beteiligung eines oben nicht genannten Verkehrsmittels');
INSERT INTO postgis_istsonstig(id, istsonstig) VALUES (1, 'Unfall mit Beteiligung eines oben nicht genannten Verkehrsmittels');

-- USTRZUSTAND Straßenzustand
INSERT INTO postgis_ustrzustan(id, ustrzustan) VALUES (0, 'trocken');
INSERT INTO postgis_ustrzustan(id, ustrzustan) VALUES (1, 'nass/feucht/schlüpfrig');
INSERT INTO postgis_ustrzustan(id, ustrzustan) VALUES (2, 'winterglatt');
