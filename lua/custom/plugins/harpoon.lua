return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    vim.keymap.set('n', '<leader>h', function() end, { desc = '[H]arpoon' })

    vim.keymap.set('n', '<leader>hy', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon window' })

    vim.keymap.set('n', '<leader>hh', function()
      harpoon:list():add()
    end, { desc = 'Add Harpoon File' })

    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():remove()
    end, { desc = 'Remove Harpoon File' })

    vim.keymap.set('n', '<leader>j', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon File 1' })

    vim.keymap.set('n', '<leader>k', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon File 2' })

    vim.keymap.set('n', '<leader>l', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon File 3' })

    vim.keymap.set('n', '<leader>;', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon File 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hk', function()
      harpoon:list():prev()
    end, { desc = 'Previous Harpoon File' })

    vim.keymap.set('n', '<leader>hj', function()
      harpoon:list():next()
    end, { desc = 'Next Harpoon File' })
  end,
}
