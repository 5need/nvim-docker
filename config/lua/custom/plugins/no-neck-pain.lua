return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  config = function()
    require('no-neck-pain').setup {
      width = 80,
      buffers = {
        right = {
          enabled = false,
        },
        bo = {
          filetype = 'md',
        },
      },
      autocmds = {
        enableOnVimEnter = true,
      },
    }
  end,
}
