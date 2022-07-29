# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}


{%- for user in iterm.users %}

iTerm2 datadir is absent for user '{{ user.name }}':
  file.absent:
    - name: {{ user['_iterm'].datadir }}
{%- endfor %}
