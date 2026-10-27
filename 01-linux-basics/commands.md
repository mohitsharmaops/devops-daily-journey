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
