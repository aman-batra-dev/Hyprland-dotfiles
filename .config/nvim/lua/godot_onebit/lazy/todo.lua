return{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIX = { icon = " ", color = "error" },
      HACK = { icon = " ", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
      TEMP = { icon = " ", color = "warning", alt = { "TEMPORARY", "WORKAROUND" } },
      OPTIMIZE = { icon = " ", color = "hint", alt = { "OPTIMISE", "PERF" } },
      WARNING = { icon = " ", color = "warning", alt = { "WARN" } },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:]],
    },
    search = {
      pattern = [[\b(KEYWORDS):]],
    },
  },
}

