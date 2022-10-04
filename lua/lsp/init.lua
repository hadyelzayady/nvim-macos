local M = {}

local servers = {
    gopls = {},
    html = {},
    jsonls = {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        }
    },
    pyright = {},
    rust_analyzer = {},
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
                    -- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    },
                    -- library = vim.api.nvim_get_runtime_file("", true),
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
                completion = { callSnippet = "Both" },
                telemetry = { enable = false },
                hint = {
                    enable = true,
                },
            },
        }, },
    tsserver = {},
    vimls = {},
    yamlls = {
        schemastore = {
            enable = true,
        },
        settings = {
            yaml = {
                hover = true,
                completion = true,
                validate = true,
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    jdtls = {
        vmargs = {
            "-XX:+UseParallelGC",
            "-XX:GCTimeRatio=4",
            "-XX:AdaptiveSizePolicyWeight=90",
            "-Dsun.zip.disableMemoryMapping=true",
            "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
            "-Xmx1G",
            "-Xms100m",
        },
        use_lombok_agent = true
    },
}

local status_ok, lsp_signature = pcall(require, "lsp_signature")
if status_ok then
    lsp_signature.setup {
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    }
end

local function on_attach(client, bufnr)
    -- Enable completion triggered by <C-X><C-O>
    -- See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Use LSP as the handler for formatexpr.
    -- See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Configure key mappings
    require("lsp.keymaps").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

M.capabilities = require("coq").lsp_ensure_capabilities(capabilities) -- for nvim-cmp

local opts = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = M.capabilities

}

function M.setup()
    require("lsp.installer").setup(servers, opts)
end

return M
