-- add git status column to oil
return {
  'refractalize/oil-git-status.nvim',

  dependencies = {
    'stevearc/oil.nvim',
  },

  opts = {
    show_ignored = true,
    symbols = { -- customize the symbols that appear in the git status columns
      index = {
        ['!'] = '',
        ['?'] = '',
        ['A'] = '',
        ['C'] = '',
        ['D'] = '',
        ['M'] = '',
        ['R'] = '',
        ['T'] = '',
        ['U'] = '',
        [' '] = '',
      },
      working_tree = {
        ['!'] = '',
        ['?'] = '',
        ['A'] = '',
        ['C'] = 'C',
        ['D'] = '',
        ['M'] = '',
        ['R'] = '',
        ['T'] = 'T',
        ['U'] = 'U',
        [' '] = ' ',
      },
    },
  },

  config = function(_, opts)
    require('oil-git-status').setup(opts)

    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeUnmodified', { fg = '#7f849c' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeIgnored', { fg = '#a6adc8' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeUntracked', { fg = '#cdd6f4' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeAdded', { fg = '#a6e3a1' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeCopied', { fg = '#7f849c' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeDeleted', { fg = '#f38ba8' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeModified', { fg = '#f9e2af' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeRenamed', { fg = '#f9e2af' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeTypeChanged', { fg = '#7f849c' })
    vim.api.nvim_set_hl(0, 'OilGitStatusWorkingTreeUnmerged', { fg = '#7f849c' })
  end,
}
