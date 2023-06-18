create database dbMultiple;

-- LEVES
--=======
CREATE TABLE guide (
    idGuide CHAR(3) PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    content TEXT NOT NULL,
    bonus INT
);

CREATE TABLE objective (
    idObjetive CHAR(3) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    requirement TEXT,
    reward INTEGER
);

CREATE TABLE level (
    idLevel CHAR(3) PRIMARY KEY NOT NULL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    difficulty TEXT NOT NULL,
    score INTEGER NOT NULL,

    idGuide CHAR(3),
    FOREIGN KEY (idGuide) REFERENCES guide(idGuide)
);

CREATE TABLE sublevel (
    idSublevel CHAR(3) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    difficulty TEXT NOT NULL,
    score INTEGER NOT NULL,

    idLevel CHAR(3) NOT NULL,
    FOREIGN KEY (idLevel) REFERENCES level(idLevel)
);

CREATE TABLE level_objective (
    idLevel CHAR(3) NOT NULL,
    idObjetive CHAR(3) NOT NULL,
    FOREIGN KEY (idLevel) REFERENCES level(idLevel),
    FOREIGN KEY (idObjetive) REFERENCES objective(idObjetive)
);


-- USER
--======
create table user (
	idUser char(3) primary key not null,
	firstName text not null,
	surName text not null,
	alias text not null unique,
	password text not null,
	registerDate datetime not null,

    idLevel char(3),
    foreign key (idLevel) references level(idLevel)
);

create table inventory (
	idInventory char(3) primary key not null,
	dateObtained datetime not null,
    points int not null,
    coin real not null,
    idItems text, -- guarda las claves de sus items

    idUser char(3),
    foreign key (idUser) references user(idUser)
);

create table store (
    idItems char(5) primary key not null,
    name text not null unique,
    description text,
    amount int not null,
    tipe text not null,
    atributo text not null,
    image blob
);

-- Triggers
--=========
CREATE TRIGGER delete_user_inventory
BEFORE DELETE ON user
BEGIN
    DELETE FROM inventory WHERE idUser = OLD.idUser;
END;


-- Insertar datos en la tabla "guide"
INSERT INTO guide (idGuide, title, description, content, bonus)
VALUES
    ('G01', 'Guide 1', 'Description of Guide 1', 'Content of Guide 1', 50),
    ('G02', 'Guide 2', 'Description of Guide 2', 'Content of Guide 2', 100);


-- Insertar datos en la tabla "objective"
INSERT INTO objective (idObjetive, name, description, requirement, reward)
VALUES
    ('O01', 'Objective 1', 'Description of Objective 1', null, 50),
    ('O02', 'Objective 2', 'Description of Objective 2', null, 75),
    ('O03', 'Objective 3', 'Description of Objective 3', 'L01', 100),
    ('O04', 'Objective 4', 'Description of Objective 4', 'L02', 150);


-- Insertar datos en la tabla "level"
INSERT INTO level (idLevel, name, description, difficulty, score, idGuide)
VALUES
    ('L01', 'Level 1', 'Description of Level 1', 'Easy', 100, 'G01'),
    ('L02', 'Level 2', 'Description of Level 2', 'Medium', 200, 'G01'),
    ('L03', 'Level 3', 'Description of Level 3', 'Hard', 300, 'G02'),
    ('L04', 'Level 4', 'Description of Level 4', 'Expert', 400, 'G02');

-- Insertar datos en la tabla "sublevel"
INSERT INTO sublevel (idSublevel, name, description, difficulty, score, idLevel)
VALUES
    ('S01', 'Sublevel 1', 'Description of Sublevel 1', 'Easy', 50, 'L01'),
    ('S02', 'Sublevel 2', 'Description of Sublevel 2', 'Medium', 75, 'L01'),
    ('S03', 'Sublevel 3', 'Description of Sublevel 3', 'Hard', 100, 'L01'),
    ('S04', 'Sublevel 4', 'Description of Sublevel 4', 'Expert', 150, 'L01'),
    ('S05', 'Sublevel 1', 'Description of Sublevel 1', 'Easy', 50, 'L02'),
    ('S06', 'Sublevel 2', 'Description of Sublevel 2', 'Medium', 75, 'L02'),
    ('S07', 'Sublevel 3', 'Description of Sublevel 3', 'Hard', 100, 'L02'),
    ('S08', 'Sublevel 4', 'Description of Sublevel 4', 'Expert', 150, 'L02'),
    ('S09', 'Sublevel 1', 'Description of Sublevel 1', 'Easy', 50, 'L03'),
    ('S10', 'Sublevel 2', 'Description of Sublevel 2', 'Medium', 75, 'L03'),
    ('S11', 'Sublevel 3', 'Description of Sublevel 3', 'Hard', 100, 'L03'),
    ('S12', 'Sublevel 4', 'Description of Sublevel 4', 'Expert', 150, 'L03'),
    ('S13', 'Sublevel 1', 'Description of Sublevel 1', 'Easy', 50, 'L04'),
    ('S14', 'Sublevel 2', 'Description of Sublevel 2', 'Medium', 75, 'L04'),
    ('S15', 'Sublevel 3', 'Description of Sublevel 3', 'Hard', 100, 'L04'),
    ('S16', 'Sublevel 4', 'Description of Sublevel 4', 'Expert', 150, 'L04');


-- Insertar datos en la tabla "level_objective"
INSERT INTO level_objective (idLevel, idObjetive)
VALUES
    ('L01', 'O01'),
    ('L01', 'O02'),
    ('L02', 'O01'),
    ('L02', 'O02'),
    ('L03', 'O03'),
    ('L03', 'O04'),
    ('L04', 'O03'),
    ('L04', 'O04');
