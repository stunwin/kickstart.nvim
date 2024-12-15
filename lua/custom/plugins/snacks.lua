return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
}
