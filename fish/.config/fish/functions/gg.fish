function gg --wraps=git\ log\ --graph\ --simplify-by-decoration\ --pretty=format:\'\%d\'\ --all --description alias\ gg\ git\ log\ --graph\ --simplify-by-decoration\ --pretty=format:\'\%d\'\ --all
  git log --graph --simplify-by-decoration --pretty=format:'%d' --all $argv; 
end
