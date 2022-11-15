/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
 id INT,
 name VARCHAR,
 date_of_birth DATE,
 escape_attempts INT,
 neutered BOOL,
 weight_kg DECIMAL
);
ALTER TABLE animals ADD species VARCHAR;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR,
    age INT,
    PRIMARY KEY(id)
);
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    PRIMARY KEY(id)
);
ALTER TABLE animals DROP id;
ALTER TABLE animals ADD id INT GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals ADD PRIMARY KEY(id);
ALTER TABLE animals DROP species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);


CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    FOREIGN KEY(species_id) REFERENCES species(id),
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    PRIMARY KEY(species_id, vet_id)
);
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    FOREIGN KEY(animal_id) REFERENCES animals(id),
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    PRIMARY KEY(animal_id, vet_id, date_of_visit )
);
-- performance project
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE animals
ADD COLUMN visit_count INT;

UPDATE animals
SET visit_count = n_of_visits
FROM (select COUNT(*) AS n_of_visits, animal_id FROM visits GROUP BY animal_id) AS x
WHERE animals.id = x.animal_id;


