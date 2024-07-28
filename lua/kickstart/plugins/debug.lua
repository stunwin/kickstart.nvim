-- debug.lua
--
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'jbyuki/one-small-step-for-vimkind',
    -- 'tomblind/local-lua-debugger-vscode',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'nlua',
        -- 'local-lua',
      },
    }

    -- NOTE: This is the osv lua debugger we're trying

    dap.adapters.nlua = function(callback, config)
      callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    end
    dap.adapters.love2d = {
      type = 'executable',
      command = '/bin/love',
      args = { '--debug' },
    }

    dap.configurations.lua = {

      {
        type = 'love2d',
        request = 'launch',
        name = 'Debug LÖVE',
        program = '${workspaceFolder}/main.lua',
        cwd = '${workspaceFolder}',
      },

      {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
      },
    }

    -- WARN: This is the busted-ass local lua debugger

    -- dap.adapters['local-lua'] = {
    --   type = 'executable',
    --   command = 'node',
    --   args = {
    --     '/home/stunwin/.local/share/nvim/lazy/local-lua-debugger-vscode/extension/debugAdapter.ts',
    --   },
    --   enrich_config = function(config, on_config)
    --     if not config['extensionPath'] then
    --       local c = vim.deepcopy(config)
    --       -- 💀 If this is missing or wrong you'll see
    --       -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
    --       c.extensionPath = '/home/stunwin/.local/share/nvim/lazy/local-lua-debugger-vscode/'
    --       on_config(c)
    --     else
    --       on_config(config)
    --     end
    --   end,
    -- }
    --
    -- dap.configurations.lua = {
    --   {
    --     name = 'Current file (local-lua-dbg, lua)',
    --     type = 'local-lua',
    --     request = 'launch',
    --     cwd = '${workspaceFolder}',
    --     program = {
    --       lua = 'lua5.1',
    --       file = '${file}',
    --     },
    --     args = {},
    --   },
    -- }
    -- Basic debugging keymaps, feel free to change to your liking!

    vim.keymap.set('n', '<leader>dd', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>de', [[:lua require"osv".run_this()<CR>]], { noremap = true, desc = 'Launch nLua S[e]rver' })
    vim.keymap.set('n', '<leader>du', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true, desc = 'dap[U]I Hover' })
    vim.keymap.set('n', '<leader>dj', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dl', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dk', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
