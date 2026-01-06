function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

-- file viewer
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == '..'
      end,
    },
    float = {
      padding = 0,
      max_width = 80,
      max_height = 0,
    },
    win_options = {
      number = false,
      relativenumber = false,
      wrap = true,
      winblend = 0,
      winbar = '%!v:lua.get_oil_winbar()',
    },
    view_options = {
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        if entry.name:match '.*_templ%.go$' then
          return 'OilHidden'
        end
        return nil
      end,
    },
    keymaps = {
      ['<leader>e'] = 'actions.close',
      ['<esc>'] = 'actions.close',
      ['<left>'] = 'actions.parent',
      ['<right>'] = 'actions.select',
    },
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons' } },
}
