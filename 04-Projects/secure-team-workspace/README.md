# Secure Team Workspace - Linux Admin Lab


You are a Linux System Administrator. You need to set up a secure shared workspace for a Dev Team on Ubuntu.

Team:

Group: devteam
Lead: arjun - can read, write, execute everything
Dev: meera - can read + execute, but cannot edit / delete
Workspace: /opt/devteam-workspace
Outsiders: Should see nothing

Repo Structure: 

secure-team-workspace/
├── README.md
├── setup.sh
├── scripts/
│   ├── create_user.sh
│   ├── backup.sh
│   └── check_permissions.sh
├── docs/
│   └── TIL.md
└── workspace/


How To Run
1. Enter Ubuntu Lab (Check Docker directory in main to setup)
docker start my-ubuntu-lab
docker exec -it my-ubuntu-lab bash
cd /home/secure-team-workspace

2. Run Setup
chmod +x setup.sh
./setup.sh

3. Test As Meera
su - meera
cat /opt/devteam-workspace/shared/notes.txt
bash /opt/devteam-workspace/app/deploy.sh
echo "hack" >> /opt/devteam-workspace/app/deploy.sh

# Last one should fail - Permission denied
Commands Explained
groupadd devteam - Creates group
useradd -m -s /bin/bash arjun - Creates user + home + bash. Without -m, error cannot change directory
echo "arjun:1234" | chpasswd - Lab only password. Real life: passwd or SSH keys
usermod -aG devteam arjun - Add to group. -a = append, don't delete old groups
mkdir -p /opt/devteam-workspace/{app,shared,logs} - Brace expansion creates 3 folders
chown -R arjun:devteam - Change owner recursively, format user:group
chmod 750 = rwx owner, r-x group, --- others. Folder needs x to enter, script needs x to run
chmod 640 = rw- owner, r-- group, --- others. Text file, no x needed
cat = show file, bash = run file. Don't bash notes.txt
userdel deletes name, not files. File stores UID 1000, not name. Ghost UID remains.
Common Errors
mkdir with commas fails. Use {a,b,c} no spaces.
Dockerfile.txt -> must be Dockerfile
chmod -x file user -> wrong, chmod takes only permission + file
./opt/... -> wrong, ./ = current folder, use /opt/...
Fix setup.sh (source), not deploy.sh (output), otherwise setup overwrites fix
