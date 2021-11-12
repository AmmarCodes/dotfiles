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
    use 'drewtempelmeyer/palenight.vim'
    use 'arcticicestudio/nord-vim'
    use 'marko-cerovac/material.nvim'

    -- text manipulation

    use 'tpope/vim-abolish'
    use 'AndrewRadev/tagalong.vim' -- Change closing tag automatically
    use 'alvan/vim-closetag'
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
            options = {theme = 'palenight'},
            sections = {lualine_a = {
                'mode',
                'diff',
                {
                    'diagnostics',
                    sources = {'ale', 'coc'},
                    sections = {'error', 'warn', 'info', 'hint'},
                }
            }, lualine_x = {'filetype'}}
        } end
    }


    -- mix
    use 'christoomey/vim-tmux-navigator'
    -- use { 'Shougo/defx.nvim', run = ':UpdateRemotePlugins' }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }
    -- use 'itchyny/lightline.vim'
    -- use 'maximbaz/lightline-ale'

    use 'kyazdani42/nvim-web-devicons'
    use 'akinsho/bufferline.nvim'
    use 'qpkorr/vim-bufkill'
    use 'farmergreg/vim-lastplace' -- reopen files at your last edit position
    use 'mhinz/vim-signify'
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
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-endwise'
    use 'tpope/vim-sleuth' -- set indentation
    use 'tpope/vim-markdown'
    use {'andymass/vim-matchup', event = 'VimEnter'}
    use {'neoclide/coc.nvim', branch = 'release'}

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
    use { 'iamcco/markdown-preview.nvim', ft = {'markdown'}, cmd = 'MarkdownPreview' }
    use 'jparise/vim-graphql'

    use 'tpope/vim-fugitive'
    use 'shumphrey/fugitive-gitlab.vim'

    use 'phaazon/hop.nvim'
    use 'dhruvasagar/vim-table-mode'

    use 'norcalli/nvim-colorizer.lua'

    -- consider deleting
    use 'dyng/ctrlsf.vim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
