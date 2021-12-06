# Dot Files

My OS X / Ubuntu / Debian dotfiles.

## What's this?

The dotfiles of (github.com/marcusramberg)[marcusramberg] - Initially system
was based on (github.com/cowboy/dotfiles)[Cowboy's dotfiles]. They are heavily
changed to use ansible, zsh, and debianish/arch, as well as my config files.

That command is [~/bin/dotfiles][dotfiles], and this is my "dotfiles" Git repo.

[dotfiles]: https://github.com/marcusramberg/dotfiles/blob/master/bin/dotfiles
[bin]: https://github.com/marcusramberg/dotfiles/tree/master/bin

## What, exactly, does the "dotfiles" command do?

It's really not complicated. When you run [dotfiles][dotfiles] , it does the following things:

1. Installs Git if necessary, via APT or Homebrew (also installed if necessary).
2. Clones this repo into the `~/.dotfiles` directory (or updated if it already exists).
3. Executes files in `init` (in alphanumeric order).
4. Copies in `copy` into `~/`.
5. Links files and folders in `link` into `~/`.
5. Sets up prefs as well as vim plugins.

Note:

- The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
- Files in `bin` are executable shell scripts (includes [~/.dotfiles/bin][bin] into the path).
- Files in `source` get sourced whenever you open a new shell (in alphanumeric order)..
- Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
- Files in `caches` are cache files, only used by some scripts. This folder is auto-created.

## Installation

### OS X

Notes:

- You need to be an administrator (for `sudo`).
- You need to have installed [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a separate, optional (and _much smaller_) download from XCode.

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/marcusramberg/dotfiles/master/bin/dotfiles)" && source ~/.zshrc
```

### Ubuntu

Notes:

- You need to be an administrator (for `sudo`).
- If APT wasn't updated or upgraded recently, it will probably take some minutes before you see anything.

```sh
sudo apt-get -qq update && sudo apt-get -qq upgrade && sudo apt-get -qq install curl ansible && echo &&
bash -c "$(curl -fsSL https://raw.githubusercontent.com/marcusramberg/dotfiles/master/bin/dotfiles)" && source ~/.zshrc
```

## The "init" step

These things will be installed, but _only_ if they aren't already.

### OS X

- Homebrew
  - git
  - tree
  - sl
  - lesspipe
  - id3tool
  - nmap
  - git-extras
  - htop-osx
  - apple-gcc42 (via [homebrew-dupes](https://github.com/Homebrew/homebrew-dupes/blob/master/apple-gcc42.rb))

### Ubuntu

- APT
  - build-essential
  - libssl-dev
  - git-core
  - tree
  - sl
  - id3tool
  - nmap
  - telnet
  - htop

### Both

- Nave
  - Npm (latest stable)
    - Grunt
    - JSHint
    - Uglify-JS
- Rbenv
  - Ruby 1.9.3-p194 (default)
  - Ruby 1.9.2-p290 (default)
- Ruby Gems
  - bundler
  - awesome_print
  - interactive_editor
- Perlbrew


## The ~/ "copy" step

Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/marcusramberg/dotfiles/blob/master/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step

Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions

To keep things easy, the `~/.zshrc` file is extremely simple, and should never need to be modified. Instead, add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/marcusramberg/dotfiles/tree/master/source). I even have a [fancy prompt](https://github.com/marcusramberg/dotfiles/blob/master/source/50_prompt.sh) that shows the current directory, time and current git/svn repo status.

## Scripts

In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [scripts][bin]. This includes [ack](https://github.com/petdance/ack), which is a [git submodule](https://github.com/marcusramberg/dotfiles/tree/master/libs).

- [dotfiles][dotfiles] - (re)initialize dotfiles. It might ask for your password (for `sudo`).
- [src](https://github.com/marcusramberg/dotfiles/blob/master/link/.bashrc#L6-15) - (re)source all files in `source` directory
- Look through the [bin][bin] subdirectory for a few more.

Git repos display as **[branch:flags]** where flags are:

**?** untracked files
**!** changed (but unstaged) files
**+** staged files

SVN repos display as **[rev1:rev2]** where rev1 and rev2 are:

**rev1** last changed revision
**rev2** revision

## Inspiration

<https://github.com/gf3/dotfiles>
<https://github.com/mathiasbynens/dotfiles>
(and 15+ years of accumulated crap)

## License

Some parts Copyright (c) 2012 Marcus Ramberg
Copyright (c) 2012 "Cowboy" Ben Alman
Licensed under the MIT license.
<http://benalman.com/about/license/>
