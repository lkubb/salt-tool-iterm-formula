# vim: ft=sls

{#-
    *Meta-state*.

    Undoes everything performed in the ``tool_iterm`` meta-state
    in reverse order.
#}

include:
  - .config.clean
  - .package.clean
