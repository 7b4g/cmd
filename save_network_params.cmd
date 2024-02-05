:: If you need get windows updates through proxy
:: Need admin rights
:: Script save your ip, submask, gateway params to inet_cfg.log, set your proxy, and after start windows updates
:: After updates proxy resets 
:: Also, you need set adapter params back manually (if its not set dynamically)

@echo off
chcp 65001
cls

:: Set your value
set /a proxy="IP:Port"


set /a cfgPath="%userprofile%\Desktop\inet_cfg.log"

netsh interface ip show address name="Ethernet" > %cfgPath%
netsh winhttp set proxy %proxy%

clsstart ms-settings:windowsupdate
set /p input="Time 4 updates! After finish press Enter..."
netsh winhttp reset proxy

set /p input="Set adapter params from file inet_cfg.log back"

