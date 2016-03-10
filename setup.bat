@set DOTFILES=%USERPROFILE%\dotfiles

mklink %USERPROFILE%\.vimrc %DOTFILES%\.vimrc
mklink %USERPROFILE%\.gvimrc %DOTFILES%\.gvimrc
mklink /d %USERPROFILE%\vimfiles %DOTFILES%\.vim
mklink /d %USERPROFILE%\.vim %DOTFILES%\.vim
mklink %USERPROFILE%\.gitconfig %DOTFILES%\.gitconfig
mklink %USERPROFILE%\.gitconfig.os %DOTFILES%\.gitconfig.win
mklink %USERPROFILE%\.gitignore %DOTFILES%\.gitignore
mklink %USERPROFILE%\.pythonstartup %DOTFILES%\.pythonstartup

@pause
