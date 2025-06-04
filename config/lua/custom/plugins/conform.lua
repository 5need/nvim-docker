return {
  'stevearc/conform.nvim',
  lazy = false,
  config = function()
    require('conform').setup {

      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'isort', 'black' },
        -- Use a sub-list to run only the first available formatter
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
        templ = { 'tailwind_tools', 'templ' },
        markdown = { 'mdformat' },
        go = { 'gofmt' },

        html = { 'tailwind_tools', 'prettierd' },
        -- pug = { 'prettierd' },
        handlebars = { 'tailwind_tools', 'djlint' },
        rust = { 'rustfmt' },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.

      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,

      -- If this is set, Conform will run the formatter asynchronously after save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      -- format_after_save = {
      --   lsp_fallback = true,
      -- },
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Define custom formatters here
      formatters = {
        tailwind_tools = function()
          ---@type conform.FileFormatterConfig
          return {
            meta = {
              url = '',
              description = '',
            },
            command = function()
              vim.cmd 'TailwindSortSync'
              return ''
            end,
          }
        end,
        -- rustywind_custom = function()
        --   ---@type conform.FileFormatterConfig
        --   return {
        --     meta = {},
        --     command = 'rustywind',
        --     args = { '--output-css-file', vim.fn.getcwd() .. '/static/output.css', '--stdin' },
        --   }
        -- end,
        prettierd = function()
          local util = require 'conform.util'
          ---@type conform.FileFormatterConfig
          return {
            meta = {
              url = 'https://github.com/fsouza/prettierd',
              description = 'prettier, as a daemon, for ludicrous formatting speed.',
            },
            command = 'prettierd',
            args = { '$FILENAME' },
            range_args = function(ctx)
              local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
              return { '$FILENAME', '--range-start=' .. start_offset, '--range-end=' .. end_offset }
            end,
            cwd = util.root_file {
              -- https://prettier.io/docs/en/configuration.html
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.json5',
              '.prettierrc.js',
              '.prettierrc.cjs',
              '.prettierrc.toml',
              'prettier.config.js',
              'prettier.config.cjs',
              'package.json',
            },
          }
        end,
      },
      -- formatters = {
      --   my_formatter = {
      --     -- This can be a string or a function that returns a string
      --     command = "my_cmd",
      --     -- OPTIONAL - all fields below this are optional
      --     -- A list of strings, or a function that returns a list of strings
      --     -- Return a single string instead to run the command in a shell
      --     args = { "--stdin-from-filename", "$FILENAME" },
      --     -- If the formatter supports range formatting, create the range arguments here
      --     range_args = function(ctx)
      --       return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
      --     end,
      --     -- Send file contents to stdin, read new contents from stdout (default true)
      --     -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
      --     -- file is assumed to be modified in-place by the format command.
      --     stdin = true,
      --     -- A function that calculates the directory to run the command in
      --     cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
      --     -- When cwd is not found, don't run the formatter (default false)
      --     require_cwd = true,
      --     -- When returns false, the formatter will not be used
      --     condition = function(ctx)
      --       return vim.fs.basename(ctx.filename) ~= "README.md"
      --     end,
      --     -- Exit codes that indicate success (default {0})
      --     exit_codes = { 0, 1 },
      --     -- Environment variables. This can also be a function that returns a table.
      --     env = {
      --       VAR = "value",
      --     },
      --   },
      --   -- These can also be a function that returns the formatter
      --   other_formatter = function()
      --     return {
      --       command = "my_cmd",
      --     }
      --   end,
      -- },
    }
    vim.api.nvim_create_user_command('ConformDisable', function(args)
      if args.bang then
        -- ConformDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })
    vim.api.nvim_create_user_command('ConformEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
