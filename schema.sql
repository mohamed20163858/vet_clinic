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


