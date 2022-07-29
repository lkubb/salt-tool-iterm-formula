# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}


iTerm2 is installed:
  pkg.installed:
    - name: {{ iterm.lookup.pkg.name }}

iTerm2 setup is completed:
  test.nop:
    - name: Hooray, iTerm2 setup has finished.
    - require:
      - pkg: {{ iterm.lookup.pkg.name }}
