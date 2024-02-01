<p align="center">
<img src="images/babidiii-dotfiles-logo.png" alt="Babidiii dotfile logo" title="logo" />
</p>

# .dotfiles

![main-monitor](images/screenshot-1.png)  

Configuration are available for: 

- ~~vim~~/nvim
- tmux
- polybar
- bspwm
- dwm
- ~~dmenu~~
- readline
- dunst
- sxiv

<details close>
<summary>Polybar</summary>
<br>

main monitor:  
![polybar-screenshot-main](images/polybar-main.png)  
second monitor:  
![polybar-screenshot-second](images/polybar-second.png)  
</details>


<details close>
<summary>sxiv</summary>
<br>

| key bindings | description                      | Require             |
|--------------|----------------------------------|---------------------|
| `C-x`        | copy filename into the clipboard | `xclip`             |
| `C-c`        | Copy image into the clipboard    | `xclip`             |
| `C-g`        | Open into gimp                   | `st, exiv2`         |
| `C-comma`    | Rotate 270                       | `jpegtran, mogrify` |
| `C-period`   | Rotate 90                        | `jpegtran, mogrify` |
| `C-slash`    | Rotate 180                       | `jpegtran, mogrify` |
| `C-k`        | Send the file using croc         | `croc, whiptail`    |
| `C-d`        | Dmenu popup for deletion         | `dmenu`             |
| `C-s`        | Set as background                | `setbg`             |


Demo for wallpaper and croc shortcut: 

![sxiv-demo](demo/sxiv.gif)  

</details>
