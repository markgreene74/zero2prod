COPY characters (
    tconst,
    ordering,
    nconst,
    category,
    job,
    characters
    )
    FROM '/var/tmp/data-ingestion/title.principals.tsv'
    DELIMITER E'\t'
    NULL '\N'
    CSV HEADER;
ALTER TABLE characters DROP COLUMN tconst, DROP COLUMN ordering, DROP COLUMN category, DROP COLUMN job;
