-- Ensure packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})

    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
    execute 'PackerSync'
    return
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Plugins
    use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use {'junegunn/fzf.vim'}

    use 'junegunn/vim-easy-align'

    -- colorscheme
    -- use 'drewtempelmeyer/palenight.vim'
    use { 'EdenEast/nightfox.nvim' }
    -- use 'rebelot/kanagawa.nvim'
    -- use 'arcticicestudio/nord-vim'
    -- use 'marko-cerovac/material.nvim'

    -- text manipulation

    use 'tpope/vim-abolish'
    use 'AndrewRadev/tagalong.vim' -- Change closing tag automatically
    use 'windwp/nvim-ts-autotag'
    use 'mg979/vim-visual-multi'

    -- visuals
    use 'lukas-reineke/indent-blankline.nvim'
    use 'machakann/vim-highlightedyank'
    use {
        'lukas-reineke/headlines.nvim',
        config = function() require('headlines').setup() end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('lualine').setup {
            options = {
                theme = 'nightfox',
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' }
},
            sections = {
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        sources = {'ale', 'coc'},
                        sections = {'error', 'warn', 'info', 'hint'},
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1
                    },
                },
                lualine_x = {'filetype'}
            }
        } end
    }


    -- mix
    use 'christoomey/vim-tmux-navigator'
    -- use { 'Shougo/defx.nvim', run = ':UpdateRemotePlugins' }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    -- use 'itchyny/lightline.vim'
    -- use 'maximbaz/lightline-ale'
    use 'junegunn/vim-after-object'
    use 'kyazdani42/nvim-web-devicons'
    use 'akinsho/bufferline.nvim'
    use 'qpkorr/vim-bufkill'
    use 'lewis6991/impatient.nvim'
    use 'farmergreg/vim-lastplace' -- reopen files at your last edit position
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'unblevable/quick-scope'
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'jmckiern/vim-venter'
    -- use 'liuchengxu/vim-which-key'
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use 'Raimondi/delimitMate'
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    use 'tpope/vim-projectionist'
    use 'tpope/vim-surround'
    use 'tpope/vim-endwise'
    use 'tpope/vim-sleuth' -- set indentation
    use 'tpope/vim-markdown'
    use {'andymass/vim-matchup', event = 'VimEnter'}
    use {'neoclide/coc.nvim', branch = 'release', requires = 'honza/vim-snippets'}

    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


    use 'dense-analysis/ale'
    use { 'mattn/emmet-vim', ft = {'html', 'vue'} }
    use 'dkarter/bullets.vim'
    use 'mbbill/undotree'
    use 'ruanyl/vim-gh-line'
    use 'wsdjeg/vim-fetch' -- jump to specified line/column when opening a file
    use 'vim-test/vim-test'
    use 'jebaum/vim-tmuxify'

    use { 'Valloric/MatchTagAlways', ft = {'html', 'xml', 'xhtml', 'vue'} }


    use 'posva/vim-vue'

    use 'kevinoid/vim-jsonc'
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', ft = {'markdown'}, cmd = 'MarkdownPreview' }
    use 'jparise/vim-graphql'

    use 'tpope/vim-fugitive'
    use 'shumphrey/fugitive-gitlab.vim'

    use 'phaazon/hop.nvim'

    use 'norcalli/nvim-colorizer.lua'

    -- consider deleting
    use 'dyng/ctrlsf.vim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
