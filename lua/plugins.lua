return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }


    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'ms-jpq/coq_nvim', branch = 'coq' } -- autocompletions

    use 'windwp/nvim-autopairs' -- auto close brackets, parentathesis,...
    use 'windwp/nvim-ts-autotag' --  auto close tags

    use {
        'nvim-treesitter/nvim-treesitter',
        'p00f/nvim-ts-rainbow',
        run = ':TSUpdate'
    }

    use 'Mofiqul/dracula.nvim' -- theme

    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' } -- show buffer as tabs with fancy stuff like close icon and number of errors

    use "folke/which-key.nvim"

    use "akinsho/toggleterm.nvim"
    use "nvim-lualine/lualine.nvim" -- statusline
    use 'lewis6991/gitsigns.nvim'
    use { "dinhhuy258/vim-local-history", branch = "master", run = ':UpdateRemotePlugins' }
    use 'lewis6991/impatient.nvim' -- optimize starting vim
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use {
        -- file explorer
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
    -- This is useful when there are embedded languages in certain types of files. For example, Vue files can have many different sections, each of which can have a different style for comments
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'terrortylor/nvim-comment'

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use 'folke/lsp-colors.nvim'
    use {
        "folke/trouble.nvim", --  A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
        requires = "kyazdani42/nvim-web-devicons",
    }

    use "Pocco81/AutoSave.nvim"

    -- Start Screen
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use 'Shatur/neovim-session-manager'

    use 'notjedi/nvim-rooter.lua'
    use "ahmedkhalf/project.nvim"
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use "lukas-reineke/indent-blankline.nvim"
    use 'simrat39/symbols-outline.nvim'
    --  -- Simple plugins can be specified as strings
    --  use '9mm/vim-closer'
    --
    --  -- Lazy loading:
    --  -- Load on specific commands
    --  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    --
    --  -- Load on an autocommand event
    --  use {'andymass/vim-matchup', event = 'VimEnter'}
    --
    --  -- Load on a combination of conditions: specific filetypes or commands
    --  -- Also run code after load (see the "config" key)
    --  use {
    --    'w0rp/ale',
    --    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    --    cmd = 'ALEEnable',
    --    config = 'vim.cmd[[ALEEnable]]'
    --  }
    --
    --  -- Plugins can have dependencies on other plugins
    --  use {
    --    'haorenW1025/completion-nvim',
    --    opt = true,
    --    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
    --  }
    --
    --  -- Plugins can also depend on rocks from luarocks.org:
    --  use {
    --    'my/supercoolplugin',
    --    rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
    --  }
    --
    --  -- You can specify rocks in isolation
    --  use_rocks 'penlight'
    --  use_rocks {'lua-resty-http', 'lpeg'}
    --
    --  -- Local plugins can be included
    --  use '~/projects/personal/hover.nvim'
    --
    --  -- Plugins can have post-install/update hooks
    --  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
    --
    --  -- Post-install/update hook with neovim command
    --  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    --
    --  -- Post-install/update hook with call of vimscript function with argument
    --  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
    --
    --  -- Use specific branch, dependency and run lua file after load
    --  use {
    --    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
    --    requires = {'kyazdani42/nvim-web-devicons'}
    --  }
    --
    --  -- Use dependency and run lua function after load
    --  use {
    --    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    --    config = function() require('gitsigns').setup() end
    --  }
    --
    --  -- You can specify multiple plugins in a single call
    --  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
    --
    --  -- You can alias plugin names
    --  use {'dracula/vim', as = 'dracula'}
    --  use {
    --      "folke/trouble.nvim", --  A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    --      requires = "kyazdani42/nvim-web-devicons",
    --  }
end)
