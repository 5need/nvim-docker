vim.pack.add {
  'https://github.com/cbochs/grapple.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
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
}
