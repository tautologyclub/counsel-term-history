# NOTE

This is deprecated in favor of the more general https://github.com/tautologyclub/counsel-term/

Simple util for making grepping your command history simpler. Make sure to
include this in your .bashrc:
    
    shopt -s histappend
    PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

to force sync your history file after each command.

Note that this currently only works in term-mode and its derivatives (anything
that offers term-send-raw-string).

Worth pointing out that this is just a trivial extension of the excellent Ivy
API. All credit should go to abo-abo -- please support the guy on Patreon if
you're not poor!
