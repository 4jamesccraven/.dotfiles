vim.filetype.add({
    filename = {
        ["dot-zshrc"] = "zsh",
    },
    pattern = {
        [".*/dot%-config/git/config"] = "gitconfig",
    },
})
