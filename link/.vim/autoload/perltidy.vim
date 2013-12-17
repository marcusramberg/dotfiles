" ****************************************************************************
" File:             perltidy.vim
" Author:           Jonas Kramer <jkramer@nex.scrapping.cc>
" Version:          0.1
" Last Modified:    2012-02-08
" Copyright:        Copyright (C) 2012 by Jonas Kramer. Published under the
"                   terms of the Artistic License 2.0.
" ****************************************************************************
" Installation: Copy this script into your plugin folder.
" Usage: Press T in normal or visual mode to process the whole file or the
" selected code respectively with perltidy.
" ****************************************************************************

if exists('g:loadedPerlTidy')
    finish
en

if !exists('g:perlTidyPath')
    let g:perlTidyPath = ''

    " Find perltidy in $PATH.
    for directory in split($PATH, ':')
        let path = directory . '/perltidy'
        if filereadable(path)
            let g:perlTidyPath = path
            break
        en
    endfo
en

if !exists('g:perlTidyOptions')
    let g:perlTidyOptions = ''
en


" Map keys if perltidy was found or print warning.
if g:perlTidyPath != ''
    let command = g:perlTidyPath . " " . g:perlTidyOptions . " -q"

    aug perltidy
        au BufNewFile,BufRead *.p[lm],*.t exe "vmap <buffer> <silent> T !" . command . "<cr>"
        au BufNewFile,BufRead *.p[lm],*.t exe "nmap <buffer> <silent> T :%!" . command . "<cr>"
    aug END
else
    echo "Path to executable (perltidy) not set. Make sure it's in $PATH or set the path (g:perlTidyPath) manually."
en

let g:loadedPerlTidy = 1
