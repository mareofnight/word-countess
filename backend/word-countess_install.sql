 -- v0.0 2014-09-11 Kim Desorcie
 -- For use with MySQL 5.5. Might need tweaks for a different DBMS.

drop database if exists countess;
create database countess;-- mareofni_countess
  CREATE USER 'countess'@'localhost' IDENTIFIED BY 'password'; -- mareofni_countes with one 's'
  GRANT ALL PRIVILEGES ON countess TO 'countess';

use countess;-- mareofni_countess

DROP TABLE IF EXISTS Wordcount;
DROP TABLE IF EXISTS Authorship;
DROP TABLE IF EXISTS Document;
DROP TABLE IF EXISTS Membership;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS User;

CREATE TABLE User (
  id          INT         AUTO_INCREMENT,
  googleID    VARCHAR(255)    NOT NULL UNIQUE,
  CONSTRAINT user_pk PRIMARY KEY (id),
  CONSTRAINT user_googleID_unique UNIQUE (googleID)
)ENGINE=InnoDB;

CREATE TABLE Project (
  id          INT         AUTO_INCREMENT,
  name        VARCHAR(50) NOT NULL,
  CONSTRAINT project_pk PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE Membership (
  id          INT         AUTO_INCREMENT,
  userID      INT         NOT NULL,
  projectID   INT         NOT NULL,
  deleted     BOOL        NOT NULL DEFAULT true,
  CONSTRAINT membership_pk PRIMARY KEY (id),
  CONSTRAINT membership_user_fk FOREIGN KEY (userID) REFERENCES User(id),
  CONSTRAINT membership_project_fk FOREIGN KEY (projectID) REFERENCES Project(id)
)ENGINE=InnoDB;

CREATE TABLE Document (
  id          INT         AUTO_INCREMENT,
  googleID    VARCHAR(255) NOT NULL,
  projectID   INT          NOT NULL,
  CONSTRAINT document_pk PRIMARY KEY (id),
  CONSTRAINT document_googleID_unique UNIQUE (googleID),
  CONSTRAINT document_project_fk FOREIGN KEY (projectID) REFERENCES Project(id)
)ENGINE=InnoDB;

CREATE TABLE Authorship (
  id          INT         AUTO_INCREMENT,
  userID      INT         NOT NULL,
  documentID  INT         NOT NULL,
  deleted     BOOL        NOT NULL DEFAULT true,
  CONSTRAINT authorship_pk PRIMARY KEY (id),
  CONSTRAINT authorship_user_fk FOREIGN KEY (userID) REFERENCES User(id),
  CONSTRAINT authorship_document_fk FOREIGN KEY (documentID) REFERENCES Document(id)
)ENGINE=InnoDB;

CREATE TABLE Wordcount (
  id          BIGINT      AUTO_INCREMENT,
  documentID  INT         NOT NULL,
  time        INT         NOT NULL, -- Unix time, no fractional seconds
  CONSTRAINT wordcount_pk PRIMARY KEY (id),
  CONSTRAINT wordcount_document_fk FOREIGN KEY (documentID) REFERENCES Document(id)
)ENGINE=InnoDB;
