/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;

-- begin a transaction
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species='pokemon' WHERE name NOT LIKE '%mon';
SELECT * FROM animals;
COMMIT;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SELECT * FROM animals;
SAVEPOINT s1;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO s1;
SELECT * FROM animals;
BEGIN;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg<0;
SELECT * FROM animals;
COMMIT;
-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts) FROM animals WHERE neutered=true;
SELECT SUM(escape_attempts) FROM animals WHERE neutered=false;
-- it is clear that neutered animals escaped the most

-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg),MAX(weight_kg) FROM animals WHERE species='digimon';
SELECT MIN(weight_kg),MAX(weight_kg) FROM animals WHERE species='pokemon';

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM animals WHERE species='digimon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';
SELECT AVG(escape_attempts) FROM animals WHERE species='pokemon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';

-- What animals belong to Melody Pond?
SELECT A.name AS Melody_Pond_Animals FROM animals A JOIN owners O ON A.owner_id = O.id WHERE O.full_name='Melody Pond';
-- List of all animals that are pokemon
SELECT A.name AS Pokemon_Animals FROM animals A JOIN species S ON A.species_id=S.id WHERE S.name='Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT O.full_name, A.name AS owns FROM owners O LEFT JOIN animals A ON A.owner_id=O.id;
-- How many animals are there per species?
SELECT COUNT(A.name) AS number_of_animals_per_species, S.name FROM animals A LEFT JOIN species S ON A.species_id=S.id GROUP BY S.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT A.name AS Jennifer_Orwell_Digimon_Animals FROM owners O JOIN Animals A ON A.owner_id=O.id WHERE O.full_name='Jennifer Orwell' AND A.species_id=(SELECT id FROM species WHERE name='Digimon');
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name As Dean_Winchester_Peacefull_Animals FROM owners O JOIN Animals A ON A.owner_id=O.id WHERE A.escape_attempts=0 AND O.full_name='Dean Winchester';
-- Who owns the most animals?
SELECT O.full_name, COUNT(A.name) FROM animals A RIGHT JOIN owners O ON A.owner_id=O.id GROUP BY O.full_name;
-- so it Meldoy owns the Most animals;
SELECT MAX(x.count) FROM(SELECT O.full_name, COUNT(A.name) FROM animals A RIGHT JOIN owners O ON A.owner_id=O.id GROUP BY O.full_name)x;
SELECT x.full_name AS owns_most_animals FROM(SELECT O.full_name, COUNT(A.name) FROM animals A RIGHT JOIN owners O ON A.owner_id=O.id GROUP BY O.full_name)x WHERE x.count=3;
