COPY titles (
    tconst,
    titleType,
    primaryTitle,
    originalTitle,
    isAdult,
    startYear,
    endYear,
    runtimeMinutes,
    genres
    )
    FROM '/var/tmp/data-ingestion/title.basics.tsv'
    DELIMITER E'\t'
    NULL '\N'
    CSV HEADER;
ALTER TABLE titles DROP COLUMN originalTitle, DROP COLUMN isAdult, DROP COLUMN endYear, DROP COLUMN runtimeMinutes, DROP COLUMN genres;
ALTER TABLE titles RENAME titleType TO title_type;
ALTER TABLE titles RENAME primaryTitle TO primary_title;
ALTER TABLE titles RENAME startYear TO start_year;
