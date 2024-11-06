# vim: ft=sls

{#-
    Removes the iTerm2 package.
    Has a dependency on `tool_iterm.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}

include:
  - {{ sls_config_clean }}


iTerm2 is removed:
  pkg.removed:
    - name: {{ iterm.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
