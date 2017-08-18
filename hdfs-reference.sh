# Set ACL
hdfs dfs -setfacl -m -R user:hive:rwx /cdsh
# Set default ACL
hdfs dfs -setfacl -m -R default:user:hive:rwx /cdsh
hdfs dfs -setfacl -m -R default:other::r-x /cdsh
# Clear ACL
hdfs dfs -setfacl -b -R /cdsh
# Get ACL
hdfs dfs -getfacl /cdsh
