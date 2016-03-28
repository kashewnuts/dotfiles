@set DOTFILES=%USERPROFILE%\dotfiles

mklink /d %USERPROFILE%\vimfiles %DOTFILES%\files\.vim
mklink /d %USERPROFILE%\.vim %DOTFILES%\files\.vim
mklink %USERPROFILE%\.gitconfig %DOTFILES%\files\.gitconfig
mklink %USERPROFILE%\.gitconfig.os %DOTFILES%\files\.gitconfig.win
mklink %USERPROFILE%\.gitignore %DOTFILES%\files\.gitignore
mklink %USERPROFILE%\.hgrc %DOTFILES%\files\.hgrc_win
mklink %USERPROFILE%\.gitignore %DOTFILES%\files\.gitignore
mklink %USERPROFILE%\.pythonstartup %DOTFILES%\files\.pythonstartup

@pause
