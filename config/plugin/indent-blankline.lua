vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {
  scope = {
    show_exact_scope = true,
    show_start = false,
  },
  indent = { char = '┊' },
}
