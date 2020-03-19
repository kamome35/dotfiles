# Load the shell dotfiles, and then some:
for file in ~/.{path,bash_prompt,aliases}; do
	[ -s "$file" ] && \. "$file";
done;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for many Bash commands
[ -s "/etc/bash_completion" ] && \. /etc/bash_completion;
