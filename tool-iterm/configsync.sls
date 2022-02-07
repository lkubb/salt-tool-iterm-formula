{%- from 'tool-iterm/map.jinja' import iterm -%}

{%- for user in iterm.users | selectattr('dotconfig', 'defined') | selectattr('dotconfig') %}
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
    - file_mode: keep
    - dir_mode: '0700'
    - makedirs: True
{%- endfor %}
