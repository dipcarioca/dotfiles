cat .cache/wal/sequences

alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias ytmp3='yt-dlp --extract-audio --audio-format mp3'
alias py='python'
alias update='yay -Syu --noconfirm; and flatpak update -y' 
alias cleanup="sudo pacman -Rsn (pacman -Qtdq)"

# --- environments variants ---
set -gx LANG "pt_BR.UTF-8"
set -gx LC_ALL "pt_BR.UTF-8"
set -gx EDITOR nvim
set -gx TERMINAL kitty
fish_add_path /home/dip/.local/bin

# --- color for autosugesstion ---
set -g fish_color_autosuggestion d01313

function fish_prompt
    set_color red
    echo -n (prompt_pwd) " > "
    set_color normal
end

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
