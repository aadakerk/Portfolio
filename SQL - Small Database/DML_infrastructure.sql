use infrastructure;

INSERT INTO infrastructure.roads values ('Baker Street', '40');
INSERT INTO infrastructure.roads values ('Broadway', '20');
INSERT INTO infrastructure.roads values ('Abbey Road', '40');
INSERT INTO infrastructure.roads values ('Champs-Elysees', '50');
INSERT INTO infrastructure.roads values ('Hollywood Boulevard', '20');
INSERT INTO infrastructure.roads values ('Wall Street', '15');
INSERT INTO infrastructure.roads values ('Downing Street', '50');
INSERT INTO infrastructure.roads values ('La Rambla', '70');
INSERT INTO infrastructure.roads values ('Las Vegas Strip', '80');
INSERT INTO infrastructure.roads values ('Lombard Street', '40');

INSERT INTO infrastructure.building values ('1', 'Baker Street', 'business');
INSERT INTO infrastructure.building values ('1', 'Broadway', 'residential');
INSERT INTO infrastructure.building values ('1', 'Abbey Road', 'residential');
INSERT INTO infrastructure.building values ('1', 'Champs-Elysees', 'business');
INSERT INTO infrastructure.building values ('1', 'Hollywood Boulevard', 'culture');
INSERT INTO infrastructure.building values ('1', 'Wall Street', 'business');
INSERT INTO infrastructure.building values ('1', 'Downing Street', 'government');
INSERT INTO infrastructure.building values ('1', 'La Rambla', 'residential');
INSERT INTO infrastructure.building values ('1', 'Las Vegas Strip', 'casino');
INSERT INTO infrastructure.building values ('1', 'Lombard Street', 'residential');
INSERT INTO infrastructure.building values ('221', 'Baker Street', 'residential');
INSERT INTO infrastructure.building values ('2', 'Broadway', 'culture');
INSERT INTO infrastructure.building values ('2', 'Abbey Road', 'culture');
INSERT INTO infrastructure.building values ('2', 'Wall Street', 'business');

INSERT INTO infrastructure.transportation values ('Baker Street', 'bus', '123');
INSERT INTO infrastructure.transportation values ('Broadway', 'subway', '234');
INSERT INTO infrastructure.transportation values ('Abbey Road', 'train', '345');
INSERT INTO infrastructure.transportation values ('Champs-Elysees', 'bus', '456');
INSERT INTO infrastructure.transportation values ('Hollywood Boulevard', 'subway', '567');
INSERT INTO infrastructure.transportation values ('Wall Street', 'subway', '678');
INSERT INTO infrastructure.transportation values ('Downing Street', 'tram', '789');
INSERT INTO infrastructure.transportation values ('La Rambla', 'tram', '890');
INSERT INTO infrastructure.transportation values ('Las Vegas Strip', 'bus', '901');
INSERT INTO infrastructure.transportation values ('Lombard Street', 'bus', '101');

SELECT street, building_number
FROM building
WHERE type = 'residential';