return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },

  opts = {
    workspaces = {
      {
        name = 'archvault',
        path = '~/Obsidian/tempvault/temporary arch vault/',
      },
    },
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ['gf'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ['<leader>ch'] = {
      action = function()
        return require('obsidian').util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ['<cr>'] = {
      action = function()
        return require('obsidian').util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      title = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        title = title .. string.char(math.random(65, 90))
      end
    end
    return tostring(title)
  end,
  preferred_link_style = 'wiki',
}
