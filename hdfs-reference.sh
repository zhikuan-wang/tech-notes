# Set ACL
hdfs dfs -setfacl -m -R user:hive:rwx /cdsh
# Set default ACL
hdfs dfs -setfacl -m -R default:user:hive:rwx /cdsh
hdfs dfs -setfacl -m -R default:other::r-x /cdsh
# Clear ACL
hdfs dfs -setfacl -b -R /cdsh
# Get ACL
hdfs dfs -getfacl /cdsh

# Resolve the umask and ACL conflict
# 1, change umask to 002 and restart cluster.
hive-site.xml
<name>fs.permissions.umask-mode</name>
<value>002</value>
# 2, Change ACL
hdfs dfs -setfacl -m -R default:user:hive:rwx /cdsh
hdfs dfs -setfacl -m -R default:other::r-x /cdsh
hdfs dfs -setfacl -m -R user:hive:rwx /cdsh
hdfs dfs -chmod -R 775 /cdsh

# File copy
sudo su hdfs -c "hdfs dfs -cp /cdsh/cdsh_processed/ebbs_FX_RATE/20170929/part-r--m-00000.gz /cdsh/cdsh_processed/ebbs_FX_RATE/20170930/part-r--m-00000.gz"
