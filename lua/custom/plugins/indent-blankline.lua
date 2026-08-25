return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '│',
      highlight = nil, -- disables highlighting
    },
    scope = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require('ibl').setup(opts)

    -- optional: ensure no highlight color
    vim.api.nvim_set_hl(0, 'NonText', { fg = 'NONE' })
  end,
}
