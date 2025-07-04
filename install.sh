#!/bin/bash

# Install git
apt install git -y

# Clone Git
https://github.com/sulhanqidri/MultiTabGenieACS

# Masuk folder
cd MultiTabGenieACS

# Repelace folder GenieACS
cp -ru genieacs /usr/lib/node_modules/

# Restor Database GenieACS
mongorestore --db genieacs --drop database

#Restart
reboot