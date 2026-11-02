local cwd = vim.fn.getcwd()
local folder_name = vim.fn.fnamemodify(cwd, ':t')
local note_path = vim.fn.expand('~/scratch/' .. folder_name .. '.md')

vim.pack.add { 'https://github.com/shortcuts/no-neck-pain.nvim' }

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

-- change the options of the scratch buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    if vim.fn.expand '%:p' == note_path then
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.cursorline = false
      vim.wo.signcolumn = 'no'
      vim.wo.wrap = true
    end
  end,
})

vim.api.nvim_create_user_command('Restart', function()
  require('no-neck-pain').disable()

  -- Wait for NoNeckPain's debounced disable to finish.
  vim.wait(1000, function()
    return not _G.NoNeckPain.state.enabled
  end, 10)

  vim.cmd 'restart'
end, {})
