local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.load_extension('projects')
telescope.load_extension("refactoring")
-- telescope.load_extension('possession')
