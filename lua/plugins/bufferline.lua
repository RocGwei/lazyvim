return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.highlights = opts.highlights or {}

      -- Disable italics for the selected buffer
      opts.highlights.buffer_selected = opts.highlights.buffer_selected or {}
      opts.highlights.buffer_selected.italic = false

      return opts
    end,
  },
}
