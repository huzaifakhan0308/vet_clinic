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

-- Insert the following data into the vets table

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');

-- Insert the following data into the specializations table

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1),
       (3, 1),
       (3, 2),
       (4, 2);
-- Insert the following data into the visits table

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
((SELECT id FROM animals WHERE name = 'Agumon'), 1, '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Agumon'), 3, '2020-07-22'),
((SELECT id FROM animals WHERE name = 'Gabumon'), 4, '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'), 2, '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'), 2, '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'), 2, '2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon'), 3, '2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander'), 4, '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon'), 2, '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon'), 1, '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon'), 2, '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle'), 3, '2019-09-29'),
((SELECT id FROM animals WHERE name = 'Angemon'), 4, '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon'), 4, '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon'), 2, '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon'), 2, '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon'), 2, '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon'), 2, '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom'), 3, '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom'), 1, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, age, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';