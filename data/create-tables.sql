-- create the 'titles' table
CREATE TABLE titles (
                        id bigserial primary key,
                        tconst varchar(10) NOT NULL,
                        titleType text,
                        primaryTitle text,
                        originalTitle text,
                        isAdult text,
                        startYear smallint,
                        endYear smallint,
                        runtimeMinutes integer,
                        genres text
);

-- create the 'names' table
CREATE TABLE names (
                       id bigserial primary key,
                       nconst varchar(10) NOT NULL,
                       primaryName text,
                       birthYear smallint,
                       deathYear smallint,
                       primaryProfession text,
                       knownForTitles text
);

-- create the 'characters' table
CREATE TABLE characters (
                            id bigserial primary key,
                            tconst varchar(10) NOT NULL,
                            ordering smallint,
                            nconst varchar(10) NOT NULL,
                            category text,
                            job text,
                            characters text
);
