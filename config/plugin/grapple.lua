vim.pack.add { 'https://github.com/nvim-lua/plenary.nvim' }
vim.pack.add { 'https://github.com/cbochs/grapple.nvim' }
require('grapple').setup {
  scope = 'git', -- also try out "git_branch"
}
vim.keymap.set('n', '<leader><M-space>', '<cmd>Grapple toggle<cr>', { desc = 'Grapple toggle tag' })
vim.keymap.set('n', '<M-space>', '<cmd>Grapple toggle_tags<cr>', { desc = 'Grapple open tags window' })
vim.keymap.set('n', '<M-r>', '<cmd>Grapple select index=1<cr>', { desc = 'Select first tag' })
vim.keymap.set('n', '<M-e>', '<cmd>Grapple select index=2<cr>', { desc = 'Select second tag' })
vim.keymap.set('n', '<M-w>', '<cmd>Grapple select index=3<cr>', { desc = 'Select third tag' })
vim.keymap.set('n', '<M-q>', '<cmd>Grapple select index=4<cr>', { desc = 'Select fourth tag' })
vim.keymap.set('n', '<M-g>', '<cmd>Grapple cycle_tags next<cr>', { desc = 'Go to next tag' })
vim.keymap.set('n', '<M-ESC>', '<cmd>Grapple cycle_tags prev<cr>', { desc = 'Go to previous tag' })
