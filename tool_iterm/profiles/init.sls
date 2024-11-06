# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}

include:
  - {{ sls_package_install }}


{%- for user in iterm.users | selectattr("iterm.profiles", "defined") %}
{%-   for profile in user.iterm.profiles %}

iTerm2 dynamic profile {{ profile.Name }} is synced for user '{{ user.name }}':
  file.serialize:
    - name: {{ user._iterm.datadir | path_join("DynamicProfiles", profile.Name ~ ".json") }}
    - dataset: {{ {"Profiles": [profile]} | json }}
    - serializer: json
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0600'
    - dir_mode: '0700'
    - makedirs: true
    - require:
      - iTerm2 is installed
{%-   endfor %}
{%- endfor %}
