-- LSP servers that should use system binaries: server_name -> executable name
local LSPS = {
  clangd = "clangd",
  lua_ls = "lua-language-server",
  rust_analyzer = "rust-analyzer",
  gopls = "gopls",
}

-- Common non-LSP tools recommended to be installed by Mason
local TOOLS = {
  -- Bash
  "shellcheck",
  "shfmt",
  -- C/C++
  "clang-format",
  -- Lua
  "stylua",
  -- Rust
  "rustfmt",
  -- Go
  -- "golangci-lint",
  -- "staticcheck",
  -- "delve",
  -- "gofumpt",
  -- "golines",
  -- "gomodifytags",
  -- "gotests",
  -- "iferr",
  -- "impl",
}

-- Check whether an executable exists on the system PATH
local function system_has_binary(binary_name)
  local path = vim.fn.exepath(binary_name)
  return type(path) == "string" and path ~= ""
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      for server, binary in pairs(LSPS) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].mason = false
        opts.servers[server].cmd = { vim.fn.exepath(binary) }
      end

      return opts
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local installed = opts.ensure_installed or {}
      -- Merge tool list first, then filter with a system-first strategy
      for _, tool in ipairs(TOOLS) do
        if not vim.tbl_contains(installed, tool) then
          table.insert(installed, tool)
        end
      end
      local filtered = {}
      -- Dynamic exclusion rules:
      -- 1) If it's an LSP binary and exists on the system, exclude (use system one)
      -- 2) If it's a regular tool and exists on the system, exclude as well
      for _, name in ipairs(installed) do
        local should_exclude = false
        -- LSP binaries: exclude when system executable is available
        for _, binary in pairs(LSPS) do
          if name == binary and system_has_binary(binary) then
            should_exclude = true
            break
          end
        end
        -- Tools: exclude when a same-named system executable exists
        if not should_exclude and system_has_binary(name) then
          should_exclude = true
        end

        if not should_exclude then
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
      -- Dynamic exclusion: if the server's binary exists on system, don't let Mason install it
      for _, name in ipairs(servers) do
        local binary = LSPS[name]
        local should_exclude = false
        if binary and system_has_binary(binary) then
          should_exclude = true
        end
        if not should_exclude then
          table.insert(filtered, name)
        end
      end
      opts.ensure_installed = filtered
      return opts
    end,
  },
}
