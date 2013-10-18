@set DOTFILES=%USERPROFILE%\dotfiles\files

mklink %USERPROFILE%\.vimrc %DOTFILES%\.vimrc
mklink %USERPROFILE%\.gvimrc %DOTFILES%\.gvimrc
mklink /d %USERPROFILE%\vimfiles %DOTFILES%\.vim
mklink /d %USERPROFILE%\.vim %DOTFILES%\.vim
mklink /h %USERPROFILE%\.gitconfig %DOTFILES%\.gitconfig_win
mklink %USERPROFILE%\.gitignore %DOTFILES%\.gitignore
mklink %USERPROFILE%\.hgrc %DOTFILES%\.hgrc_win
mklink %USERPROFILE%\.hgignore %DOTFILES%\.hgignore
mklink %USERPROFILE%\.pythonstartup %DOTFILES%\.pythonstartup

@pause
