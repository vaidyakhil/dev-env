## Instructions

- this repository contains scripts and example system config files in order to replicate dev-env across
  machines
- this is supposed to work with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh), so first install that!
- once oh-my-zsh is installed and setup, run the following command:
  > `rm -rf $ZSH/custom/* && cp -a <path-where-repo-is-cloned>/. $ZSH/custom/*`

- verify `$ZSH/custom/` contains this repo! You can remove this clone of this repo and work with `$ZSH/custom/` one

- bootstrap.sh is your guide, run `./bootstrap --help` to setup the dev-env
