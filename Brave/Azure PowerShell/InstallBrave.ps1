$url = https://referrals.brave.com/latest/BraveBrowserSetup-GAB835.exe
Invoke-WebRequest -Uri $url -OutFile "BraveBrowserSetup-GAB835.exe"
& .\BraveBrowserSetup-GAB835.exe