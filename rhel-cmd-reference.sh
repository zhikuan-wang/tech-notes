# Check the signature of installed rpm packages
rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}-%{ARCH} %{SIGPGP:pgpsig} %{SIGGPG:pgpsig}\n' | grep -i mysql-community-common
