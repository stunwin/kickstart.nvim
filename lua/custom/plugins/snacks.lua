return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false },

    dashboard = {
      enabled = true,
      preset = {
        header = 'fight me you coward',
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 3 },
        { section = 'recent_files', padding = 3 },
        { section = 'startup' },
      },
    },

    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
}
