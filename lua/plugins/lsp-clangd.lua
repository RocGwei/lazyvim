return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or { "clangd" }
      vim.list_extend(opts.servers.clangd.cmd, {
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--enable-config",
      })
    end,
  },
}
