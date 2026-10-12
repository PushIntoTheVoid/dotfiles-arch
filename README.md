![alt text](readme-resources/dotfiles_.png)

### Hello there! :octocat:

Those are my bspwm dotfiles, hope you find something useful here ^^

* The rices configs are [here](https://github.com/zodd18/dotfiles/tree/master/rices) and shared configuration files between all rices are [here](https://github.com/zodd18/dotfiles/tree/master/shared-config). **You will need both**.

* There is also a `setup.sh` **script** you can use in order to **automatically install** needed packages, configs and specific rices. You will find instructions [here](#arrow_down-download).

Here are some details about my setup:

<a href="https://youtu.be/_PTp5mh5_vQ"><img src="https://static.vecteezy.com/system/resources/previews/010/948/374/original/cute-food-character-funny-sushi-traditional-japanese-food-in-cartoon-kawaii-illustration-for-emoticon-symbol-icon-etc-png.png" alt="" align="right" width="400px"></a>
- **WM**                           : [bspwm](https://github.com/baskerville/bspwm) :art: several switchable themes!
- **Shell**                        : [zsh](https://wiki.archlinux.org/index.php/zsh) :shell: with [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) framework!
- **Terminal**                     : [kitty](https://github.com/kovidgoyal/kitty) :cat:
- **Panel**                        : [polybar](https://github.com/polybar/polybar) :shaved_ice: using [nerd fonts](https://github.com/ryanoasis/nerd-fonts) glyphs as icons!
- **Compositor**                   : [picom](https://github.com/chjj/compton) :sparkles:
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst) 🔔 
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi) :rocket: apps & sidebar menu!
- **File Manager**                 : [thunar](https://wiki.archlinux.org/index.php/Thunar)/[ranger](https://github.com/ranger/ranger) 📂 minimal file managers!
- **Wallpaper Manager**            : [feh](https://feh.finalrewind.org/) 🖼️

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<pre align="center">
  <div align="center">
    <a href="#art-custom-theme-swap-utility">THEME SWAP</a> • <a href="#arrow_down-download">DOWNLOAD</a> • <a href="#gear-installation">INSTALLATION</a> • <a href="#information_source-use-cases">USE CASES</a>
  </div>
</pre>

![alt text](readme-resources/themes_.png)

## [:maple_leaf: Horizon](https://github.com/zodd18/Horizon)
![alt text](https://github.com/zodd18/Horizon/blob/master/screenshot.png) 


<br/><br/>

## [❄️ Nord](https://github.com/zoddDev/Nord) (using ![Genome 🧬](https://www.reddit.com/r/unixporn/comments/kzd6zt/qtile_genome/) decorations)
![alt text](https://github.com/zoddDev/Nord/blob/master/screenshot.png) 


<br/><br/>

## [🌲 Forest](https://github.com/zodd18/Forest)
![alt text](https://github.com/zodd18/Forest/blob/master/screenshot.png) 


<br/><br/>

## [🔥 DOOMBOX](https://github.com/zodd18/Doombox)
![alt text](https://github.com/zodd18/Doombox/blob/master/screenshot.png) 

<br/><br/>

## [🍃 GruvboxMaterial](https://github.com/zoddDev/GruvboxMaterial)
![alt text](https://github.com/zoddDev/GruvboxMaterial/blob/main/screenshot.png) 


<br/><br/>

## [🌸 PinkNord](https://github.com/zodd18/PinkNord)
![alt text](https://github.com/zodd18/PinkNord/blob/master/screenshot.png) 


<br/><br/>

## [🌊 SolarizedDark](https://github.com/zodd18/SolarizedDark)
![alt text](https://github.com/zodd18/SolarizedDark/blob/master/screenshot.png) 


<br/><br/>

## [🎀 PinkNordAlternative](https://github.com/zodd18/PinkNordAlternative) (using [Fleon](https://github.com/owl4ce/dotfiles) colorscheme)
![alt text](https://github.com/zodd18/PinkNordAlternative/blob/master/screenshot.png) 

<br/><br/>

## [🌴 Gruvbox](https://github.com/zodd18/Gruvbox)
![alt text](https://github.com/zodd18/Gruvbox/blob/master/screenshot.png) 

<br/><br/>

## [🧛 Dracula](https://github.com/zoddDev/Dracula) 
![alt text](https://github.com/zoddDev/Dracula/blob/main/screenshot_.png) 

<br/><br/>

## [☀️ Ayu](https://github.com/zoddDev/Ayu) 
![alt text](https://github.com/zoddDev/Ayu/blob/master/screenshot.png) 

<br/>

<hr>

# :art: Custom Theme Swap Utility

### 1 - Click the brush icon in the polybar
<img src="./screenshots/brush.png" width=160 height=100>

## 2 - Select a rice
![alt text](screenshots/theme-swap-showcase.png)

## 3 - Now you have a completely new look and feel for your Linux desktop!
![alt text](screenshots/theme-swap-showcase-2.png)


![alt text](readme-resources/scripts_.png)

## Arch Linux and bspwm installation

These dotfiles target Arch Linux, Xorg and bspwm. Review the selected theme before installing it. Changed files are backed up under `~/.local/state/dotfiles-backups/`.

Clone the repository wherever you keep your projects, then install the desktop packages, shared configuration and one theme:

```sh
git clone https://github.com/zoddDev/dotfiles.git
cd dotfiles
./setup.sh packages
./setup.sh base
./setup.sh rice nord
```

`packages` uses the official Arch repositories and runs an interactive `pacman -Syu --needed`. `base` copies shared configuration, fonts, icons and scripts, then installs the Neovim plugins when Neovim is available. `rice` initializes the selected theme submodule and copies its files. Each command can be run separately. `./setup.sh all nord` runs all three in that order.

To download several themes for the switcher without repeatedly replacing the active configuration, run:

```sh
./setup.sh fetch-themes Horizon Nord PinkNord SolarizedDark PinkNordAlternative Dracula Ayu
```

The command accepts theme names without regard to letter case or hyphens, validates the full list before downloading, and leaves the currently installed theme unchanged. Use `Super+Alt+T` in bspwm to switch between the fetched themes.

Install the graphics driver that matches your GPU first. After `./setup.sh base`, the supplied Bash and Zsh login profiles start X automatically when you log in on TTY 1; `.xinitrc` launches bspwm. To choose the X keyboard layout, set `DOTFILES_XKB_LAYOUT=es` before logging in, or run `DOTFILES_XKB_LAYOUT=es startx` manually. The installer does not enable a display manager, log you in automatically, or change the system keyboard layout. If you use a display manager, select the bspwm session there and remove the automatic `startx` block from your login profile to avoid starting X twice.

Use `./setup.sh list-themes` to see available names. The theme switcher is bound to `Super+Alt+T`; it requires a graphical bspwm session and Rofi. Press `Super+F1` inside bspwm to open the searchable keyboard shortcut guide. `Ctrl+Alt+W` opens the Rofi wallpaper chooser for images in `~/.wallpapers` or `~/Pictures/Wallpapers`; feh restores the selected wallpaper next session. The Rofi launcher uses a larger 12 pt system sans-serif font and remains fully keyboard navigable.

Optional packages from the AUR are not required for the base desktop. Review each AUR package yourself, install yay or paru, then pass explicit names to `./setup.sh aur PACKAGE [PACKAGE ...]`.
