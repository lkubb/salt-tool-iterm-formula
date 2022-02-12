# Iterm2 Formula
Sets up and configures iTerm2.

## Usage
Applying `tool-iterm` will make sure iTerm2 terminal emulator is configured as specified.

## Configuration
### Pillar
#### General `tool` architecture
Since installing user environments is not the primary use case for saltstack, the architecture is currently a bit awkward. All `tool` formulas assume running as root. There are three scopes of configuration:
1. per-user `tool`-specific
  > e.g. generally force usage of XDG dirs in `tool` formulas for this user
2. per-user formula-specific
  > e.g. setup this tool with the following configuration values for this user
3. global formula-specific (All formulas will accept `defaults` for `users:username:formula` default values in this scope as well.)
  > e.g. setup system-wide configuration files like this

**3** goes into `tool:formula` (e.g. `tool:git`). Both user scopes (**1**+**2**) are mixed per user in `users`. `users` can be defined in `tool:users` and/or `tool:formula:users`, the latter taking precedence. (**1**) is namespaced directly under `username`, (**2**) is namespaced under `username: {formula: {}}`.

```yaml
tool:
######### user-scope 1+2 #########
  users:                         #
    username:                    #
      xdg: true                  #
      dotconfig: true            #
      formula:                   #
        config: value            #
####### user-scope 1+2 end #######
  formula:
    formulaspecificstuff:
      conf: val
    defaults:
      yetanotherconfig: somevalue
######### user-scope 1+2 #########
    users:                       #
      username:                  #
        xdg: false               #
        formula:                 #
          otherconfig: otherval  #
####### user-scope 1+2 end #######
```

#### User-specific
The following shows an example of `tool-iterm` pillar configuration. Namespace it to `tool:users` and/or `tool:iterm:users`.
```yaml
user:
  xdg: true               # force xdg dirs
  # sync this user's config from a dotfiles repo available as
  # salt://dotconfig/<user>/iterm or salt://dotconfig/iterm
  dotconfig:              # can be bool or mapping
    file_mode: '0600'     # default: keep destination or salt umask (new)
    dir_mode: '0700'      # default: 0700
    clean: false          # delete files in target. default: false
  iterm:
    profiles:
    # make the following profiles available as dynamic profiles
      - Name: ChildDynamic
        Guid: DF0FB47A-53AB-423B-966D-B05335BB6459
        Dynamic Profile Parent Name: DefaultDynamic
        Scrollback Lines: 6000
        Mouse Reporting: true
```

#### Formula-specific
```yaml
tool:
  iterm:
    defaults:
      profiles:
        - Name: DefaultDynamic
          # it is recommended to specify a static Guid (run `uuidgen`), but this formula automatically generates one in case you did not
          Guid: 9EA96048-7FB6-43D0-A675-AAC0DE3AFC15
          Left Option Key Changeable: true
          Option Key Sends: 2
          Scrollback Lines: 1000
          Terminal Type: xterm-256color
          Visual Bell: true
          Normal Font: FiraCodeNerdFontComplete-Retina 11
```

#### Profiles
This formula can add dynamic profiles to iTerm2. They are handy because they are reloaded dynamically and are in json (text) format, unlike default ones. I use them e.g. to change my terminal theme on the fly automatically (with flavours-managed base16 themes). To generate a static Guid for your profile, you can run `uuidgen`. If you don't specify one, this formula will always generate a new one on every run, which might interfere with normal usage.

### Dotfiles
`tool-iterm.configsync` will recursively apply templates from 

- `salt://dotconfig/<user>/iterm` or
- `salt://dotconfig/iterm`

to the user's config dir for every user that has it enabled (see `user.dotconfig`). The target folder will not be cleaned by default (ie files in the target that are absent from the user's dotconfig will stay).
