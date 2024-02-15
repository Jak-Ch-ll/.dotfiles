function gbs --description 'git branch switch'
    git branch | fzf | xargs git switch
end
