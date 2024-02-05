:: No admin rights required
:: Print all outlook archives path to outlook_arhives_path.txt
:: After that outlook profile menu will start

@echo off
chcp 1251 >nul

set temp_1=C:\Users\%username%\Desktop\arh-375893458.tmp
set temp_2=C:\Users\%username%\Desktop\arh-564564537.tmp
set arch_path="C:\Users\%username%\Desktop\outlook_arhives_path.txt"

if exist %arch_path% goto profile
for /f "tokens=*" %%i IN ('reg query "HKEY_CLASSES_ROOT\Word.Application\CurVer"') do set var=%%i
set /a reg_version=%var:~-2%
reg query "HKCU\SOFTWARE\Microsoft\Office\%reg_version%.0\Outlook\Search" | findstr / "Desktop ost Search" > %temp_1%
for /f "tokens=*" %%i in (%temp_1%) do (echo %%~dpg >> %temp_2%)
del %temp_1%
@<"%temp_2%">"%arch_path%" (for /f "delims=" %%i in ('more') do @if not defined %%i (echo %%i& set %%i=*))
del %temp_2%

:profile
start outlook.exe /profiles