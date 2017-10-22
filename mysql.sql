create user 'docker'@'%' identified by 'VTPhz8Gj';
grant ALL on docker.* to 'docker'@'%';
flush privileges;

CREATE TABLE `docker`.`book` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `publish_date` DATETIME NULL,
  PRIMARY KEY (`ID`)
) COMMENT="book";
insert into book(`author`, `title`, `publish_date`) values ('Steven', 'Hello Docker', NOW());
