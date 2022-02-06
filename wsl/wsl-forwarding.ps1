$HostIP = [IPAddress]"0.0.0.0"

function Invoke-WSL-Command([String]$Cmd) {
  while (1) {
    $Result = wsl bash -c $Cmd
    if (!$?) {
      Write-Debug "Retry...: $Cmd"
      Start-Sleep 1
      continue
    }
    return $Result
  }
}

function Get-WSL-IP() {
  [OutputType([IPAddress])]
  $IP = Invoke-WSL-Command "ip route | grep 'eth0 proto' | cut -d ' ' -f9"
  return [IPAddress]$IP
}

function Get-WSL-Ports() {
  [OutputType([String[]])]
  $Ports = Invoke-WSL-Command "ss -ltunH | sed -e 's/ \+/ /g' | cut -d ' ' -f 5 | grep -E '^(\*|0.0.0.0):' | sed -e 's/.*:\([0-9]\+\)/\1/g'"
  return $Ports ? $Ports : @()
}

class Forwarding {
  [IPAddress] $FromIP;
  [IPAddress] $ToIP;
  [String] $Port;
}

function Get-Current-Forwardings() {
  [OutputType([Forwarding[]])]
  $Result = netsh interface portproxy show v4tov4
  $Result = $Result[5..($Result.Count-2)]
  $Result = $Result | ForEach-Object {
    $v = $_ -split "\s+"
    [Forwarding]@{
      FromIP = [IPAddress]$v[0];
      ToIP = [IPAddress]$v[2];
      Port = [String]$v[1];
    }
  }
  $Result = $Result | Where-Object { $_.FromIP.Address -eq $HostIP.Address }
  return $Result
}

function Register-Forwarding([IPAddress]$WSLIP, [String]$Port) {
  $r = netsh interface portproxy add v4tov4 listenaddress=$HostIP listenport=$Port connectaddress=$WSLIP connectport=$Port
  if ($r) { Write-Host $r }
  else { Write-Host "Register forwarding: ${HostIP}:${Port} => ${WSLIP}:${Port}" }
}

function Unregister-Forwarding([String]$Port) {
  $r = netsh interface portproxy delete v4tov4 listenaddress=$HostIP listenport=$Port
  if ($r) { Write-Host $r }
  else { Write-Host "Unregister forwarding: ${HostIP}:${Port}" }
}

function Start-WSL-Forwarding() {
  $WSLIPMap = @{}

  try {
    while (1) {
      $WSLIP = Get-WSL-IP
      $WSLIPMap[$WSLIP.Address] = $WSLIP

      $WSLPorts = Get-WSL-Ports
      $WSLPortMap = $WSLPorts | ForEach-Object -Begin { $r = @{} } { $r[$_] = 1 } -End { $r }

      $CurrentForwardings = Get-Current-Forwardings
      $CurrentForwardingMap = $CurrentForwardings | ForEach-Object -Begin { $r = @{} } { $r[$_.Port] = $_ } -End { $r }

      # Register new forwarding
      foreach ($Port in $WSLPorts) {
        if (!$CurrentForwardingMap[$Port]) {
          Register-Forwarding $WSLIP $Port
        }
        elseif ($CurrentForwardingMap[$Port].ToIP.Address -ne $WSLIP.Address) {
          Unregister-Forwarding $Port
          Register-Forwarding $WSLIP $Port
        }
      }

      # Unregister forwarding stopped listening
      $CurrentForwardings |
        Where-Object { ($_.ToIP.Address -eq $WSLIP.Address) -and !$WSLPortMap[$_.Port] } |
        ForEach-Object { Unregister-Forwarding $_.Port }

      # Unregister previous WSL2 execution
      $CurrentForwardings |
        Where-Object { ($_.ToIP.Address -ne $WSLIP.Address) -and $WSLIPMap[$_.ToIP.Address] } |
        ForEach-Object { Unregister-Forwarding $_.Port }

      Start-Sleep 2
    }
  }
  # Interrupt
  finally {
    # Unregister forwarding of WSL2
    Get-Current-Forwardings |
      Where-Object { $WSLIPMap[$_.ToIP.Address] } |
      ForEach-Object { Unregister-Forwarding $_.Port }
  }
}

Set-Alias wsl-forwarding Start-WSL-Forwarding
