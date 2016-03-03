@set DOTFILES=%USERPROFILE%\dotfiles

mklink %USERPROFILE%\.vimrc %DOTFILES%\.vim\.vimrc
mklink %USERPROFILE%\.gvimrc %DOTFILES%\.vim\.gvimrc
mklink /d %USERPROFILE%\vimfiles %DOTFILES%\.vim
mklink /d %USERPROFILE%\.vim %DOTFILES%\.vim
mklink %USERPROFILE%\.gitconfig %DOTFILES%\.config\.gitconfig
mklink %USERPROFILE%\.gitconfig.os %DOTFILES%\.config\.gitconfig.win
mklink %USERPROFILE%\.gitignore %DOTFILES%\.config\.gitignore
mklink %USERPROFILE%\.hgrc %DOTFILES%\.config\.hgrc_win
mklink %USERPROFILE%\.hgignore %DOTFILES%\.config\.hgignore
mklink %USERPROFILE%\.pythonstartup %DOTFILES%\.config\.pythonstartup

@pause
