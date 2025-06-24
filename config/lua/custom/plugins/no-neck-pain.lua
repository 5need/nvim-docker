return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  config = function()
    local cwd = vim.fn.getcwd()
    local folder_name = vim.fn.fnamemodify(cwd, ':t') -- get the last part of the path
    local note_path = vim.fn.expand('~/scratch/' .. folder_name .. '.md')
    require('no-neck-pain').setup {
      width = 80,
      buffers = {
        right = {
          enabled = false,
        },
        bo = {
          filetype = 'markdown',
        },
        scratchPad = {
          enabled = true,
          pathToFile = note_path,
        },
      },
      autocmds = {
        enableOnVimEnter = true,
      },
    }
  end,
}
