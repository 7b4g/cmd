:: Start app witout admin rights

set app_path="C:\Windows\regedit.exe"
cmd /min /C "set __COMPAT_LAYER=RUNASINVOKER && start "" %app_path%"

start "" "C:\Windows\regedit.exe"