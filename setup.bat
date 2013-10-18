@set DOTDIR=%USERPROFILE%\dotfiles\files

mklink %USERPROFILE%\.vimrc %DOTDIR%\.vimrc
mklink %USERPROFILE%\.gvimrc %DOTDIR%\.gvimrc
mklink /d %USERPROFILE%\vimfiles %DOTDIR%\.vim
mklink /d %USERPROFILE%\.vim %DOTDIR%\.vim
mklink /h %USERPROFILE%\.gitconfig %DOTDIR%\.gitconfig_win
mklink %USERPROFILE%\.gitignore %DOTDIR%\.gitignore
mklink %USERPROFILE%\.hgrc %DOTDIR%\.hgrc_win
mklink %USERPROFILE%\.hgignore %DOTDIR%\.hgignore
mklink %USERPROFILE%\.pythonstartup %DOTDIR%\.pythonstartup

@pause
