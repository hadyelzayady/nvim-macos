local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity

local sources = {
    formatting.prettierd,
    code_actions.gitsigns,
}

null_ls.setup({
    debug = true,
    sources = sources,
    -- 	formatting.eslint,
    -- .with({
    -- extra_filetypes = { "toml", "solidity" },
    -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    -- }),
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    -- formatting.google_java_format,
    -- },
})
