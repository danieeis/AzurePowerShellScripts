<<<<<<< HEAD
$url = "https://referrals.brave.com/latest/BraveBrowserSetup-GAB835.exe\"
=======
$url = "https://referrals.brave.com/latest/BraveBrowserSetup-GAB835.exe\
>>>>>>> e7c15f7e897896835efa561ca6ada1b472c8ca86
Invoke-WebRequest -Uri $url -OutFile "BraveBrowserSetup-GAB835.exe" -UseBasicParsing
.\BraveBrowserSetup-GAB835.exe