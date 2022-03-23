/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100), 
  date_of_birth DATE, 
  escape_attempts INT, 
  neutered BOOLEAN, 
  weight_kg DECIMAL
);

/* Day two update and delete records  */

ALTER TABLE animals
ADD COLUMN species VARCHAR;

/* Day three query multiple tables */

CREATE TABLE owners (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100) NOT NULL,
  age INT
);

CREATE TABLE species (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL
);

SELECT id FROM animals;
ALTER TABLE animals DROP  COLUMN species;
ALTER TABLE species ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE species ADD FOREIGN KEY (species_id) REFERENCES species(id);