if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$dp = "list volume" | diskpart | ? { $_ -match "^ [^-]" }

echo (Get-Date).ToString("MM/dd/yyyy")`n

while(1) {
	foreach ($i in $dp) {
		if ($i -match "Mirror") {
			if (-Not ($i -match "Healthy")) {
				echo "Error"
				$popup = New-Object -ComObject Wscript.Shell
				$popup.Popup($i, 0, "RAID disk error was detected.", 0x0)
				break
			}
			else {
				$date = (Get-Date).ToString(" hh:mm:ss")
				$mess = $date + "	Healthy"
				echo $mess
			}
		}

	}
	sleep(600)
}