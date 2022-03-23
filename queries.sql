/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-03-12';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

/* Day-2 Database update and delete recordings */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
END;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;
END;

BEGIN;
DELETE FROM animals;
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
END;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT remove_Ditto;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO remove_Ditto;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
END;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals GROUP BY escape_attempts HAVING escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight_kg, MAX(weight_kg) AS max_weight_kg  FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts  FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/* Day 3 query multiple tables */

/* What animals belong to Melody Pond? */
SELECT name FROM animals A
    JOIN owners O
    ON A.owner_id = O.id
    WHERE O.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT A.name FROM animals A
    JOIN species S
    ON A.species_id = S.id
    WHERE S.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT full_name, name FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id;

/* How many animals are there per species? */
SELECT S.name, COUNT(A.name) FROM species S
    LEFT JOIN animals A
    ON S.id = a.species_id
    GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT A.name FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id
    LEFT JOIN species S
    ON A.species_id = S.id
    WHERE full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

/* List all animals owned by  that haven't tried to escape. */
SELECT name FROM owners O
    JOIN animals A
    ON O.id = A.owner_id
    WHERE O.full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT full_name, COUNT(name) FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id
    GROUP BY full_name;
