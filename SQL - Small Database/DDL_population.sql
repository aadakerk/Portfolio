CREATE SCHEMA population;

CREATE TABLE person
	(person_ID INTEGER NOT NULL,
    name varchar(50) NOT NULL,
    birthday DATE NOT NULL,
    gender varchar(25) NOT NULL,
    PRIMARY KEY (person_ID)
	);

CREATE TABLE companies
    (company varchar(75) NOT NULL,
    field varchar(50) NOT NULL,
    PRIMARY KEY (company)
	);
    
    CREATE TABLE employment
	(person_ID INTEGER NOT NULL,
    company varchar(50) NOT NULL,
    salary numeric(12,2) CHECK (salary > 0) NOT NULL,
    PRIMARY KEY (person_ID, company),
    FOREIGN KEY (person_ID) REFERENCES person(person_ID) ON DELETE CASCADE,
    FOREIGN KEY (company) REFERENCES companies(company) ON DELETE CASCADE
	);
