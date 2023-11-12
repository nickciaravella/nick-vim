local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

ibl.setup({
    indent = { char = "▏" },
    scope = {
       enabled = true,
       show_start = false,
       show_end = false,
       -- injected_languages = false,
       -- highlight = { "Function", "Label" },
       -- priority = 500,
   }
})

