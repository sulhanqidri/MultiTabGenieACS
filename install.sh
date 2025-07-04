#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
local_ip=$(hostname -I | awk '{print $1}')

# Install git
apt install git -y

# Clone Git
git clone https://github.com/sulhanqidri/MultiTabGenieACS

# Masuk folder
cd MultiTabGenieACS

# Repelace folder GenieACS
cp -ru genieacs /usr/lib/node_modules/

# Restor Database GenieACS
mongorestore --db genieacs --drop database

# Keluar 1 Folder
cd ..

# Hapus Folder
rm -r AutoInstallGenieACS/ MultiTabGenieACS/

#Sukses
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========== GenieACS UI akses port 3000. : http://$local_ip:3000 ============${NC}"
echo -e "${GREEN}=================== Informasi: Whatsapp 0853-2269-2888 =====================${NC}"
echo -e "${GREEN}============================================================================${NC}"
#Restart

for ((i = 3; i >= 1; i--)); do
	sleep 1
    echo "Menghitung $i. Tekan ctrl+c untuk membatalkan Restart"
done

reboot