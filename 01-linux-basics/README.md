TIL — 28 Oct 2026
Today I learned how Linux handles tricky filenames — a real DevOps headache.

Installed Git and cloned linux repo
Created devops-daily-journey repo
3 things that will save you in production:

File starts with - ? Linux thinks it's an option.
cat ./-file or cat -- -file
File has spaces? Quote it.
cat "my file.log" — or just hit TAB
File is hidden? It's a dotfile.
ls -a to see .env, .bashrc, .profile
One-liner: -- ends options, "" groups spaces, ./ forces a path.
