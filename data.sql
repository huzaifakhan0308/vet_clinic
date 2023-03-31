INSERT INTO animals (id,name, date_of_birth,escape_attempts,neutered,weight_kg)
  VALUES (1,'Agumon', '2020-02-03', 0, true, 10.23),
    (2,'Gabumon', '2018-11-15', 2, true, 8.03),
    (3,'Pikachu', '2021-01-07', 1, false, 15.04),
    (4,'Devimon', '2017-05-12', 5, true, 11.0);

INSERT INTO animals (id,name, date_of_birth,escape_attempts,neutered,weight_kg,species)
  VALUES (5,'Charmander', '2020-02-08', 0, false, -11, ''),
    (6,'Plantmon', '2021-11-15', 2, true, -5.7, ''),
    (7,'Squirtle', '1993-04-02', 3, false, -12.13, ''),
    (8,'Angemon', '2005-06-12', 1, true, -45, '');
    (9,'Boarmon', '2005-06-07', 7, true, 20.4, '');
    (10,'Blossom', '1998-09-13', 3, true, 17, '');
    (11,'Ditto', '2022-05-14', 4, true, 22, '');

INSERT INTO owners (id, full_name, age)
VALUES (1, 'Sam Smith', 34),
  (2, 'Jennifier Orwell', 19)
  (3, 'Bob', 45)
  (4, 'Melody Pond', 77)
  (5, 'Dean Winchester', 14),
  (6, 'Jodie Whittaker', 38)

INSERT INTO species (id, name)
VALUES (1, 'Pokemon'),
  (2, 'Digimon');

UPDATE animals 
SET species_id = 
  CASE
    WHEN name like '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    else (SELECT id FROM species WHERE name = 'Pokemon')
END;

UPDATE animals 
SET owner_id = 
  CASE
    WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;