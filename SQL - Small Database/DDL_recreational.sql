CREATE SCHEMA recreation;

CREATE TABLE hobbies
	(club varchar(50) NOT NULL,
    activity varchar(50) NOT NULL,
    price_monthly numeric(5,2) NOT NULL,
    PRIMARY KEY (club)
	);

CREATE TABLE participates
	(person_ID INTEGER NOT NULL,
    club varchar(50) NOT NULL,
    PRIMARY KEY (person_ID, club),
    FOREIGN KEY (person_ID) REFERENCES population.person(person_ID) ON DELETE CASCADE,
    FOREIGN KEY (club) REFERENCES hobbies(club) ON DELETE CASCADE
	);

CREATE TABLE stadium
	(name varchar(50) NOT NULL,
    capacity numeric(9, 2) NOT NULL,
    club varchar(50),
    PRIMARY KEY (name),
    FOREIGN KEY (club) REFERENCES hobbies(club) ON DELETE SET NULL
	);