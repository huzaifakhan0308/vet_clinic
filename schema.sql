CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id int,
    name text,
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species TEXT

CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name text,
	age int
);

CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name text
);

ALTER TABLE animals 
DROP COLUMN species

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id)