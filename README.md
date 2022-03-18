# arch-repo
## How to Use:
1. Tell pacman about this repo by adding the following lines to `/etc/pacman.conf`:

`
[mwglen-arch-repo]
SigLevel = Required DatabaseOptional
Server https://github.com/mwglen/arch-repo/$arch
`

2. Update pacman with the new `/etc/pacman.conf` by running `sudo pacman -Syyu`

3. Now you can install packages from this repo using `sudo pacman -S <pkg-name>`
