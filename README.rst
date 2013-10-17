My dotfiles
===========

Common
------

.. code-block:: bash

    git clone https://github.com/kashewnuts/dotfiles

For Windows
-----------

1st.

.. code-block:: bash

    dotfiles/setup.bat


2nd, Add Path to environmental variables.

3rd, Edit registry, as below.

::

  regeditを起動

  "HKEY_CLASSES_ROOT\*\shell"で、新規キーの作成。
  名前を"Edit by Vim"に変更。

  "HKEY_CLASSES_ROOT\*\shell\Vimで編集"にて、新規キーの作成。
  名前を"Command"に変更。

  "HKEY_CLASSES_ROOT\*\shell\Vimで編集\Command"にて、"(規定)"を修正。
  値のデータに以下の値を入力。
  "C:\Program Files\vim\gvim.exe" "%1"


Others
------

Just

.. code-block:: bash

    dotfiles/setup.sh
