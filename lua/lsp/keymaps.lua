local M = {}

local whichkey = require "which-key"

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Key mappings
    buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
    keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
    keymap("v", "<leader>lf", "gq", opts)

    -- Whichkey
    local keymap_l = {
        l = {
            name = "Lsp",
            r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
            i = { "<cmd>LspInfo<CR>", "Lsp Info" },
            R = { "<cmd>FzfLua lsp_references<cr>", "References (FzfLua)" },
            L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
            l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
        },
    }
    if client.server_capabilities.documentFormattingProvider
    then
        keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" }
    end

    local keymap_g = {
        name = "Goto",
        d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
        D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
        I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
        r = { "<cmd>Trouble lsp_references<CR>", "Goto References (Trouble)" },
    }
    whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
    whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

function M.setup(client, bufnr)
    keymappings(client, bufnr)
end

return M
