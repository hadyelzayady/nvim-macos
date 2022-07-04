local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")

if not status_ok then
    return
end

lsp_installer.setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)

    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


local servers = {
    "angularls", "gopls", "tsserver", "eslint", "flow", "bashls", "dockerls", "julials", "pylsp", "pyright",
    "jedi_language_server", "jdtls", "sumneko_lua", "vimls", "html", "jsonls", "solargraph", "cssls",
    "yamlls", "clangd", "ccls", "sqls", "denols", "graphql", "dartls", "dotls",
    "kotlin_language_server", "nimls", "intelephense", "vuels", "phpactor", "omnisharp",
    "r_language_server", "rust_analyzer", "terraformls", "svelte", "texlab", "clojure_lsp", "elixirls",
    "sourcekit", "fsautocomplete", "vls", "hls"
}

local coq = require "coq"

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = require('lsp.handlers').on_attach,
        -- capabilities = require("lsp.handlers").capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }))
end
