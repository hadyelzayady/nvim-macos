local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    debug = true,
    -- sources = {
    -- 	formatting.eslint,
    -- .with({
    -- extra_filetypes = { "toml", "solidity" },
    -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    -- }),
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    -- formatting.google_java_format,
    -- },

    -- 	on_attach = function(client, bufnr)
    -- 		if client.supports_method("textDocument/formatting") then
    -- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- 			vim.api.nvim_create_autocmd("BufWritePre", {
    -- 				group = augroup,
    -- 				buffer = bufnr,
    -- 				callback = lsp_formatting(bufnr),
    -- 			})
    -- 		end
    -- 	end,
})
