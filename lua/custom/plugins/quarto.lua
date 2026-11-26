-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {},
    config = function(_, opts)
      require("quarto").setup(opts)

      vim.keymap.set("n", "<leader>qp", "<cmd>QuartoPreview<cr>",
        { desc = "Quarto Preview" })
    end,
  },
}
