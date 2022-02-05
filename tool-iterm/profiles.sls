{%- from 'tool-iterm/map.jinja' import iterm -%}

include:
  - .package

{%- for user in iterm.users | selectattr('iterm.profiles', 'defined') %}
  {%- for profile in user.iterm.profiles %}

iTerm2 dynamic profile {{ profile.Name }} is synced for user '{{ user.name }}':
  file.serialize:
    - name: {{ user.home }}/Library/Application Support/iTerm2/DynamicProfiles/{{ profile.Name }}.json
    - dataset: {{ {'Profiles': [profile]} | json }}
    - serializer: json
    - user: {{ user.name }}
    - group: {{ user.group }}
    - mode: '0600'
    - dir_mode: '0700'
    - makedirs: true
    - require:
      - iTerm2 is installed
  {%- endfor %}
{%- endfor %}
