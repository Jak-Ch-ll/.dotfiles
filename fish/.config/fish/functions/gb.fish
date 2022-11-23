function gb --wraps='git br' --description 'alias gb git branch (pretty)'
  git branch --format='%(HEAD) %(refname:short) %(color:green)(%(committerdate:relative)) %(color:blue)[%(authorname)]' --sort=-committerdate $argv; 
end
