if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$dp = "list volume" | diskpart | ? { $_ -match "^ [^-]" }

echo (Get-Date).ToString("yyyy�NMM��dd��")`n

while(1) {
	foreach ($i in $dp) {
		if ($i -match "�~���[") {
			if (-Not ($i -match "����")) {
				echo "�G���["
				$popup = New-Object -ComObject Wscript.Shell
				$popup.Popup($i, 0, "RAID�f�B�X�N�̃G���[�����m���܂���", 0x0)
				break
			}
			else {
				$date = (Get-Date).ToString("hh��mm��ss�b")
				$mess = $date + "	�ُ�Ȃ�"
				echo $mess
			}
		}

	}
	sleep(600)
}