# vim: ft=sls

{#-
    Manages the iTerm2 package configuration by

    * recursively syncing from a dotfiles repo

    Has a dependency on `tool_iterm.package`_.
#}

include:
  - .sync
