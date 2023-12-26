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
  -- Add git related info in the signs columns and popups
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter'
  },
  -- lsp-zero
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {
    -- autopairs
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  {
     -- Adds extra functionality over rust analyzer
    'simrat39/rust-tools.nvim'
  },
  -- {
  --   -- Typescript
  --   'jose-elias-alvarez/typescript.nvim'
  -- },
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
