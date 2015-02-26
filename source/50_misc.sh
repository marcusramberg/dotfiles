
# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

export LC_CTYPE=en_US.UTF-8


# re-enable alt-. for last argument
 bindkey '\e.' insert-last-word
 # Allow aliases in sudo.
 alias sudo='sudo '
