return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      -- Add C and C++ parsers if not already present
      local required_parsers = { "c", "cpp" }
      for _, parser in ipairs(required_parsers) do
        local has_parser = false
        for _, existing in ipairs(opts.ensure_installed) do
          if existing == parser then
            has_parser = true
            break
          end
        end
        if not has_parser then
          table.insert(opts.ensure_installed, parser)
        end
      end

      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or { "clangd" }
      -- Check and add/override parameters
      local cmd = opts.servers.clangd.cmd
      local params_to_add = {
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--enable-config",
      }

      for _, param in ipairs(params_to_add) do
        local param_name = param:match("^([^=]+)")
        local has_param = false

        -- Check if parameter already exists
        for i, existing in ipairs(cmd) do
          local existing_name = existing:match("^([^=]+)")
          if existing_name == param_name then
            -- If parameter exists, override with new value
            cmd[i] = param
            has_param = true
            break
          end
        end

        -- If parameter doesn't exist, add new parameter
        if not has_param then
          table.insert(cmd, param)
        end
      end
    end,
  },
}
