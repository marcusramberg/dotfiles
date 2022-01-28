local lsp = require "lspconfig"
local coq = require "coq" -- add this

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Setup servers
lsp.gopls.setup(coq.lsp_ensure_capabilities())
lsp.groovyls.setup(coq.lsp_ensure_capabilities())
lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"lua"},
  settings = {rootMarkers = {".git/"}, languages = {lua = {{formatCommand = "lua-format -i", formatStdin = true}}}}
}
lsp.jsonls.setup(coq.lsp_ensure_capabilities())
lsp.ltex.setup(coq.lsp_ensure_capabilities())
lsp.perlls.setup(coq.lsp_ensure_capabilities())
lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.rls.setup(coq.lsp_ensure_capabilities())
lsp.terraformls.setup(coq.lsp_ensure_capabilities())
lsp.tsserver.setup(coq.lsp_ensure_capabilities())
lsp.yamlls.setup(coq.lsp_ensure_capabilities())
lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'hs'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          ["/Users/marcus/.hammerspoon/Spoons/EmmyLua.spoon/annotations"] = (vim.fn.has("macunix") == 1),
        }
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}))

lsp.yamlls.setup(coq.lsp_ensure_capabilities({

  settings = {schemas = {["kubernetes"] = "~/Source/DNB/AZF-Integration/APIC-*/*/*.yaml"}}

}))
