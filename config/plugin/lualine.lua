vim.pack.add {
  'https://github.com/cbochs/grapple.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

vim.pack.add {
  'https://github.com/folke/noice.nvim',
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
        local grapple = require 'grapple'
        local app = grapple.app()
        local opts = vim.tbl_deep_extend('keep', { include_icon = false }, app.settings.statusline)

        local tags, err = grapple.tags()
        if not tags then
          return err
        end

        local current = grapple.find { buffer = 0 }
        local quick_select = app.settings:quick_select()
        local output = {}

        for i = #tags, 1, -1 do
          local tag = tags[i]
          -- stylua: ignore
          local tag_str = tag.name and tag.name
            or quick_select[i] and quick_select[i]
            or i

          local tag_fmt = opts.inactive
          if current and current.path == tag.path then
            tag_fmt = opts.active
          end

          table.insert(output, string.format(tag_fmt, tag_str))
        end

        local statusline = table.concat(output)
        if opts.include_icon then
          statusline = string.format('%s %s', opts.icon, statusline)
        end

        return statusline
      end,
    },
    lualine_c = {
      function()
        return vim.fn.expand '%' == '' and 'Empty' or vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
      end,
    },

    lualine_x = {
      'diff',
      {
        require('noice.api.status').mode.get,
        cond = require('noice.api.status').mode.has,
        color = { bg = '#f9e2af', fg = '#1e1e2e' },
      },
    },
    lualine_y = { { 'filetype', icon_only = false, icon = { align = 'left' } }, 'diagnostics' },
    lualine_z = { 'progress', 'location' },
  },
}
