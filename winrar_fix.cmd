:: remove winrar banner

set homePath=%cd%
move "%homePath%\winrar_fix.cmd" "%cd%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

reg delete HKEY_CURRENT_USER\software\winRar\General /v verinfo /f 
del %AppData%\winRar\version.dat
