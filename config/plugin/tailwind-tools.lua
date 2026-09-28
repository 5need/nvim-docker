vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-telescope/telescope.nvim', -- optional
  'https://github.com/neovim/nvim-lspconfig', -- optional
  'https://github.com/Eingin/tailwind-tools.nvim',
}

require('tailwind-tools').setup {
  server = {
    override = true,
    settings = { -- shortcut for `settings.tailwindCSS`
      includeLanguages = {
        pug = 'jade',
      },
    },
  },
}

-- return {
--   'luckasRanarison/tailwind-tools.nvim',
--   name = 'tailwind-tools',
--   build = ':UpdateRemotePlugins',
--   dependencies = {
--     'nvim-treesitter/nvim-treesitter',
--     'nvim-telescope/telescope.nvim', -- optional
--     'neovim/nvim-lspconfig', -- optional
--   },
--   opts = {
--     server = {
--       override = true,
--       settings = { -- shortcut for `settings.tailwindCSS`
--         includeLanguages = {
--           pug = 'jade',
--         },
--       },
--     },
--     -- extension = {
--     --   patterns = {
--     --     pug = { 'class=["\']([^"\']+)["\']' },
--     --     jade = { 'class=["\']([^"\']+)["\']' },
--     --   },
--     -- },
--   },
-- }
