vim.g.mapleader = " "

-- python
vim.g.pymode_folding = 0

-- markdown
vim.g.vim_markdown_fenced_languages = {'js=javascript'}

-- perl
vim.g.perl_include_pod=1
vim.g.perl_no_subprototype_error=1
vim.g.perl_sub_signatures=1
vim.gmojo_highlight_data = 1

vim.g.coq_settings = { auto_start = 'shut-up' }

-- Ale settings
vim.g.ale_linters = { perl = {'perl'}, javascript = {'prettier'},  }
vim.g.ale_lint_delay = 2000
vim.g.ale_sign_warning = '⊙'
vim.g.ale_sign_error = '⊘'
vim.g.ale_yaml_yamllint_options = '-d "{extends: default, rules: {line-length: disable, indentation:' ..
                                  '{ indent-sequences: whatever}}}"'

-- Autosave
vim.g.auto_save = 1 
-- vsplit for cheat
vim.g.cheat_default_window_layout = 'vertical_split'
