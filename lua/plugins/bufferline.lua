return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.highlights = opts.options.highlights or {}
      opts.options.highlights.buffer_selected = opts.options.highlights.buffer_selected or {}
      opts.options.highlights.buffer_selected.italic = false
      return opts
    end,
  },
}
