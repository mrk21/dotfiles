$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

. "${dir}\..\wsl\wsl-forwarding"

# @see https://qiita.com/frodo821/items/ed0f1c795eaac1736f30
# @see https://github.com/gerardog/gsudo
function Invoke-As-Admin() {
    if ($args.count -eq 0) {
        gsudo
        return
    }
    $cmd = $args -join ' '
    gsudo "pwsh.exe -Login -Command { $cmd }"
}

Set-Alias -Name: "sudo" -Value: "Invoke-As-Admin"
