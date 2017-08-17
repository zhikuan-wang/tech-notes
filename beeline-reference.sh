# Execute SQL script
beeline -u jdbc:hive2://localhost:10000/cnedmp -n <user name> -p <password> -f <SQL script file>
