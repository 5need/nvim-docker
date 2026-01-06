return {
  'echasnovski/mini.icons',
  init = function()
    -- filetype detection must run before buffers are opened
    vim.filetype.add {
      pattern = {
        ['.*_templ%.go'] = 'templgo',
      },
    }
  end,
  opts = {
    file = {
      ['go.mod'] = { glyph = '󰟓', hl = 'MiniIconsCyan' },
    },
    filetype = {
      templgo = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    },
    extension = {
      templ = { glyph = '', hl = 'MiniIconsAzure' },
    },
    use_file_extension = function(ext, filename)
      -- force fallback to filetype for *_templ.go
      if filename:match '.*_templ%.go$' then
        return false -- ignore the .go extension
      end

      return true -- default behavior for everything else
    end,
  },
}
