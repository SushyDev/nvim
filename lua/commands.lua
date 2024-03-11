function Tree()
    vim.cmd("silent Lex %:h")
    -- set width to 15
    vim.cmd("vertical resize 50")

    -- set listing style to tree
    vim.cmd("normal i")
    vim.cmd("normal i")
    vim.cmd("normal i")
end

vim.cmd [[command! -nargs=0 Tree lua Tree()]]
