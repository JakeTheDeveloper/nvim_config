vim.opt.tabstop = 4       -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.number = true           -- Enable absolute line numbers
vim.opt.relativenumber = true   -- Enable relative line numbers

-- Keybinds
vim.api.nvim_set_keymap('n', '<F5>', ':!start cmd /c "run.bat && main.exe"<CR>', { noremap = true })

-- Clear default diagnostic signs
-- vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "" })

vim.g.colorscheme = "mellifluous"

-- Bootstrap Lazy.nvim installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP Config plugin
  --[[
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Setup Clangd LSP
      require('lspconfig').clangd.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      })
    end,
  },
  --]]

  {
    "ramojus/mellifluous.nvim",
    config = function()
      require("mellifluous").setup({
        color_set = "night",
        contrast = "soft",
      })
      vim.cmd("colorscheme mellifluous")
    end,
  },

  -- Autocompletion setup
  --[[
  {
    'hrsh7th/nvim-cmp',  -- Autocompletion plugin
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',  -- LSP completions
      'hrsh7th/cmp-buffer',    -- Buffer completions
      'hrsh7th/cmp-path',      -- Path completions
      'hrsh7th/cmp-cmdline',   -- Command-line completions
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            -- You can use vsnip or any snippet engine
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- LSP completions
          { name = 'buffer' },    -- Buffer completions
        })
      })
    end,
  },
  --]]
})

