local lsp = require "lspconfig"
local coq = require "coq" -- add this
lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.gopls.setup(coq.lsp_ensure_capabilities())
lsp.terraformls.setup(coq.lsp_ensure_capabilities())
lsp.tsserver.setup(coq.lsp_ensure_capabilities())
lsp.perlls.setup(coq.lsp_ensure_capabilities())
lsp.ltex.setup(coq.lsp_ensure_capabilities())
lsp.yamlls.setup(coq.lsp_ensure_capabilities())
