return {
  'cbochs/grapple.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader><M-space>', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<M-space>', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<M-r>', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
    { '<M-e>', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
    { '<M-w>', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
    { '<M-q>', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
    { '<M-g>', '<cmd>Grapple cycle_tags next<cr>', desc = 'Go to next tag' },
    { '<M-ESC>', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Go to previous tag' },
  },
}
