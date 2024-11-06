Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``tool_iterm``
~~~~~~~~~~~~~~
*Meta-state*.

Performs all operations described in this formula according to the specified configuration.


``tool_iterm.package``
~~~~~~~~~~~~~~~~~~~~~~
Installs the iTerm2 package only.


``tool_iterm.config``
~~~~~~~~~~~~~~~~~~~~~
Manages the iTerm2 package configuration by

* recursively syncing from a dotfiles repo

Has a dependency on `tool_iterm.package`_.


``tool_iterm.profiles``
~~~~~~~~~~~~~~~~~~~~~~~



``tool_iterm.clean``
~~~~~~~~~~~~~~~~~~~~
*Meta-state*.

Undoes everything performed in the ``tool_iterm`` meta-state
in reverse order.


``tool_iterm.package.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes the iTerm2 package.
Has a dependency on `tool_iterm.config.clean`_.


``tool_iterm.config.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Removes the configuration of the iTerm2 package.


``tool_iterm.profiles.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



