{%- from 'tool-iterm/map.jinja' import iterm -%}

include:
  - .package
{%- if iterm.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') %}
  - .configsync
{%- endif %}
{%- if iterm.users | selectattr('iterm.profiles', 'defined') %}
  - .profiles
{%- endif %}
