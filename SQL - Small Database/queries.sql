use population;
SELECT field, avg(salary)/12 AS avg_monthly_income
FROM population.companies NATURAL JOIN population.employment
GROUP BY (field);

use infrastructure;
SELECT street, building_number
FROM building
WHERE type = 'residential';

use recreation;
SELECT person.name AS person_name, club, stadium.name AS stadium_name
FROM stadium NATURAL JOIN participates, population.person
WHERE person.person_ID = participates.person_ID;