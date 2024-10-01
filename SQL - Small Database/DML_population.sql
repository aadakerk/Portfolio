use population;

INSERT INTO population.person values ('11', 'Beyonce', '1981-09-4', 'female');
INSERT INTO population.person values ('12', 'Adele', '1988-05-05', 'female');
INSERT INTO population.person values ('13', 'Meryl Streep', '1949-06-22', 'female');
INSERT INTO population.person values ('14', 'Tom Cruise', '1962-07-03', 'male');
INSERT INTO population.person values ('15', 'Jeff Bezos', '1964-01-12', 'male');
INSERT INTO population.person values ('16', 'Bill Gates', '1955-10-28', 'male');
INSERT INTO population.person values ('17', 'Joe Biden', '1942-11-20', 'male');
INSERT INTO population.person values ('18', 'Emmanuel Macron', '1977-12-21', 'male');
INSERT INTO population.person values ('19', 'Lionel Messi', '1987-06-24', 'male');
INSERT INTO population.person values ('20', 'Serena Williams', '1981-09-26', 'female');

INSERT INTO population.companies values ('Parkwood Entertainment', 'music');
INSERT INTO population.companies values ('Oscars', 'acting');
INSERT INTO population.companies values ('Amazon', 'business');
INSERT INTO population.companies values ('USA', 'politics');
INSERT INTO population.companies values ('Paris Saint-German', 'sports');
INSERT INTO population.companies values ('Universal Music Group', 'music');
INSERT INTO population.companies values ('Golden Globes', 'acting');
INSERT INTO population.companies values ('Microsoft', 'business');
INSERT INTO population.companies values ('France', 'politics');
INSERT INTO population.companies values ('Tennis Association', 'sports');

INSERT INTO population.employment values ('11', 'Parkwood Entertainment', '36000000');
INSERT INTO population.employment values ('12', 'Universal Music Group', '24000000');
INSERT INTO population.employment values ('13', 'Oscars', '14000000');
INSERT INTO population.employment values ('14', 'Golden Globes', '75000000');
INSERT INTO population.employment values ('15', 'Amazon', '7218241800');
INSERT INTO population.employment values ('16', 'Microsoft', '4000000000');
INSERT INTO population.employment values ('17', 'USA', '400000');
INSERT INTO population.employment values ('18', 'France', '194300');
INSERT INTO population.employment values ('19', 'Paris Saint-German', '41000000');
INSERT INTO population.employment values ('20', 'Tennis Association', '8000000');

SELECT field, avg(salary)/12 AS avg_monthly_income
FROM population.companies NATURAL JOIN population.employment
GROUP BY (field);