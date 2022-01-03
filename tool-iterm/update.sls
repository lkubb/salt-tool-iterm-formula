{%- from 'tool-iterm/map.jinja' import iterm %}
{%- set dotconfig = iterm.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') -%}
{%- set profiles = iterm.users | selectattr('iterm.profiles', 'defined') -%}

{%- if dotconfig or profiles %}
include:
  {%- if dotconfig %}
  - .configsync
  {%- endif %}
  {%- if profiles %}
  - .profiles
  {%- endif %}
{%- endif %}
