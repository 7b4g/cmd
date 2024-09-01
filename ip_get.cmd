@echo off
chcp 1251 >nul

set tmp=%tmp%\ip_8934.tmp

ipconfig|find "IPv4" > %tmp%
set /p ip=< %tmp%
echo %ip:~39%|clip

del %tmp%
