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

0: jdbc:hive2://10.27.238.61:10000> select from_unixtime(unix_timestamp('01/01/2017 00:00:00', 'dd/MM/yyyy hh:mm:ss'), 'yyyyMMdd');
+-----------+--+
|    _c0    |
+-----------+--+
| 20170101  |
+-----------+--+
1 row selected (0.181 seconds)
0: jdbc:hive2://10.27.238.61:10000>

0: jdbc:hive2://10.27.238.61:10000> select * from tbl_test;
+---------------+----------------+----------------+----------------+--+
| tbl_test.key  | tbl_test.col1  | tbl_test.col2  | tbl_test.col3  |
+---------------+----------------+----------------+----------------+--+
| 001           | jack           | NULL           | NULL           |
| 001           | NULL           | steven         | tom            |
| 001           | jack           | jim            | NULL           |
| 002           | jack           | jim            | lili           |
+---------------+----------------+----------------+----------------+--+
4 rows selected (0.077 seconds)
0: jdbc:hive2://10.27.238.61:10000> select distinct key, value from tbl_test lateral view explode(array(col1, col2, col3)) tbl as value where value is not null;
INFO  : Session is already open
INFO  : Dag name: select distinct key, value from tbl_t...null(Stage-1)
INFO  :

INFO  : Status: Running (Executing on YARN cluster with App id application_1510707629210_0501)

INFO  : Map 1: 0/1      Reducer 2: 0/1
INFO  : Map 1: 0(+1)/1  Reducer 2: 0/1
INFO  : Map 1: 1/1      Reducer 2: 0/1
INFO  : Map 1: 1/1      Reducer 2: 0(+1)/1
INFO  : Map 1: 1/1      Reducer 2: 1/1
+------+---------+--+
| key  |  value  |
+------+---------+--+
| 001  | jack    |
| 001  | jim     |
| 001  | steven  |
| 001  | tom     |
| 002  | jack    |
| 002  | jim     |
| 002  | lili    |
+------+---------+--+
7 rows selected (1.994 seconds)
0: jdbc:hive2://10.27.238.61:10000>
