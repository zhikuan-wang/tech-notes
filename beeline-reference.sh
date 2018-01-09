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

0: jdbc:hive2://10.27.238.61:10000> select from_unixtime(unix_timestamp('2017/01/01 00:00:00', 'yyyy/MM/dd hh:mm:ss'), 'yyyyMMdd');
+-----------+--+
|    _c0    |
+-----------+--+
| 20170101  |
+-----------+--+
1 row selected (0.087 seconds)
0: jdbc:hive2://10.27.238.61:10000>
