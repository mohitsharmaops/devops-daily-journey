#!/bin/bash

# Create a group

groupadd devteam

# create Users

useradd -m -s /bin/bash arjun
useradd -m -s /bin/bash meera

# Passwords

echo "arjun:1234" | chpasswd
echo "meera:1234" | chpasswd

# Add users to group

usermod -aG devteam arjun
usermod -aG devteam meera

#Workspace

mkdir -p /opt/devteam-workspace/{app,shared,logs}
echo 'echo "Deploying..."' > /opt/devteam-workspace/app/deploy.sh
echo "Teams notes" > /opt/devteam-workspace/shared/notes.txt

# Permissions 

chown -R arjun:devteam /opt/devteam-workspace
chmod 750 /opt/devteam-workspace
chmod 750 /opt/devteam-workspace/app/deploy.sh
chmod 640 /opt/devteam-workspace/shared/notes.txt

