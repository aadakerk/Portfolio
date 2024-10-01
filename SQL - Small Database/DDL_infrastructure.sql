CREATE SCHEMA infrastructure;

CREATE TABLE roads
	(street varchar(50) NOT NULL,
    speed_limit INTEGER NOT NULL,
    PRIMARY KEY (street));

CREATE TABLE building
	(building_number INTEGER NOT NULL,
    street varchar(50) NOT NULL,
    type varchar(100) NOT NULL,
    PRIMARY KEY (building_number, street),
    FOREIGN KEY (street) REFERENCES roads(street) ON UPDATE CASCADE);

CREATE TABLE transportation
	(route varchar(50) NOT NULL,
    type varchar(50) NOT NULL,
    license INTEGER NOT NULL,
    PRIMARY KEY (license),
    FOREIGN KEY (route) REFERENCES roads(street) ON UPDATE CASCADE);