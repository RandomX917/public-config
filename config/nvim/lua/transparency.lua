local function set_transparent()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "LineNr",
    "CursorLine",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "VertSplit",
    "WinSeparator",
    "Pmenu",
    "PmenuSel",
    "EndOfBuffer",
    "NotifyBackground",
    "NotifyERRORBody",
    "NotifyWARNBody",
    "NotifyINFOBody",
    "NotifyDEBUGBody",
    "NotifyTRACEBody",
    "NotifyERRORBorder",
    "NotifyWARNBorder",
    "NotifyINFOBorder",
    "NotifyDEBUGBorder",
    "NotifyTRACEBorder",
  }
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeVertSplit", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "none" })
  end
end
set_transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_transparent,
})

