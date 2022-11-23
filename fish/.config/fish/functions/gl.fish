function gl --wraps='git lg' --description 'alias gl git log (pretty)'
  git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit $argv; 
end
