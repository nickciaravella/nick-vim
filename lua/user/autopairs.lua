local autoparis_status_ok, autopairs = pcall(require, "nvim-autopairs")
if not autoparis_status_ok then
  return
end

autopairs.setup({
  check_ts = true,          -- ts = treesitter
  ts_config = {
      lua = {'string'},     -- it will not add a pair on that treesitter node
      javascript = {'template_string'},
      java = false,         -- don't check treesitter on java (not sure why..)
  },
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- Enables automatically adding () after function/method completions.
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

