# Day 01 — Linux Commands Cheatsheet

### Git — Version Control Setup
git --version                           # Check if Git is installed
git config --global user.name "Mohit"   # Set your Git username
git config --global user.email "email"  # Set your Git email
git config --list                       # View all Git configs
git clone <url>                         # Download a repo (e.g. linux kernel)
git status                              # Show current repo status

### Navigation — Moving Around
pwd                                     # Show current directory path
ls                                      # List files in current folder
ls -la                                  # List all files including hidden dotfiles
ls -alps                                # List all with size, permissions, type
cd folder-name                          # Go into a folder
cd ..                                   # Go back one level
cd ~                                    # Go to home directory

### Reading Files
cat readme                              # Print file content to terminal
cat .bashrc                             # View bash config (hidden file)
cat .profile                            # View profile config
cat .env                                # View environment variables file

### Tricky Filenames — Most Important for DevOps
cat ./-file                             # Read file starting with dash, ./ forces path
cat -- -file                            # -- means end of options, treat -file as file

cat "my file.log"                       # Quotes group spaces into one filename
cat ./my\ file.log                      # \ escapes space
cat -- "my file.log"                    # Safest for files with spaces

cat -- "--spaces in this filename--"    # Handles both dash + spaces
ls -a                                   # Must use -a to see hidden dotfiles
cat "./...Hiding-From-You"              # Read hidden file with dots in name

### SSH — Remote Login
ssh user@host -p 2220                   # Connect to remote server on port 2220
exit                                    # Leave remote server, back to local
whoami                                  # Show who you are logged in as

### Helpful Daily Commands
man cat                                 # Open manual for any command
clear                                   # Clear terminal screen
history                                 # Show all commands you typed before


# Commands - Day 02

# Git
git --version                                # Check Git version
git clone <url>                              # Clone repo from 【entity-GitHub¦canonical_name=GitHub】
cd devops-daily-journey                      # Enter repo folder
git remote -v                                # Show remote origin
git pull                                     # Fetch and merge changes from Github to local machine

# Navigation
pwd                                          # Current directory path
ls -la                                       # List all including hidden files
ls -alps                                     # List all with size and permissions
cd ..                                        # Go back one level

# Reading Files
cat readme                                   # Read file content
cat ./-file                                  # Read file starting with dash
cat -- -file                                 # -- ends options, then filename
cat "my file.log"                            # Quotes handle spaces
cat "./--spaces in this filename--"         # Handles dash + spaces
cat "./...Hiding-From-You"                   # Read hidden dotfile
ls -a                                        # Show hidden files

# Finding File Types
find . -type f                               # Find all files recursively
find . -type f | xargs file                  # Show what type each file is
find . -type f -print0 | xargs -0 file       # Safe version for filenames with spaces

# SSH & System
ssh user@host -p 2220                        # Connect to remote server
exit                                         # Leave remote/server
whoami                                       # Current logged in user
clear                                        # Clear screen
history                                      # Previous commands
cat --help                                   # Help when man doesn't work



# Commands - Day 03

mkdir                                        # Make new directory(folder)
mkdir -p test/test-{1,2,3}                   # Make sub directories, This will make subfolder within test directory
-p in mkdir				     # It means parent directory, it will create parent directory and if it already exist, it will run the rest of the command and give no error.

rmdir                                        # Remove directory (only deletes empty directories)
rm                                           # remove files or directories
rm -rf                                       # deletes directories with sub directories (must use with care)
mv                                           # move and rename files
cp                                           # copy files
head                                         # Displays top 10 lines in a file
head -n 20 app.log                           # this will display top 20 lines of app.log file


Day 04 : Check 02-Shell-scripting


# Commands - Day 04

Linux Permissions (rwx & chmod)

Today I learned how Linux permissions actually work — from your screenshot.

## The Basics from Image

R - Read - 4
W - Write - 2
X - Execute - 1

## How it adds up

User | Group | Others
-----|-------|-------
rw-  | r--   | r-- 
6    | 4     | 4     = 644 (File)

d rwx | r-x | r-x
  7   | 5   | 5     = 755 (Directory)
  ^
  d = Directory

### Math:
- r = 4, w = 2, x = 1
- rw- = 4+2+0 = 6
- r-- = 4+0+0 = 4
- rwx = 4+2+1 = 7
- r-x = 4+0+1 = 5

## File vs Directory

644 file:
- User: rw- (6) = can read and write
- Group: r-- (4) = can only read
- Others: r-- (4) = can only read

755 directory:
- d = it's a directory, not a file
- User: rwx (7) = read, write, execute (enter the folder)
- Group: r-x (5) = read and execute
- Others: r-x (5) = read and execute

## Commands I practiced today

ls -l                          # See permissions: -rw-r--r-- or drwxr-xr-x
chmod 644 file.txt             # Set file to rw-r--r--
chmod 755 script.sh            # Set script/folder to rwxr-xr-x (needed to execute)
chmod +x script.sh             # Add execute permission
chmod -x script.sh             # Remove execute
chown user:group file          # Change owner


# TIL — Day 06: User Creation, Permissions & SUDO

## What I Learned Today

### 1. adduser vs useradd — The Mistake I Made

❌ add user mohit          # Wrong — space breaks it, "add: command not found"
❌ useradd mohit           # Creates user but NO password, sudo fails later
✅ adduser mohit           # Correct — one word, asks for password automatically

### 2. Real Creation (from my lab)

root@1b57:~# adduser mohit
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for mohit
Full Name []: Mohit Sharma
Room Number []: 1

This creates:
- User: mohit
- Group: mohit (gid 1001)
- Home: /home/mohit/
- Password: set during creation

### 3. Check User

id mohit
# uid=1001(mohit) gid=1001(mohit) groups=1001(mohit)

cat /etc/passwd | grep mohit
ls /home/

### 4. Give SUDO Power

usermod -aG sudo mohit
# -aG = add to Group
# sudo group members can use sudo

id suravi
# Should show: groups=...27(sudo)

# Switch and test
su - mohit
sudo whoami
# Asks for password, returns root

### 5. Permissions Link (from Day 02)

From yesterday's screenshot:
R=4, W=2, X=1
File 644 = rw-r--r--
Dir  755 = rwxr-xr-x

chmod 644 file
chmod 755 script.sh
chmod +x script.sh
chown mohit:devops file

### 6. umask (default filter)

umask 022 = files 644, dirs 755
umask 077 = files 600, dirs 700 (most private)

### 7. Password Reset (when sudo fails)

If you see:
unix_chkpwd: password check failed for user (mohit)
sudo: Authentication failed

Fix as root:
passwd mohit
# Set new password

### 8. My Lab Setup

I practiced in Docker Ubuntu:
docker run -it --name my-ubuntu-lab ubuntu bash
apt update && apt install -y sudo adduser passwd

