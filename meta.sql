DROP TABLE IF EXISTS uland;

CREATE TABLE uland (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  uland NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS umonat;

CREATE TABLE umonat (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  umonat NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS uwochentag;

CREATE TABLE uwochentag (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  uwochentag NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ukategorie;

CREATE TABLE ukategorie (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ukategorie NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS uart;

CREATE TABLE uart (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  uart NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS utyp1;

CREATE TABLE utyp1 (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  utyp1 NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ulichtverh;

CREATE TABLE ulichtverh (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ulichtverh NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istrad;

CREATE TABLE istrad (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istrad NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istpkw;

CREATE TABLE istpkw (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istpkw NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istfuss;

CREATE TABLE istfuss (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istfuss NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istkrad;

CREATE TABLE istkrad (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istkrad NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istgkfz;

CREATE TABLE istgkfz (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istgkfz NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS istsonstig;

CREATE TABLE istsonstig (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  istsonstig NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ustrzustan;

CREATE TABLE ustrzustan (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ustrzustan NUMERIC NOT NULL,
  name VARCHAR(255) NOT NULL
);

INSERT INTO uland(uland, name) VALUES (01, 'Schleswig-Holstein');
INSERT INTO uland(uland, name) VALUES (02, 'Hamburg');
INSERT INTO uland(uland, name) VALUES (03, 'Niedersachsen');
INSERT INTO uland(uland, name) VALUES (04, 'Bremen');
INSERT INTO uland(uland, name) VALUES (05, 'Nordrhein-Westfalen');
INSERT INTO uland(uland, name) VALUES (06, 'Hessen');
INSERT INTO uland(uland, name) VALUES (07, 'Rheinland-Pfalz');
INSERT INTO uland(uland, name) VALUES (08, 'Baden-Württemberg');
INSERT INTO uland(uland, name) VALUES (09, 'Bayern');
INSERT INTO uland(uland, name) VALUES (10, 'Saarland');
INSERT INTO uland(uland, name) VALUES (11, 'Berlin');
INSERT INTO uland(uland, name) VALUES (12, 'Brandenburg');
INSERT INTO uland(uland, name) VALUES (13, 'Mecklenburg-Vorpommern');
INSERT INTO uland(uland, name) VALUES (14, 'Sachsen');
INSERT INTO uland(uland, name) VALUES (15, 'Sachsen-Anhalt');
INSERT INTO uland(uland, name) VALUES (16, 'Thüringen');

-- UMONAT Unfallmonat
INSERT INTO umonat(umonat, name) VALUES (01, 'Januar');
INSERT INTO umonat(umonat, name) VALUES (02, 'Februar');
INSERT INTO umonat(umonat, name) VALUES (03, 'März');
INSERT INTO umonat(umonat, name) VALUES (04, 'April');
INSERT INTO umonat(umonat, name) VALUES (05, 'Mai');
INSERT INTO umonat(umonat, name) VALUES (06, 'Juni');
INSERT INTO umonat(umonat, name) VALUES (07, 'Juli');
INSERT INTO umonat(umonat, name) VALUES (08, 'August');
INSERT INTO umonat(umonat, name) VALUES (09, 'September');
INSERT INTO umonat(umonat, name) VALUES (10, 'Oktober');
INSERT INTO umonat(umonat, name) VALUES (11, 'November');
INSERT INTO umonat(umonat, name) VALUES (12, 'Dezember');

-- UWOCHENTAG Wochentag
INSERT INTO uwochentag(uwochentag, name) VALUES (1, 'Sonntag');
INSERT INTO uwochentag(uwochentag, name) VALUES (2, 'Montag');
INSERT INTO uwochentag(uwochentag, name) VALUES (3, 'Dienstag');
INSERT INTO uwochentag(uwochentag, name) VALUES (4, 'Mittwoch');
INSERT INTO uwochentag(uwochentag, name) VALUES (5, 'Donnerstag');
INSERT INTO uwochentag(uwochentag, name) VALUES (6, 'Freitag');
INSERT INTO uwochentag(uwochentag, name) VALUES (7, 'Samstag');

-- UKATEGORIE Unfallkategorie
INSERT INTO ukategorie(ukategorie, name) VALUES (1, 'Unfall mit Getöteten');
INSERT INTO ukategorie(ukategorie, name) VALUES (2, 'Unfall mit Schwerverletzten');
INSERT INTO ukategorie(ukategorie, name) VALUES (3, 'Unfall mit Leichtverletzten');

-- UART Unfallart
INSERT INTO uart(uart, name) VALUES (1, 'Zusammenstoß mit anfahrendem/anhaltendem/ruhendem Fahrzeug');
INSERT INTO uart(uart, name) VALUES (2, 'Zusammenstoß mit vorausfahrendem / wartendem Fahrzeug');
INSERT INTO uart(uart, name) VALUES (3, 'Zusammenstoß mit seitlich in gleicher Richtung fahrendem Fahrzeug');
INSERT INTO uart(uart, name) VALUES (4, 'Zusammenstoß mit entgegenkommendem Fahrzeug');
INSERT INTO uart(uart, name) VALUES (5, 'Zusammenstoß mit einbiegendem / kreuzendem Fahrzeug');
INSERT INTO uart(uart, name) VALUES (6, 'Zusammenstoß zwischen Fahrzeug und Fußgänger');
INSERT INTO uart(uart, name) VALUES (7, 'Aufprall auf Fahrbahnhindernis');
INSERT INTO uart(uart, name) VALUES (8, 'Abkommen von Fahrbahn nach rechts');
INSERT INTO uart(uart, name) VALUES (9, 'Abkommen von Fahrbahn nach links');
INSERT INTO uart(uart, name) VALUES (0, 'Unfall anderer Art');

-- UTYP1 Unfalltyp
INSERT INTO utyp1(utyp1, name) VALUES (1, 'Fahrunfall');
INSERT INTO utyp1(utyp1, name) VALUES (2, 'Abbiegeunfall');
INSERT INTO utyp1(utyp1, name) VALUES (3, 'Einbiegen / Kreuzen-Unfall');
INSERT INTO utyp1(utyp1, name) VALUES (4, 'Überschreiten-Unfall');
INSERT INTO utyp1(utyp1, name) VALUES (5, 'Unfall durch ruhenden Verkehr');
INSERT INTO utyp1(utyp1, name) VALUES (6, 'Unfall im Längsverkehr');
INSERT INTO utyp1(utyp1, name) VALUES (7, 'sonstiger Unfall');

-- ULICHTVERH Lichtverhältnisse:
INSERT INTO ulichtverh(ulichtverh, name) VALUES (0, 'Tageslicht');
INSERT INTO ulichtverh(ulichtverh, name) VALUES (1, 'Dämmerung');
INSERT INTO ulichtverh(ulichtverh, name) VALUES (2, 'Dunkelheit');

-- IstRad Unfall mit Rad
INSERT INTO istrad(istrad, name) VALUES (0, 'Unfall ohne Fahrradbeteiligung');
INSERT INTO istrad(istrad, name) VALUES (1, 'Unfall mit Fahrradbeteiligung');

-- IstPKW Unfall mit Pkw
INSERT INTO istpkw(istpkw, name) VALUES (0, 'Unfall ohne PKW-Beteiligung');
INSERT INTO istpkw(istpkw, name) VALUES (1, 'Unfall mit PKW-Beteiligung');

-- IstFuss Unfall mit Fußgänger
INSERT INTO istfuss(istfuss, name) VALUES (0, 'Unfall ohne Fußgängerbeteiligung');
INSERT INTO istfuss(istfuss, name) VALUES (1, 'Unfall mit Fußgängerbeteiligung');

-- IstKrad Unfall mit Kraftrad
INSERT INTO istkrad(istkrad, name) VALUES (0, 'Unfall ohne Kraftradbeteiligung');
INSERT INTO istkrad(istkrad, name) VALUES (1, 'Unfall mit Kraftradbeteiligung');

-- IstGkfz Unfall mit Güterkraftfahrzeug (GKFZ)
INSERT INTO istgkfz(istgkfz, name) VALUES (0, 'Unfall ohne Güterkraftfahrzeugbeteiligung');
INSERT INTO istgkfz(istgkfz, name) VALUES (1, 'Unfall mit Güterkraftfahrzeugbeteiligung');

-- IstSonstig Unfall mit Sonstigen
INSERT INTO istsonstig(istsonstig, name) VALUES (0, 'Unfall ohne Beteiligung eines oben nicht genannten Verkehrsmittels');
INSERT INTO istsonstig(istsonstig, name) VALUES (1, 'Unfall mit Beteiligung eines oben nicht genannten Verkehrsmittels');

-- USTRZUSTAND Straßenzustand
INSERT INTO ustrzustan(ustrzustan, name) VALUES (0, 'trocken');
INSERT INTO ustrzustan(ustrzustan, name) VALUES (1, 'nass/feucht/schlüpfrig');
INSERT INTO ustrzustan(ustrzustan, name) VALUES (2, 'winterglatt');
