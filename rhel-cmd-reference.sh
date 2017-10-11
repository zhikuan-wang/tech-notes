# Check the signature of installed rpm packages
rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}-%{ARCH} %{SIGPGP:pgpsig} %{SIGGPG:pgpsig}\n' | grep -i mysql-community-common

# Online extend
lvextend -L +100G /dev/mapper/rootvg-appsvol
resize2fs -p /dev/mapper/rootvg-appsvol
