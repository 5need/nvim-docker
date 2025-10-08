return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {
    server = {
      override = true,
      settings = { -- shortcut for `settings.tailwindCSS`
        includeLanguages = {
          pug = 'jade',
        },
      },
    },
    -- extension = {
    --   patterns = {
    --     pug = { 'class=["\']([^"\']+)["\']' },
    --     jade = { 'class=["\']([^"\']+)["\']' },
    --   },
    -- },
  },
}
