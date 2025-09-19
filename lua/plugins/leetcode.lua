return {
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      injector = {
        ["cpp"] = {
          imports = function(default_imports)
            vim.list_extend(default_imports, {
              "#include <vector>",
              "#include <algorithm>",
              "#include <string>",
              "",
              "using namespace std;",
            })
            return default_imports
          end,
        },
      },
    },
  },
}
