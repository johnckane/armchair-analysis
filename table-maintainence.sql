-- add a foreign key
ALTER TABLE play ADD CONSTRAINT gid FOREIGN KEY (gid) REFERENCES game(gid);
