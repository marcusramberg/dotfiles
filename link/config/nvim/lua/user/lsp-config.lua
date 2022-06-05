local lsp = require "lspconfig"
local m = require'mapx'.setup{ whichkey = true } --, global= true }

local on_attach_vim = function(client, bufnr)
	require("aerial").on_attach(client, bufnr)
	require("lsp-status").on_attach(client)

	if client.resolved_capabilities.document_formatting then
		m.nnoremap("<leader>cf", function() vim.lsp.buf.formatting() end, "silent", "Format")
	end

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
			augroup LSPDocumentHighlight
					au!
					autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
					autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
					autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
				augroup END
			]])
		end
	end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Setup servers
lsp.gopls.setup{on_attach = on_attach_vim, capabilities = capabilities,
  cmd = {"gopls", "serve"},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			linksInHover = false,
			codelenses = {
				generate = true,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_depdendency = true,
				vendor = true,
			},
			usePlaceholders = true,
		}}}
lsp.groovyls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.efm.setup {on_attach = on_attach_vim, capabilities = capabilities,
  init_options = {documentFormatting = true},
  filetypes = {"lua"},
  settings = {rootMarkers = {".git/", "init.lua"}, languages = {lua = {{formatCommand = "lua-format -i", formatStdin = true}}}}
}
lsp.jedi_language_server.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.jsonls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.perlls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.pylsp.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.rls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.terraformls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.tflint.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.tsserver.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.yamlls.setup{on_attach = on_attach_vim, capabilities = capabilities}
lsp.sumneko_lua.setup({on_attach = on_attach_vim, capabilities = capabilities, settings = {
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
    },
  },
	root_dir = function(fname)
		local root_pattern = lsp.util.root_pattern('.git', '*.rockspec')(fname)

		if fname == vim.loop.os_homedir() then return nil end
		return root_pattern or fname
	end
})

lsp.yamlls.setup{on_attach = on_attach_vim, capabilities = capabilities,
  settings = {schemas = {["kubernetes"] = "~/Source/DNB/AZF-Integration/APIC-*/*/*.yaml"}}}
