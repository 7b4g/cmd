:: For example you have 1000 CD disks and you need copy files from it in your dir
:: Too much routine to do it manually
:: So you can just use this script

@echo off
chcp 65001>nul

set /P directory="CD letter: "
set /P docs_path="Folder name on desktop"

:start

if not exist %directory% goto :wait
2>nul dir /a-d/b/s "%directory%:\"|find /c /v ""|set /p z=^& cmd /v/c
if !z! > 1 goto :manyfiles

xcopy %directory%:\* C:\Users\%username%\Desktop\%docs_path% /f /i /-y /s
echo CD Open!
TIMEOUT /T 1
powershell -command "(New-Object -comObject Shell.Application).NameSpace(17).ParseName('%directory%:')".InvokeVerb('Eject')!
TIMEOUT /T 3
:start

:wait
TIMEOUT /T 5
goto :start

:manyfiles
set /P subdir="Name for subdir: "
xcopy %directory%\* C:\Users\%username%\Desktop\%docs_path%\%subdir% /f /i /-y /set
goto :start
