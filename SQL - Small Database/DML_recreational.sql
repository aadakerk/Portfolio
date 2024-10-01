use recreation;

INSERT INTO recreation.hobbies values ('Paris Saint-German', 'football', '500');
INSERT INTO recreation.hobbies values ('FC Liverpool', 'football', '600');
INSERT INTO recreation.hobbies values ('New York Yankees', 'baseball', '400');
INSERT INTO recreation.hobbies values ('New York Knicks', 'basketball', '300');
INSERT INTO recreation.hobbies values ('Real Madrid CF', 'football', '450');
INSERT INTO recreation.hobbies values ('Boston Bruins', 'ice hockey', '330');
INSERT INTO recreation.hobbies values ('Chicago Bears', 'american football', '999');
INSERT INTO recreation.hobbies values ('Toronto Arrows', 'rugby', '560');
INSERT INTO recreation.hobbies values ('IFK Göteborg', 'orienteering', '200');
INSERT INTO recreation.hobbies values ('Pebble Beach', 'golf', '500');

INSERT INTO recreation.stadium values ('Parc De Princess', '48000', 'Paris Saint-German');
INSERT INTO recreation.stadium values ('Anfield', '45000', 'FC Liverpool');
INSERT INTO recreation.stadium values ('De Meer Stadium', '20000', 'Real Madrid CF');
INSERT INTO recreation.stadium values ('Wembley', '90000', 'Chicago Bears');
INSERT INTO recreation.stadium values ('Madison Square Garden', '20789', 'New York Knicks');
INSERT INTO recreation.stadium values ('Astrodome', '67925', 'Boston Bruins');
INSERT INTO recreation.stadium values ('Notre Dame Stadium', '77622', 'Toronto Arrows');
INSERT INTO recreation.stadium values ('St. Andrews', '21000', 'Pebble Beach');
INSERT INTO recreation.stadium values ('Old Yankee', '57545', 'New York Yankees');
INSERT INTO recreation.stadium values ('Wimbledon', '42979', 'IFK Göteborg');

INSERT INTO recreation.participates values ('11', 'Pebble Beach');
INSERT INTO recreation.participates values ('12', 'Toronto Arrows');
INSERT INTO recreation.participates values ('13', 'New York Yankees');
INSERT INTO recreation.participates values ('14', 'IFK Göteborg');
INSERT INTO recreation.participates values ('15', 'Chicago Bears');
INSERT INTO recreation.participates values ('16', 'FC Liverpool');
INSERT INTO recreation.participates values ('17', 'Real Madrid CF');
INSERT INTO recreation.participates values ('18', 'New York Knicks');
INSERT INTO recreation.participates values ('19', 'Paris Saint-German');
INSERT INTO recreation.participates values ('20', 'Boston Bruins');

SELECT person.name AS person_name, club, stadium.name AS stadium_name
FROM stadium NATURAL JOIN participates, population.person
WHERE person.person_ID = participates.person_ID;