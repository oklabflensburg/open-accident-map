DROP TABLE IF EXISTS de_accident_meta CASCADE;

CREATE TABLE de_accident_meta (
  id SERIAL PRIMARY KEY,
  value INT NOT NULL,
  name VARCHAR NOT NULL,
  category VARCHAR NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_de_accident_meta_category_value ON de_accident_meta (category, value);



-- ULAND Bundesland
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 1, 'Schleswig-Holstein');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 2, 'Hamburg');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 3, 'Niedersachsen');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 4, 'Bremen');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 5, 'Nordrhein-Westfalen');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 6, 'Hessen');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 7, 'Rheinland-Pfalz');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 8, 'Baden-Württemberg');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 9, 'Bayern');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 10, 'Saarland');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 11, 'Berlin');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 12, 'Brandenburg');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 13, 'Mecklenburg-Vorpommern');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 14, 'Sachsen');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 15, 'Sachsen-Anhalt');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uland', 16, 'Thüringen');

-- UMONAT Unfallmonat
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 1, 'Januar');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 2, 'Februar');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 3, 'März');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 4, 'April');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 5, 'Mai');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 6, 'Juni');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 7, 'Juli');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 8, 'August');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 9, 'September');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 10, 'Oktober');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 11, 'November');
INSERT INTO de_accident_meta(category, value, name) VALUES ('umonat', 12, 'Dezember');

-- UWOCHENTAG Wochentag
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 1, 'Sonntag');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 2, 'Montag');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 3, 'Dienstag');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 4, 'Mittwoch');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 5, 'Donnerstag');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 6, 'Freitag');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uwochentag', 7, 'Samstag');

-- UKATEGORIE Unfallkategorie
INSERT INTO de_accident_meta(category, value, name) VALUES ('ukategorie', 1, 'Unfall mit Getöteten');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ukategorie', 2, 'Unfall mit Schwerverletzten');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ukategorie', 3, 'Unfall mit Leichtverletzten');

-- USTRZUSTAND Straßenzustand
INSERT INTO de_accident_meta(category, value, name) VALUES ('ustrzustan', 0, 'trocken');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ustrzustan', 1, 'nass bzw. feucht');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ustrzustan', 2, 'winterglatt');

-- UART Unfallart
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 1, 'Zusammenstoß mit anfahrendem/anhaltendem/ruhendem Fahrzeug');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 2, 'Zusammenstoß mit vorausfahrendem / wartendem Fahrzeug');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 3, 'Zusammenstoß mit seitlich in gleicher Richtung fahrendem Fahrzeug');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 4, 'Zusammenstoß mit entgegenkommendem Fahrzeug');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 5, 'Zusammenstoß mit einbiegendem / kreuzendem Fahrzeug');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 6, 'Zusammenstoß zwischen Fahrzeug und Fußgänger');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 7, 'Aufprall auf Fahrbahnhindernis');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 8, 'Abkommen von Fahrbahn nach rechts');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 9, 'Abkommen von Fahrbahn nach links');
INSERT INTO de_accident_meta(category, value, name) VALUES ('uart', 0, 'Unfall anderer Art');

-- UTYP1 Unfalltyp
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 1, 'Fahrunfall');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 2, 'Abbiegeunfall');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 3, 'Einbiegen / Kreuzen-Unfall');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 4, 'Überschreiten-Unfall');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 5, 'Unfall durch ruhenden Verkehr');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 6, 'Unfall im Längsverkehr');
INSERT INTO de_accident_meta(category, value, name) VALUES ('utyp1', 7, 'sonstiger Unfall');

-- ULICHTVERH Lichtverhältnisse:
INSERT INTO de_accident_meta(category, value, name) VALUES ('ulichtverh', 0, 'Tageslicht');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ulichtverh', 1, 'Dämmerung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('ulichtverh', 2, 'Dunkelheit');

-- IstRad Unfall mit Rad
INSERT INTO de_accident_meta(category, value, name) VALUES ('istrad', 0, 'Unfall ohne Fahrradbeteiligung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istrad', 1, 'Unfall mit Fahrradbeteiligung');

-- IstPKW Unfall mit Pkw
INSERT INTO de_accident_meta(category, value, name) VALUES ('istpkw', 0, 'Unfall ohne PKW-Beteiligung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istpkw', 1, 'Unfall mit PKW-Beteiligung');

-- IstFuss Unfall mit Fußgänger
INSERT INTO de_accident_meta(category, value, name) VALUES ('istfuss', 0, 'Unfall ohne Fußgängerbeteiligung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istfuss', 1, 'Unfall mit Fußgängerbeteiligung');

-- IstKrad Unfall mit Kraftrad
INSERT INTO de_accident_meta(category, value, name) VALUES ('istkrad', 0, 'Unfall ohne Kraftradbeteiligung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istkrad', 1, 'Unfall mit Kraftradbeteiligung');

-- IstGkfz Unfall mit Güterkraftfahrzeug (GKFZ)
INSERT INTO de_accident_meta(category, value, name) VALUES ('istgkfz', 0, 'Unfall ohne Güterkraftfahrzeugbeteiligung');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istgkfz', 1, 'Unfall mit Güterkraftfahrzeugbeteiligung');

-- IstSonstig Unfall mit Sonstigen
INSERT INTO de_accident_meta(category, value, name) VALUES ('istsonstig', 0, 'Unfall ohne Beteiligung eines oben nicht genannten Verkehrsmittels');
INSERT INTO de_accident_meta(category, value, name) VALUES ('istsonstig', 1, 'Unfall mit Beteiligung eines oben nicht genannten Verkehrsmittels');
