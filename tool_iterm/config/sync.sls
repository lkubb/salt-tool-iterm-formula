# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as iterm with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch %}


{%- for user in iterm.users | selectattr("dotconfig", "defined") | selectattr("dotconfig") %}
{%-   set dotconfig = user.dotconfig if user.dotconfig is mapping else {} %}

iTerm2 dynamic profile configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user["_iterm"].datadir | path_join("DynamicProfiles") }}
    - source: {{ files_switch(
                ["iterm2"],
                default_files_switch=["id", "os_family"],
                override_root="dotconfig",
                opt_prefixes=[user.name]) }}
    - context:
        user: {{ user | json }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
{%-   if dotconfig.get("file_mode") %}
    - file_mode: '{{ dotconfig.file_mode }}'
{%-   endif %}
    - dir_mode: '{{ dotconfig.get("dir_mode", "0700") }}'
    - clean: {{ dotconfig.get('clean', false) | to_bool }}
    - makedirs: true
{%- endfor %}
