# Check the signature of installed rpm packages
rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}-%{ARCH} %{SIGPGP:pgpsig} %{SIGGPG:pgpsig}\n' | grep -i mysql-community-common

# Online extend
lvextend -L +100G /dev/mapper/rootvg-appsvol
resize2fs -p /dev/mapper/rootvg-appsvol

# Python HTTP File server
# Python 2.7.x
python -m SimpleHTTPServer
# Python 3.x
python -m  http.server 8000
