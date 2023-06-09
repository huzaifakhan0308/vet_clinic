SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals;
COMMIT;
SELECT species from animals;

--  Inside a transaction delete all records in the animals table, then roll back the transaction.
--  After the rollback verify if all records in the animals table still exists.

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction:
-- · Delete all animals born after Jan 1st, 2022.
-- · Create a savepoint for the transaction.
-- · Update all animals' weight to be their weight multiplied by -1.
-- · Rollback to the savepoint
-- · Update all animals' weights that are negative to be their weight multiplied by -1.
-- · Commit transaction

DELETE from animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sql1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO sql1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- · How many animals are there?
SELECT COUNT(*) FROM animals;
-- · How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- · What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- · Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
-- · What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- · What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- What animals belong to Melody Pond?
SELECT * FROM animals JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don not own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.id) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals RIGHT JOIN owners ON owner_id = owners.id WHERE full_name = 'Jennifer Orwell' AND species_id = (SELECT id FROM species WHERE name = 'Digimon'); 

-- List all animals owned by Dean Winchester that haven not tried to escape.
SELECT * FROM animals RIGHT JOIN owners ON animal.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND animals.escape_attempts < 0;

-- Who owns the most animals?
SELECT full_name AS "Owner", COUNT(owner_id) AS MaxAnimals FROM animals INNER JOIN owners ON owner_id = owners.id  GROUP BY full_name ORDER BY MaxAnimals DESC LIMIT 1;

-- Last animal seen by William 
SELECT a.name, v.date_of_visit FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- Count of animals treated by Stephanie
SELECT COUNT(*) FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- List of vets and specialities
SELECT vt.name, s.name FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON s.id = sp.species_id;

-- Animals that visited Stephanie between '2020-04-01' and '2020-08-30'
SELECT a.name, v.date_of_visit FROM animals a
JOIN visits v ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- Animal with the most visits
SELECT a.name, COUNT(*) FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name 
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Maisy's first visit 
SELECT a.name, v.date_of_visit FROM vets vt
JOIN visits v ON vt.id = v.vet_id
JOIN animals a ON a.id = v.animal_id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.date_of_visit
LIMIT 1;

-- Detail of most recent visit 
SELECT v.date_of_visit, vt.*, a.* FROM vets vt
JOIN visits v ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
ORDER BY v.date_of_visit DESC
LIMIT 1;

-- Visits for each vet outside their specialization
SELECT vt.name, COUNT(*) FROM vets vt
JOIN visits v ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON sp.vet_id = vt.id
WHERE sp.species_id != a.species_id OR sp.species_id IS NULL
GROUP BY vt.name;

-- Most treated species by Maisy
SELECT s.name, COUNT(*) FROM vets vt
JOIN visits v ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
JOIN species s ON a.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;