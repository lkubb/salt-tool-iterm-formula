# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}


{%- for user in iterm.users | selectattr('iterm.profiles', 'defined') %}
{%-   for profile in user.iterm.profiles %}

iTerm2 dynamic profile {{ profile.Name }} is absent for user '{{ user.name }}':
  file.absent:
    - name: {{ user._iterm.datadir | path_join('DynamicProfiles', profile.Name ~ '.json') }}
{%-   endfor %}
{%- endfor %}
