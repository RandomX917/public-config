set -gx EDITOR nvim
set -gx VISUAL nvim
fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

if status is-interactive
 set 1 (set_color blue)
set 2 (set_color cyan)
set 3 (set_color normal)
set cpu (cat /proc/cpuinfo | grep 'model name' | uniq | cut -d: -f2)

set total (free -m | awk '/^Mem:/ {print $2}')
set used (free -m | awk '/^Mem:/ {print $3}')
set pct (math --scale=2 "$used / $total * 100")

echo "\
$1        __   $2 ____    __
$1       /##\\   $2\\###\\  /##\\
$1       \\###\\   $2\\###\\/###/
$1     ___\\###\\___$2\\######/
$1    /############$2\\####/   $1/\\     $1 OS:$3$(uname -on)
$1   /##############$2\\###\\  $1/##\\    $2 Shell:$3 fish 
$1   ‾‾‾‾‾$2/###/$1‾‾‾‾‾ $2\\###\\$1/###/   $1  CPU:$3$cpu
$2 ______/###/        $2\\##$1/###/___  $2 Mem:$3 $used""MB / $total""MB ($pct%)
$2/#########/          $2\\$1/########\\ $1 WM/DE:$3 $XDG_CURRENT_DESKTOP
$2\\########/$1\\          $1/#########/
$2 ‾‾‾/###/$1##\\        $1/###/‾‾‾‾‾‾
$2   /###/$1\\###\\$2 _____$1/###/$2 ____
$2   \\##/  $1\\###\\$2##############/
$2    \\/   $1/####\\$2############/
$1        /######\\$2‾‾‾\\###\\‾‾‾
$1       /###/\\###\\$2   \\###\\
$1       \\##/  \\###\\$2   \\##/
$1        ‾‾    ‾‾‾‾$2    ‾‾
$3"
end
if command -q eza
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -lah --icons --group-directories-first"
    alias la="eza -A --icons --group-directories-first"
    alias lt="eza --tree --level=2 --icons"
else
    alias ls="ls --color=auto"
    alias ll="ls -lah"
    alias la="ls -A"
end
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias rebuild="sudo nixos-rebuild switch"
alias flakeup="nix flake update"
alias dev="nix develop"

alias say="echo"
#zoxide shi ahead 
function __zoxide_pwd
    builtin pwd -L
end

if ! builtin functions --query __zoxide_cd_internal
    if status list-files functions/cd.fish &>/dev/null
        status get-file functions/cd.fish | string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' | source
    else
        string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
    end
end

function __zoxide_cd
    if set -q __zoxide_loop
        builtin echo "zoxide: infinite loop detected"
        builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
        return 1
    end
    __zoxide_loop=1 __zoxide_cd_internal $argv
end
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end
abbr --erase z &>/dev/null
complete --erase --command z
alias z=__zoxide_z
abbr --erase zi &>/dev/null
complete --erase --command zi
alias zi=__zoxide_zi
alias cd=z
#end of the zoxide stuff
function fish_prompt
    set_color cyan
    echo -n (whoami)
    set_color normal
    echo -n "@"
    set_color blue
    echo -n (prompt_hostname)
    set_color normal
    echo -n " "
    set_color yellow
    echo -n (prompt_pwd)
    set_color red
    fish_git_prompt
    set_color normal
    echo -n " ❯ " 
end
set fish_greeting ""
