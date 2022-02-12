{%- from 'tool-iterm/map.jinja' import iterm -%}

{%- for user in iterm.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') %}
  {%- set dotconfig = user.dotconfig if dotconfig is mapping else {} %}

iTerm2 dynamic profile configuration is synced for user '{{ user.name }}':
  file.recurse:
    - name: {{ user.home }}/.config/iterm2
    - source:
      - salt://dotconfig/{{ user.name }}/iterm2
      - salt://dotconfig/iterm2
    - context:
        user: {{ user }}
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.group }}
  {%- if dotconfig.get('file_mode') %}
    - file_mode: '{{ dotconfig.file_mode }}'
  {%- endif %}
    - dir_mode: '{{ dotconfig.get('dir_mode', '0700') }}'
    - clean: {{ dotconfig.get('clean', False) | to_bool }}
    - makedirs: True
{%- endfor %}
