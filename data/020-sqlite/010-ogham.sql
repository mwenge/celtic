.mode csv
.import ../010-csv/BIBLIOG.csv BIBLIOG
.import ../010-csv/FORM.csv FORM
.import ../010-csv/INSC_PUB.csv INSC_PUB
.import ../010-csv/INSCRIP.csv INSCRIP
.import ../010-csv/READING.csv READING
.import ../010-csv/READ_PUB.csv READ_PUB
.import ../010-csv/SITE.csv SITE
.import ../010-csv/SITE_PUB.csv SITE_PUB
.import ../010-csv/STONE.csv STONE
.import ../010-csv/STON_PUB.csv STON_PUB
.import ../010-csv/TRANSLAT.csv TRANSLAT
.mode list
.once ogham.json
SELECT DISTINCT json_group_array( 
    json_object(
    'Site', S.SITE,
    'Stone', S.STONE,
    'Inscription', I.Inscription,
    'Script', Script,
    'Text', Text,
    'Setting', CURRENT_SEtting,
    'SiteName', ST.Name,
    'Expansion', Expansion,
    'Translation', Translation,
    'Support', Gen_Form
  )
)

FROM STONE S
JOIN INSCRIP I
  ON I.STONE = S.STONE
  AND
  I.Site = S.Site
JOIN SITE ST
  ON I.SITE = ST.SITE
JOIN (
  SELECT R.*  
  FROM READING R
  LEFT JOIN READING R1
  ON 
  (
    R.Inscription = R1.Inscription
    AND
    R.Stone = R1.Stone
    AND
    R.Site = R1.Site
    AND
    R."When" < R1."When"
  )
  WHERE
  R1.Inscription IS NULL
) R
  ON R.Inscription = I.Inscription
  AND
  R.Stone = I.Stone
  AND
  R.Site = I.Site
JOIN TRANSLAT T
  ON R.Inscription = T.Inscription
  AND
  R.Stone = T.Stone
  AND
  R.Site = T.Site
  AND
  R.Reading = T.Reading
JOIN FORM F
  ON S.MON_FORM = F.MON_FORM
