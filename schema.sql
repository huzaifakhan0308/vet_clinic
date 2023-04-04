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

CREATE TABLE vets (
  id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY
  (START WITH 1 INCREMENT BY 1),
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE
);

-- Create a "join table" called specializations

CREATE TABLE specializations (
  vet_id INT,
  species_id INT,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
  FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE
);

-- Create a "join table" called visits

CREATE TABLE visits (
  id INT PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY
  (START WITH 1 INCREMENT BY 1),
  vet_id INT,
  animal_id INT,
  date_of_visit DATE,
  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
  FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE
);