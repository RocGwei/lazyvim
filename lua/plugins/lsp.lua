return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { vim.fn.exepath("clangd") },
          mason = false,
        },
        lua_ls = {
          cmd = { vim.fn.exepath("lua-language-server") },
          mason = false,
        },
        rust_analyzer = {
          cmd = { vim.fn.exepath("rust-analyzer") },
          mason = false,
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local installed = opts.ensure_installed or {}
      local filtered = {}
      for _, name in ipairs(installed) do
        if
          name ~= "lua-language-server"
          and name ~= "stylua"
          and name ~= "clangd"
          and name ~= "clang-format"
          and name ~= "rust-analyzer"
          and name ~= "rustfmt"
          and name ~= "shfmt"
          and name ~= "shellcheck"
        then
          table.insert(filtered, name)
        end
      end
      opts.ensure_installed = filtered
      return opts
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      local servers = opts.ensure_installed or {}
      local filtered = {}
      for _, name in ipairs(servers) do
        if name ~= "lua_ls" and name ~= "clangd" and name ~= "rust_analyzer" then
          table.insert(filtered, name)
        end
      end
      opts.ensure_installed = filtered
      return opts
    end,
  },
}
