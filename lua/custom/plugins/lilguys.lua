return {
  'stunwin/lilguys.nvim',
  opts = {
    keybind = '<leader>.', -- toggles a lil guy in at the front of the line. Respects whitespace.
    insert_keybind = '<leader>,', -- adds a lil guy and a space right before your curor
    symbol = '|>', -- want a different lil guy? put him here!
    filetypes = { 'gleam', 'elm', 'elixir' }, -- your lil guy probably only works in certain files. make sure they're here
    auto_insert = true, -- if you use the main keybind on a new, empty line, this will kick you straight into insert mode... or not!
  },
}
