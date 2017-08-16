# Set ACL
hdfs dfs -setfacl -m -R user:hive:rwx /cdsh
# Clear ACL
hdfs dfs -setfacl -b -R user:hive /cdsh
# Get ACL
hdfs dfs -getfacl /cdsh
