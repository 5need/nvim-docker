local cwd = vim.fn.getcwd()
local folder_name = vim.fn.fnamemodify(cwd, ':t')
local note_path = vim.fn.expand('~/scratch/' .. folder_name .. '.md')

local EDITABLE_WIDTH = 80

vim.pack.add { 'https://github.com/shortcuts/no-neck-pain.nvim' }

require('no-neck-pain').setup {
  width = EDITABLE_WIDTH,
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

local function current_buf_is_side()
  local name = vim.api.nvim_buf_get_name(0)
  return name:match 'no%-neck%-pain%-left$' ~= nil or name:match 'no%-neck%-pain%-right$' ~= nil or name == note_path
end

-- Tracks the last-seen gutter width (number column + signcolumn + foldcolumn)
-- so we only ever nudge the side buffer(s) by *changes* in it, never by its
-- absolute value. No-neck-pain's own `width` option already decides the
-- baseline layout (including its "give the main window the leftover space
-- when the opposite side is disabled" behavior) — we don't want to touch
-- that, only cancel out the pixel-shift the gutter causes when it grows or
-- shrinks (e.g. numberwidth gaining a digit past 999 lines).
local last_textoff = nil

local function sync_width()
  if _G.NoNeckPain == nil or _G.NoNeckPain.state == nil or not _G.NoNeckPain.state.enabled then
    last_textoff = nil
    return
  end

  if current_buf_is_side() then
    return
  end

  local win = vim.api.nvim_get_current_win()
  local textoff = vim.fn.getwininfo(win)[1].textoff

  if last_textoff == nil then
    last_textoff = textoff
    return
  end

  if textoff == last_textoff then
    return
  end

  local delta = last_textoff - textoff
  last_textoff = textoff

  local state = _G.NoNeckPain.state
  local sides = {}
  for _, side in ipairs { 'left', 'right' } do
    local side_ok, id = pcall(function()
      return state:get_side_id(side)
    end)
    if side_ok and id ~= nil and vim.api.nvim_win_is_valid(id) then
      table.insert(sides, id)
    end
  end

  for i, id in ipairs(sides) do
    local share = math.floor(delta / #sides)
    if i == 1 then
      share = delta - share * (#sides - 1)
    end
    local new_width = vim.api.nvim_win_get_width(id) + share
    if new_width > 0 then
      pcall(vim.api.nvim_win_set_width, id, new_width)
    end
  end
end

local gutter_sync_group = vim.api.nvim_create_augroup('NoNeckPainGutterSync', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'VimResized', 'TextChanged', 'TextChangedI', 'InsertLeave' }, {
  group = gutter_sync_group,
  callback = function()
    vim.schedule(sync_width)
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  group = gutter_sync_group,
  pattern = { 'number', 'relativenumber', 'signcolumn', 'foldcolumn', 'numberwidth' },
  callback = function()
    vim.schedule(sync_width)
  end,
})

vim.api.nvim_create_user_command('NoNeckPainWidth', function()
  local win = vim.api.nvim_get_current_win()
  local textoff = vim.fn.getwininfo(win)[1].textoff
  vim.notify(
    string.format(
      'EDITABLE_WIDTH=%d textoff=%d last_textoff=%s win_width=%d usable_text=%d nnp_config_width=%s',
      EDITABLE_WIDTH,
      textoff,
      tostring(last_textoff),
      vim.api.nvim_win_get_width(win),
      vim.api.nvim_win_get_width(win) - textoff,
      tostring(_G.NoNeckPain and _G.NoNeckPain.config and _G.NoNeckPain.config.width)
    )
  )
end, {})

vim.api.nvim_create_user_command('Restart', function()
  require('no-neck-pain').disable()

  -- Wait for NoNeckPain's debounced disable to finish.
  vim.wait(1000, function()
    return not _G.NoNeckPain.state.enabled
  end, 10)

  vim.cmd 'restart'
end, {})
