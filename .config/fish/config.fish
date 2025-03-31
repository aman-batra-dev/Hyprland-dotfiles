cd ~
#starship init fish | source

alias hyprconfig 'vim ~/.config/hypr/hyprland.conf'

if status is-login
    contains /usr/share/dotnet $PATH
    or set PATH /usr/share/dotnet $PATH
end
set fish_greeting


if status is-interactive
    # Commands to run in interactive sessions can go here
end
