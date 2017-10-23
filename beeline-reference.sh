# Execute SQL script
beeline -u jdbc:hive2://localhost:10000/cnedmp -n <user name> -p <password> -f <SQL script file>
# Create external table
CREATE EXTERNAL TABLE IF NOT EXISTS `MIDAS_FXACT` (
    `RECORD_ID` string
)
PARTITIONED BY (`dt` string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\u0001'
LOCATION '/cdsh/cdsh_processed/MIDAS_FXACT'
;
# Create hive managed table
CREATE TABLE IF NOT EXISTS `Bcustlist` (
    `RELATIONSHIPNO` string
);
load data inpath '/cdsh/Bcustlist/Bcustlist.csv' into table Bcustlist;

# Describe table
desc formatted EBBS_FX_RATE;
