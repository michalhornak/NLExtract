-- Simpel SQL script om adres tabel naar CSV te converteren
-- voor specifiek schema: verander public.adres naar mijnschema.adres
-- bijv schema naam zetten via search path met PGOPTIONS in shell script:
-- http://stackoverflow.com/questions/13850564/how-to-change-default-public-schema-on-the-psql-command-line
--    export PGOPTIONS='-c search_path=public,bag8jan2014'
--    psql -h vm-kademodb -U kademo -W -d bag -f /opt/nlextract/git/bag/db/script/adres2csv.sql
--    mv /tmp/bagadres.csv bag8jan2014.csv
--
-- dump is in /tmp omdat postgres absolute pad wil...daar is vast ook wel iets op te bedenken.
\COPY (SELECT openbareruimtenaam as openbareruimte,huisnummer,huisletter,huisnummertoevoeging,woonplaatsnaam as woonplaats,gemeentenaam as gemeente,provincienaam as provincie, adresseerbaarobject as object_id,typeadresseerbaarobject as object_type,nevenadres,ST_X(geopunt) as x,ST_Y(geopunt) as y, ST_X(ST_Transform(geopunt, 4326)) as lon, ST_Y(ST_Transform(geopunt, 4326)) as lat  FROM adres ORDER BY openbareruimtenaam,huisnummer,huisletter,huisnummertoevoeging) TO '/tmp/bagadres.csv' WITH CSV HEADER
