local M = {}
function M.setup()

    local which_key = require "which-key"
    local confs = {
        plugins = {
            -- marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
        ["a"] = { "<cmd>Alpha<cr>", "Start Screen" },
        ["e"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Explorer Find File" },
        ["E"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        ["w"] = { "<cmd>w!<CR>", "Save" },
        ["W"] = { "<cmd>wall!<CR>", "Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" },
        ["c"] = { "<cmd>bdelete<CR>", "Close Buffer" },
        ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
        H = {
            name = 'History',
            h = { "<cmd>LocalHistoryToggle<CR>", "Local History" },
            c = { "<cmd>FzfLua command_history<CR>", "Command History" },
            s = { "<cmd>FzfLua search_history<CR>", "Search History" },
            l = { "<cmd>FzfLua changes<CR>", "Local Change History" },
        },
        g = {
            name = "Git",
            g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>FzfLua git_status<cr>", "Open changed files" },
            b = { "<cmd>FzfLua git_branches<cr>", "Checkout branch" },
            C = { "<cmd>FzfLua git_commits<cr>", "Commit log(project)" },
            c = { "<cmd>FzfLua git_bcommits<cr>", "Commit log(buffer)" },
            S = { "<cmd>FzfLua git_stash<cr>", "stash" },
            d = {
                "<cmd>Gitsigns diffthis HEAD<cr>",
                "Diff",
            },
        },

        -- l = {
        --     name = "LSP",
        --     a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        --     d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics" },
        --     w = {
        --         "<cmd>TroubleToggle workspace_diagnostics<cr>",
        --         "Workspace Diagnostics",
        --     },
        --     f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        --     F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
        --     j = {
        --         "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
        --         "Next Diagnostic",
        --     },
        --     k = {
        --         "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
        --         "Prev Diagnostic",
        --     },
        --     c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        --     o = { "<cmd>SymbolsOutline<cr>", "Outline" },
        --     q = { "<cmd>TroubleToggle loclist<cr>", "Loclist", },
        --     r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        --     R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
        --     s = { "<cmd>FzfLua lsp_document_symbols<cr>", "Document Symbols" },
        --     S = {
        --         "<cmd>FzfLua lsp_workspace_symbols<cr>",
        --         "Workspace Symbols",
        --     },
        --     -- t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
        --     l = {
        --         name = "Trouble List",
        --         x = {
        --             "<cmd>TroubleToggle document_diagnostics<cr>",
        --             "Document Diagnostics",
        --         },
        --         w = {
        --             "<cmd>TroubleToggle workspace_diagnostics<cr>",
        --             "Workspace Diagnostics",
        --         },
        --         r = {
        --             "<cmd>TroubleToggle lsp_references<cr>",
        --             "References",
        --         },
        --         d = {
        --             "<cmd>TroubleToggle lsp_definitions<cr>",
        --             "Definitions",
        --         },
        --         t = {
        --             "<cmd>TroubleToggle lsp_type_definitions<cr>",
        --             "Type Definitions",
        --         },
        --         l = {
        --             "<cmd>TroubleToggle loclist<cr>",
        --             "Loclist",
        --         },
        --     },
        --     -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        -- },
        s = {
            name = "Search",
            f = { "<cmd>FzfLua files<cr>", "Files" },
            r = { "<cmd>lua require'fzf-lua'.oldfiles({ cwd = vim.fn.getcwd() })<cr>", "Open Recent File" },
            b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
            t = { "<cmd>FzfLua live_grep<cr>", "Text" },
            T = { "<cmd>FzfLua live_grep_resume<cr>", "Last Text" },
            l = { "<cmd>FzfLua blines<cr>", "Buffer Lines" },
            L = { "<cmd>FzfLua lines<cr>", "Opened Buffers Lines" },
            h = { "<cmd>FzfLua help_tags<cr>", "Find Help" },
            M = { "<cmd>FzfLua man_pages<cr>", "Man Pages" },
            R = { "<cmd>FzfLua registers<cr>", "Registers" },
            k = { "<cmd>FzfLua keymaps<cr>", "Keymaps" },
            C = { "<cmd>FzfLua commands<cr>", "Commands" },
            c = {
                name = 'Current',
                b = { "<cmd>FzfLua grep_curbuf<cr>", "Buffer" },
                v = { "<cmd>FzfLua grep_visual<cr>", "Visual Selected Text" },
                w = { "<cmd>FzfLua grep_cword<cr>", "Word" },
            },
        },
        j = {
            name = "Jump",
            m = { "<cmd>FzfLua marks<cr>", "Marks" },
            j = { "<cmd>FzfLua jumps<cr>", "Jumps" },
            l = { "<cmd>HopLine<cr>", 'Jump Line' },
            L = { "<cmd>HopLineMW<cr>", 'Jump Line (Visible Buffers)' },
            w = { "<cmd>HopWord<cr>", 'Jump Word' },
            W = { "<cmd>HopWordMW<cr>", 'Jump Word (Visible Buffers)' },
            c = { "<cmd>HopChar1<cr>", 'Jump Char1' },
            C = { "<cmd>HopChar1MW<cr>", 'Jump Char1 (Visible Buffers)' },
        },

        t = {
            name = "Terminal",
            n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
            p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
            f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
            h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
            v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },
        b = {
            name = 'Buffers',
            j = { "<Cmd>BufferLinePick<CR>", "Pick Buffer" },
            c = { "<Cmd>BufferLinePickClose<CR>", "Close Pick Buffer" },
            l = { "<Cmd>BufferLineCloseLeft<CR>", "Close Left" },
            r = { "<Cmd>BufferLineCloseRight<CR>", "Close Right" },
            d = { "<Cmd>bd!<Cr>", "Close current buffer" },
            D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers Except current" },
            a = { "<Cmd>%bd<Cr>", "Close All" },
            p = { "<Cmd>BufferLineTogglePin<CR>", "Pin Buffer" },
        }
    }

    which_key.setup(confs)
    which_key.register(mappings, opts)
end

return M
