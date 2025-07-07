#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
local_ip=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}==================== Script Install  MultiTab GenieACS. ====================${NC}"
echo -e "${GREEN}===================== By LSTNetwork. Info 085322692888 =====================${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}Multi tab full parameter? (y/n)${NC}"
read installtabfull
if [ "$installtabfull" != "y" ]; then
    # Replace folder GenieACS
    cp -ru genieacs /usr/lib/node_modules/
    rm -r /usr/lib/node_modules/genieacs/public/app.css /usr/lib/node_modules/genieacs/public/logo.svg
    mv /usr/lib/node_modules/genieacs/public/app-ori.css /usr/lib/node_modules/genieacs/public/app.css
    mv /usr/lib/node_modules/genieacs/public/logo-ori.svg /usr/lib/node_modules/genieacs/public/logo.svg
else
    # Replace folder GenieACS
    cp -ru genieacs /usr/lib/node_modules/
    rm -r /usr/lib/node_modules/genieacs/public/app-ori.css /usr/lib/node_modules/genieacs/public/logo-ori.svg

    # Restore Database GenieACS
    mongorestore --db genieacs --drop database
fi

# Keluar satu folder
cd ..

# Hapus Folder
rm -r AutoInstallGenieACS/ MultiTabGenieACS/

# Sukses
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}========== GenieACS UI akses port 3000. : http://$local_ip:3000 ============${NC}"
echo -e "${GREEN}=================== Informasi: Whatsapp 0853-2269-2888 =====================${NC}"
echo -e "${GREEN}============================================================================${NC}"

# Restart Countdown
for ((i = 3; i >= 1; i--)); do
    sleep 1
    echo "Menghitung $i. Tekan ctrl+c untuk membatalkan Restart"
done

reboot
