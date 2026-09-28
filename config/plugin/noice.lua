vim.pack.add {
  'https://github.com/rcarriga/nvim-notify',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/folke/noice.nvim',
}

require('notify').setup {
  -- background_colour = '#000000',
  render = 'compact',
  stages = 'static',
  fps = 24,
  top_down = false,
}

require('noice').setup {
  cmdline = {
    view = 'cmdline',
  },
  routes = {
    -- show recording @q or whatever (i do this in lualine now)
    -- {
    --   view = 'notify',
    --   filter = { event = 'msg_showmode' },
    -- },
    {
      filter = { event = 'msg_show', kind = '', find = 'written' },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', kind = '', find = 'more line' },
      opts = { skip = true },
    },
  },
}
