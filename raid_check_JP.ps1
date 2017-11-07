if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$dp = "list volume" | diskpart | ? { $_ -match "^ [^-]" }

echo (Get-Date).ToString("yyyy年MM月dd日")`n

while(1) {
	foreach ($i in $dp) {
		if ($i -match "ミラー") {
			if (-Not ($i -match "正常")) {
				echo "エラー"
				$popup = New-Object -ComObject Wscript.Shell
				$popup.Popup($i, 0, "RAIDディスクのエラーを検知しました", 0x0)
				break
			}
			else {
				$date = (Get-Date).ToString("hh時mm分ss秒")
				$mess = $date + "	異常なし"
				echo $mess
			}
		}

	}
	sleep(600)
}