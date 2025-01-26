COPY names (
    nconst,
    primaryName,
    birthYear,
    deathYear,
    primaryProfession,
    knownForTitles
    )
    FROM '/var/tmp/data-ingestion/name.basics.tsv'
    DELIMITER E'\t'
    NULL '\N'
    CSV HEADER;
ALTER TABLE names DROP COLUMN birthYear, DROP COLUMN deathYear, DROP COLUMN primaryProfession;
ALTER TABLE names RENAME primaryName TO name;
ALTER TABLE names RENAME knownForTitles TO known_for;
