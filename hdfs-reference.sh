# Set ACL
hdfs dfs -setfacl -m -R user:hive:rwx /cdsh
# Clear ACL
hdfs dfs -setfacl -b -R /cdsh
# Get ACL
hdfs dfs -getfacl /cdsh
