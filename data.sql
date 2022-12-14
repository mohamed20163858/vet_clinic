/* Populate database with sample data. */

INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (1, 'Agumon', '2020-02-03', 10.23, true, 0);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (2, 'Gabumon', '2018-11-15', 8, true, 2);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (3, 'Pikachu', '2021-01-07', 15.04, false, 1);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (4, 'Devimon', '2017-05-12', 11, true, 5);

INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (5, 'Charmander', '2020-02-08', -11, false, 0);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (6, 'Plantmon', '2021-11-15', -5.7, true, 2);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (7, 'Squirtle', '1993-04-02', -12.13, false, 3);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (8, 'Angemon', '2005-06-12', -45, true, 1);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (9, 'Boarmon', '2005-06-07', 20.4, true, 7);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (10, 'Blossom', '1998-10-13', 17, true, 3);
INSERT INTO animals(id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES (11, 'Ditto', '2022-05-14', 22, true, 4);

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Pokemon') WHERE name NOT LIKE '%mon';

UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Sam Smith') WHERE  name='Agumon';
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Jennifer Orwell') WHERE  name='Gabumon' OR name='Pikachu';
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Bob') WHERE  name='Devimon' OR name='Plantmon';
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Melody Pond') WHERE  name='Charmander' OR name='Squirtle' OR name='Blossom';
UPDATE animals SET owner_id=(SELECT id FROM owners WHERE full_name='Dean Winchester') WHERE  name='Angemon' OR name='Boarmon';


INSERT INTO vets(name, age, date_of_graduation) VALUES('William Tatcher',45,'2000-04-23');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Maisy Smith',26,'2019-01-17');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Stephanie Mendez',64,'1981-05-04');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Jack Harkness',38,'2008-06-08');

INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name='Pokemon'),(SELECT id FROM vets WHERE name='William Tatcher'));
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name='Digimon'),(SELECT id FROM vets WHERE name='Stephanie Mendez'));
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name='Pokemon'),(SELECT id FROM vets WHERE name='Stephanie Mendez'));
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name='Digimon'),(SELECT id FROM vets WHERE name='Jack Harkness'));

-- insert visits 
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Agumon'),(SELECT id FROM vets WHERE name='William Tatcher'),'2020-05-24');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Agumon'),(SELECT id FROM vets WHERE name='Stephanie Mendez'),'2020-07-22');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Gabumon'),(SELECT id FROM vets WHERE name='Jack Harkness'),'2021-02-02');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Pikachu'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2020-01-05');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Pikachu'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2020-03-08');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Pikachu'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2020-05-14');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Devimon'),(SELECT id FROM vets WHERE name='Stephanie Mendez'),'2021-05-04');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Charmander'),(SELECT id FROM vets WHERE name='Jack Harkness'),'2021-02-24');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Plantmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2019-12-21');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Plantmon'),(SELECT id FROM vets WHERE name='William Tatcher'),'2020-08-10');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Plantmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2021-04-07');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Squirtle'),(SELECT id FROM vets WHERE name='Stephanie Mendez'),'2019-09-29');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Angemon'),(SELECT id FROM vets WHERE name='Jack Harkness'),'2020-10-03');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Angemon'),(SELECT id FROM vets WHERE name='Jack Harkness'),'2020-11-04');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Boarmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2019-01-24');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Boarmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2019-05-15');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Boarmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2020-02-27');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Boarmon'),(SELECT id FROM vets WHERE name='Maisy Smith'),'2020-08-03');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Blossom'),(SELECT id FROM vets WHERE name='Stephanie Mendez'),'2020-05-24');

INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name='Blossom'),(SELECT id FROM vets WHERE name='William Tatcher'),'2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

UPDATE animals
SET visit_count = n_of_visits
FROM (select COUNT(*) AS n_of_visits, animal_id FROM visits GROUP BY animal_id) AS x
WHERE animals.id = x.animal_id;
