
-- Sync terminal background with Neovim background
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if normal.bg then
      io.write(string.format('\027]11;#%06x\027\\', normal.bg))
      io.flush()
    end
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  callback = function()
    io.write('\027]111\027\\')
    io.flush()
  end,
})
