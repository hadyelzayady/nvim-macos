local status_ok, vim_rooter = pcall(require, "nvim-rooter")
if not status_ok then
    return
end

vim_rooter.setup {
    rooter_patterns = { '.git', '.hg', '.svn' },
    trigger_patterns = { '*' },
    manual = false,
}
