return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  opts = {
    vim.cmd([[
      highlight! link NeoTreeRootName Directory
    ]]),
  },
}
