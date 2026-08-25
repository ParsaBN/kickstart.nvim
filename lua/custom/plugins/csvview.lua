return {
  'hat0uma/csvview.nvim',
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = {
      --- @type integer
      async_chunksize = 50,
      --- @type CsvView.Options.Parser.Delimiter
      delimiter = {
        ft = {
          csv = ',',
          tsv = '\t',
        },
        fallbacks = {
          ',',
          '\t',
          ';',
          '|',
          ':',
          ' ',
        },
      },
      --- @type string
      quote_char = '"',

      comments = { '#', '//', '--' },

      --- number of lines at the start of file to treat as comments.
      --- @type integer?
      comment_lines = nil,

      --- @type integer
      max_lookahead = 50,
    },
    view = {
      min_column_width = 5,
      spacing = { left = 1, right = 1 },
      display_mode = 'border', -- highlight or border
      header_lnum = true,
      sticky_header = {
        enabled = true,
        -- separator = '-',
      },
    },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { 'if', mode = { 'o', 'x' } },
      textobject_field_outer = { 'af', mode = { 'o', 'x' } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
      jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
      jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
      jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
    },
  },
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle', 'CsvViewInfo' },
  config = function(_, opts)
    require('csvview').setup(opts)

    local column_colours = {
      '#f38ba8',
      '#fab387',
      '#f9e2af',
      '#a6e3a1',
      '#94e2d5',
      '#89b4fa',
      '#cba6f7',
      '#f5c2e7',
      '#bac2de',
    }

    local function set_csv_colours()
      for index, colour in ipairs(column_colours) do
        vim.api.nvim_set_hl(0, 'CsvViewCol' .. (index - 1), {
          fg = colour,
        })
      end
    end

    set_csv_colours()

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('CsvViewColumnColours', { clear = true }),
      callback = set_csv_colours,
    })

    vim.api.nvim_create_autocmd('FileType', {
      -- group = vim.api.nvim_create_augroup('CsvViewAutoEnable', { clear = true }),
      pattern = { 'csv', 'tsv' },
      callback = function()
        require('csvview').enable()
        -- vim.cmd 'CsvViewEnable'
      end,
    })
  end,
}
