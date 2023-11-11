local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

ibl.setup({
    indent = { char = "|" },
    whitespace = { highlight = { "Whitespace", "NonText" } },
    scope = { exclude = { language = {  } } },
})

