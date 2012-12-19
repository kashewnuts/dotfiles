右クリックでvimで編集
-------------------------

regeditを起動

"HKEY_CLASSES_ROOT\*\shell"で、新規キーの作成。
名前を"Vimで編集"に変更。

"HKEY_CLASSES_ROOT\*\shell\Vimで編集"にて、新規キーの作成。
名前を"Command"に変更。

"HKEY_CLASSES_ROOT\*\shell\Vimで編集\Command"にて、"(規定)"を修正。
値のデータに
"C:\Program Files\vim73-kaoriya-win32\gvim.exe" "%1"
を入力。


