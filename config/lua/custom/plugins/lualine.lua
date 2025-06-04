return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  -- dependencies = { 'cbochs/grapple.nvim' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'catppuccin',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        function()
          return require('grapple').statusline {
            include_icon = false,
          }
        end,
      },
      lualine_c = {
        function()
          return vim.fn.expand '%' == '' and 'Empty' or vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
        end,
      },

      lualine_x = { 'diff' },
      lualine_y = { { 'filetype', icon_only = false, icon = { align = 'left' } }, 'diagnostics' },
      lualine_z = { 'progress', 'location' },
    },
  },
}
