return {
  {
    -- Color scheme
    'chriskempson/base16-vim',
  },
  {
    -- Git commands in nvim
    'tpope/vim-fugitive'
  },
  {
    -- 'gc' to comment visual regions/lines
    'numToStr/Comment.nvim'
  },
  {
    -- UI to select things (files, grep results, open buffers...)
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    -- Fancier statusline
    'nvim-lualine/lualine.nvim'
  },
  {
    -- bufferline tabs
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
  -- nvim tree
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
  -- Add git related info in the signs columns and popups
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter'
  },
  {
    -- Additional textobjects for treesitter
    'nvim-treesitter/nvim-treesitter-textobjects'
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    -- Autocompletion framework
    'hrsh7th/nvim-cmp'
  },
  {
    -- cmp LSP completion
    'hrsh7th/cmp-nvim-lsp'
  },
  {
    -- cmp Snippet completion
    'hrsh7th/cmp-vsnip'
  },
  {
    -- cmp Path completion
    'hrsh7th/cmp-path'
  },
  {
    'hrsh7th/cmp-buffer'
  },
  {
    -- autopairs
    'windwp/nvim-autopairs'
  },
  {
     -- Adds extra functionality over rust analyzer
    'simrat39/rust-tools.nvim'
  },
  {
    -- Typescript
    'jose-elias-alvarez/typescript.nvim'
  },
  {
    -- Snippet engine
    'hrsh7th/vim-vsnip'
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {}
  },
  {
    "robitx/gp.nvim",
  }
}
