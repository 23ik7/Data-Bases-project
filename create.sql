drop table IF EXISTS Gutachten CASCADE;
drop table IF EXISTS Gutachter CASCADE;
drop table IF EXISTS Hergestellt_aus CASCADE;
DROP TABLE IF EXISTS Wein CASCADE;
drop table IF EXISTS Rebsorte CASCADE;
drop table IF EXISTS Lizenz CASCADE;
drop table IF EXISTS Erzeuger CASCADE;

CREATE TABLE Erzeuger ( 	-- Producer 
  weingut varchar(20), 		-- winery 
  anbaugebiet varchar(20),	-- vineyard 
  region varchar(20),
  PRIMARY KEY (weingut), UNIQUE (anbaugebiet)
);
CREATE TABLE Lizenz(		-- License 
  weingut varchar(20),		-- winery 
  lizenznr char(9),			-- license number 
  menge int,				-- quantity 
  PRIMARY KEY (weingut, lizenznr),
  FOREIGN KEY (weingut) REFERENCES erzeuger(weingut)
  ON UPDATE CASCADE
);
CREATE TABLE Rebsorte(		-- grape variety 
  Farbe char(4),			-- color 
  Name varchar(20),			-- name 
  PRIMARY KEY (name)
);
CREATE TABLE Wein (			-- Wine 
  wid int not null,
  name varchar(40) not null,
  farbe char(4) not  null default 'rot',	-- color , default 'rot'
  jahrgang int,								-- vintage 
  weingut varchar(20),						-- producer winery 
  PRIMARY KEY (wid),
  UNIQUE (name),
  FOREIGN KEY (weingut) REFERENCES Erzeuger(weingut)
);
CREATE TABLE Hergestellt_aus (		-- Produced_from 
  wid int,
  rname varchar(20),			-- name of grape variety
  anteil int, 						-- content percentage
  PRIMARY KEY (wid, rname),
  FOREIGN KEY (wid) REFERENCES wein(wid)
  ON UPDATE CASCADE,
  FOREIGN KEY (rname) REFERENCES rebsorte(name)
  ON UPDATE CASCADE
);
CREATE TABLE Gutachter(		-- Reviewer
  gid int,
  titel varchar(40),		-- title
  name varchar(40),			-- last name
  vorname varchar(40),		-- first name
  weingut varchar(40),		-- employer winery 
  primary key (gid),
  FOREIGN KEY (weingut) REFERENCES erzeuger(weingut)
);
CREATE TABLE Gutachten (	-- Review
  wid int,
  gid int,
  punkte int, 				-- [0,10] in N
  PRIMARY KEY (wid, gid),
  FOREIGN KEY (wid) REFERENCES Wein(wid)
  ON UPDATE CASCADE,
  FOREIGN KEY (gid) REFERENCES Gutachter(gid)
  ON UPDATE CASCADE
);

SELECT * FROM erzeuger, gutachter;