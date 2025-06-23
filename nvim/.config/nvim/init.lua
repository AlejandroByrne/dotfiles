-- Deod
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.shiftwidth = 2       -- Size of an indent
vim.opt.tabstop = 2          -- Number of spaces tabs count for

-- Language-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false  -- Use real tabs
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

-- Optional: Show indent guides
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "❯",
  precedes = "❮",
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- Plugin setup (empty for now)
require("lazy").setup({
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },
  -- LSP Zero (Easy LSP setup)
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps({buffer = bufnr})
      end)
      
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'pyright',   -- Python
          'lua_ls',    -- Lua
          'clangd',    -- C/C++
        },
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end
  },
  -- Better completion experience
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'onsails/lspkind.nvim',  -- adds icons
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
          })
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
      })
    end
  },
  -- Auto pairs, autocompleting brackets, quotation marks and such
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,  -- Enable treesitter
        ts_config = {
          lua = {'string'},  -- Don't add pairs in lua strings
          javascript = {'template_string'},  -- Don't add pairs in JS template strings
        }
      })
      
      -- If you want to automatically add `(` after selecting a function in completion
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
    },
  },
  -- Codeium - Free AI autocomplete
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      -- Set your keybindings
      vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  -- Better escape (jk or jj to exit insert mode)
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup({
        mapping = {"jk", "jj"}, -- Press jk or jj fast to escape
        timeout = 200,
        clear_empty_lines = false,
      })
    end
  },
  -- LazyGit - Git UI that makes people's jaws drop
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  -- Harpoon - Quick file switching
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()
      
      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      
      -- Quick switch between files
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
    end,
  },
})

-- C/C++ compile and run
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<F5>", ":!gcc % -o %< && ./%<<CR>", { buffer = true })
  end,
})
-- Basic settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true  -- Show relative numbers
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- 2 spaces for indentation
vim.opt.tabstop = 2           -- 2 spaces for tabs
vim.opt.mouse = "a"           -- Enable mouse

-- Set leader key to space
vim.g.mapleader = " "

-- Save file with leader+w
vim.keymap.set("n", "<leader>w", ":w<CR>")
