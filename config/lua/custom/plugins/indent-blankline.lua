return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  main = 'ibl',

  opts = {
    scope = {
      show_exact_scope = true,
      show_start = false,
    },
    indent = { char = '┊' },
  },
}
