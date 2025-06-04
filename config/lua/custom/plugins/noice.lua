return {
  'folke/noice.nvim',
  opts = {
    -- add any options here
  },
  config = function()
    local noice = require 'noice'
    noice.setup {
      cmdline = {
        view = 'cmdline',
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
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
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup {
          -- background_colour = '#000000',
          render = 'compact',
          stages = 'static',
          fps = 24,
          top_down = false,
        }
      end,
    },
  },
}
