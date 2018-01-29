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

# Generate Java Core Dump
jstack -l -F 136792 > 136792.out

# GPG Encrypt/Decrypt
# 1, Prepare configure file:
%echo Generating a basic OpenPGP key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: ELG-E
Subkey-Length: 4096
Name-Real: EDMpCN UAT
Name-Comment: with EDMpCN passphrase
Name-Email: StevenZhikuan.Wang@sc.com
Expire-Date: 0
Passphrase: EDMpCN
%commit
%echo done

# Generate key
gpg --batch --gen-key EDMpCN
gpg --list-key
gpg -armor --export StevenZhikuan.Wang@sc.com > EDMpCN.pub
gpg --import EDMpCN.pub
# Encryption
gpg --yes --always-trust --output 1.sql.gpg --encrypt --recipient StevenZhikuan.Wang@sc.com 1.sql
# Decryption
gpg --batch --yes --passphrase EDMpCN -o 1.sql --decrypt 1.sql.gpg

# Fix key issue
gpg --export-secret-keys > EDMpCN
gpg --allow-secret-key-import --import EDMpCN

# Add LV
sudo vgs
sudo lvs
sudo lvcreate -L 100G -n rootvg-appvol rootvg
sudo mkfs.ext4 /dev/rootvg/rootvg-appvol
sudo mount /dev/rootvg/rootvg-appvol /apps
sudo vi /etc/fstab
/dev/mapper/rootvg-rootvg--appvol /apps ext4 noatime,nodiratime 1 2
