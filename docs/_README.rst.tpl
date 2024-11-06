.. _readme:

iTerm2 Formula
==============

Manages iTerm2 in the user environment.

.. contents:: **Table of Contents**
   :depth: 1

Usage
-----
Applying ``tool_iterm`` will make sure ``iterm`` is configured as specified.

Configuration
-------------

This formula
~~~~~~~~~~~~
The general configuration structure is in line with all other formulae from the `tool` suite, for details see :ref:`toolsuite`. An example pillar is provided, see :ref:`pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in :ref:`map.jinja`.

User-specific
^^^^^^^^^^^^^
The following shows an example of ``tool_iterm`` per-user configuration. If provided by pillar, namespace it to ``tool_global:users`` and/or ``tool_iterm:users``. For the ``parameters`` YAML file variant, it needs to be nested under a ``values`` parent key. The YAML files are expected to be found in

1. ``salt://tool_iterm/parameters/<grain>/<value>.yaml`` or
2. ``salt://tool_global/parameters/<grain>/<value>.yaml``.

.. code-block:: yaml

  user:

      # Sync this user's config from a dotfiles repo.
      # The available paths and their priority can be found in the
      # rendered `config/sync.sls` file (currently, @TODO docs).
      # Overview in descending priority:
      # salt://dotconfig/<minion_id>/<user>/
      # salt://dotconfig/<minion_id>/
      # salt://dotconfig/<os_family>/<user>/
      # salt://dotconfig/<os_family>/
      # salt://dotconfig/default/<user>/
      # salt://dotconfig/default/
    dotconfig:              # can be bool or mapping
      file_mode: '0600'     # default: keep destination or salt umask (new)
      dir_mode: '0700'      # default: 0700
      clean: false          # delete files in target. default: false

      # Persist environment variables used by this formula for this
      # user to this file (will be appended to a file relative to $HOME)
    persistenv: '.config/zsh/zshenv'

      # Add runcom hooks specific to this formula to this file
      # for this user (will be appended to a file relative to $HOME)
    rchook: '.config/zsh/zshrc'

      # This user's configuration for this formula. Will be overridden by
      # user-specific configuration in `tool_iterm:users`.
      # Set this to `false` to disable configuration for this user.
    iterm:
        # Make the following profiles available as dynamic profiles.
      profiles:
            # It is recommended to specify a static Guid (run `uuidgen`),
            # but this formula automatically generates one in case you did not.
        - Guid: 9EA96048-7FB6-43D0-A675-AAC0DE3AFC15
          Left Option Key Changeable: true
          Name: DefaultDynamic
          Normal Font: FiraCodeNerdFontComplete-Retina 11
          Option Key Sends: 2
          Scrollback Lines: 1000
          Terminal Type: xterm-256color
          Visual Bell: true
            # Dynamic profiles can have inheritance.
        - Dynamic Profile Parent Name: DefaultDynamic
          Guid: DF0FB47A-53AB-423B-966D-B05335BB6459
          Mouse Reporting: true
          Name: ChildDynamic
          Scrollback Lines: 6000

Formula-specific
^^^^^^^^^^^^^^^^

.. code-block:: yaml

  tool_iterm:

      # Specify an explicit version (works on most Linux distributions) or
      # keep the packages updated to their latest version on subsequent runs
      # by leaving version empty or setting it to 'latest'
      # (again for Linux, brew does that anyways).
    version: latest

      # Default formula configuration for all users.
    defaults:
      profiles: default value for all users

Profiles
^^^^^^^^
This formula can add dynamic profiles to iTerm2. They are handy because they are reloaded dynamically and are in json (text) format, unlike default ones. I use them e.g. to change my terminal theme on the fly automatically (with flavours-managed base16 themes). To generate a static Guid for your profile, you can run `uuidgen`. If you don't specify one, this formula will always generate a new one on every run, which might interfere with normal usage.

Dotfiles
~~~~~~~~
``tool_iterm.config.sync`` will recursively apply templates from

* ``salt://dotconfig/<minion_id>/<user>/``
* ``salt://dotconfig/<minion_id>/``
* ``salt://dotconfig/<os_family>/<user>/``
* ``salt://dotconfig/<os_family>/``
* ``salt://dotconfig/default/<user>/``
* ``salt://dotconfig/default/``

to the user's config dir for every user that has it enabled (see ``user.dotconfig``). The target folder will not be cleaned by default (ie files in the target that are absent from the user's dotconfig will stay).

The URL list above is in descending priority. This means user-specific configuration from wider scopes will be overridden by more system-specific general configuration.

<INSERT_STATES>

Development
-----------

Contributing to this repo
~~~~~~~~~~~~~~~~~~~~~~~~~

Commit messages
^^^^^^^^^^^^^^^

Commit message formatting is significant.

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``.

.. code-block:: console

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.
