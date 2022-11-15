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

-- add "join table" for visits exercise

-- Who was the last animal seen by William Tatcher?
SELECT name AS last_visited_animal FROM animals WHERE id=
(SELECT animal_id from visits WHERE date_of_visit = 
(SELECT MAX(date_of_visit) from visits WHERE vet_id=(SELECT id FROM vets WHERE name='William Tatcher')));

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(x) FROM 
(SELECT DISTINCT animal_id FROM visits WHERE vet_id =(SELECT id FROM vets WHERE name='Stephanie Mendez'))x;

-- List all vets and their specialties, including vets with no specialties.
SELECT x.name AS vet_name, s.name AS specialization FROM 
(SELECT v.name,s.species_id FROM vets v LEFT JOIN specializations s ON v.id = s.vet_id)x
LEFT JOIN species s ON x.species_id=s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name FROM animals a JOIN 
(SELECT animal_id FROM visits WHERE vet_id =(SELECT id FROM vets WHERE name='Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30'))x
ON a.id=x.animal_id;

-- What animal has the most visits to vets?
SELECT name FROM animals WHERE id=
(SELECT x.animal_id FROM
(SELECT COUNT(animal_id), animal_id FROM visits GROUP BY animal_id) x WHERE x.count=(SELECT MAX(y.count) FROM (SELECT COUNT(animal_id), animal_id FROM visits GROUP BY animal_id) y));

-- Who was Maisy Smith's first visit?
SELECT name FROM animals WHERE id = 
(SELECT animal_id FROM visits WHERE date_of_visit=
(SELECT MIN(date_of_visit) FROM visits WHERE vet_id=(SELECT id FROM vets WHERE name='Maisy Smith'))); 

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM visits WHERE date_of_visit=
(SELECT MAX(date_of_visit) FROM visits);
-- animal information
SELECT  x.name, x.date_of_birth, x.escape_attempts, x.neutered, x.weight_kg, x.specie, o.full_name AS owner_full_name FROM 
(SELECT a.owner_id, a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg, s.name AS specie FROM animals a JOIN species s ON a.species_id=s.id WHERE a.id=4) x JOIN owners o ON o.id=x.owner_id;
-- vet information
SELECT v.name, v.age, v.date_of_graduation, s.name AS specialization FROM 
(SELECT  v.name, v.age, v.date_of_graduation, s.species_id FROM vets v JOIN specializations s on s.vet_id=v.id where v.id = 3) v JOIN species s on s.id=v.species_id;

-- How many visits were with a vet that did not specialize in that animal's species?

-- let's construct a table that have visits from non specialised animals first
SELECT v.name, v.specialization, a.name, a.animal_specie FROM 
(SELECT v.name, v.id, s.species_id AS specialization FROM vets v LEFT JOIN specializations s ON s.vet_id=v.id) v 
LEFT JOIN 
(SELECT a.name, a.species_id AS animal_specie, v.vet_id FROM animals a JOIN visits v ON a.id=v.animal_id) a 
ON v.id=a.vet_id WHERE v.specialization<>a.animal_specie OR v.specialization IS NULL ;


-- now lets count the number of visits per name using the previous table
SELECT x.vet_name, COUNT(x.vet_name) AS number_of_non_specialized_animal_visits FROM 
(SELECT v.name AS vet_name, v.specialization, a.name AS animal_name, a.animal_specie FROM 
(SELECT v.name, v.id, s.species_id AS specialization FROM vets v LEFT JOIN specializations s ON s.vet_id=v.id) v 
LEFT JOIN 
(SELECT a.name, a.species_id AS animal_specie, v.vet_id FROM animals a JOIN visits v ON a.id=v.animal_id) a 
ON v.id=a.vet_id WHERE v.specialization<>a.animal_specie OR v.specialization IS NULL) x GROUP BY x.vet_name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

-- let's first list the  animals visited maisy and theirs species
SELECT  a.name AS animal_name_visited_maisy, a.animal_specie FROM 
(SELECT v.name, v.id, s.species_id AS specialization FROM vets v LEFT JOIN specializations s ON s.vet_id=v.id) v 
LEFT JOIN 
(SELECT a.name, a.species_id AS animal_specie, v.vet_id FROM animals a JOIN visits v ON a.id=v.animal_id) a 
ON v.id=a.vet_id WHERE  v.name='Maisy Smith';

-- now let's count the number of species visited her using the previous table
SELECT  animal_specie, COUNT(animal_specie) FROM 
(SELECT  a.name AS animal_name_visited_maisy, a.animal_specie FROM 
(SELECT v.name, v.id, s.species_id AS specialization FROM vets v LEFT JOIN specializations s ON s.vet_id=v.id) v 
LEFT JOIN 
(SELECT a.name, a.species_id AS animal_specie, v.vet_id FROM animals a JOIN visits v ON a.id=v.animal_id) a 
ON v.id=a.vet_id WHERE  v.name='Maisy Smith') x
GROUP BY animal_specie;

-- now it is clear that maisy is specialised in :- 
SELECT name FROM species where id =2;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;