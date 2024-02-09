:: BETA version! NEED testing.
:: Windows updates can take long time 
:: But it can be more quick if use 1 acrhive file instead many small files from network
:: This script automate downloading archive file from network folder and install updates locally from user PC

:: First you need rar-archive with all updates files (setup.exe also needed)
:: Need admin rights: for Windows/Temp, install updates
:: Need winrar installed
:: Windows-console will shown after script start (user will see it)
:: Variables: windows_version, rarNetworkPath, tmp_path - work only without spaces!
:: rarNetworkPath - is directory not file!

@Echo off

:: Change values
set log_path=\\your-network-folder-path-to-logs-dir\%computername%_%username%.log
set windows_verson_name=microsoft-20h2
set rarNetworkPath=\\path-to-rar-archive-with-setup.exe\%windows_verson_name%.rar
set rarPathLocal=C:\Windows\Temp\%windows_verson_name%\%windows_verson_name%.rar

:: Standart values, doesnt need to be changed
set tmp_path="C:\Windows\Temp\%windows_verson_name%\"
for /f "tokens=1-3 delims=," %%a in ("TIME") do (set now_time=%%a:%%b:%%c)
echo %now_time% Script started >> %log_path%

:: Check if disk space enough for update (<12 Gb)
for /f "userbackq tokens=3" %%s in (`dir c:\ /-c /-o /w`) do (set free_space=%%s)
if %free_space% LEQ 12884901888 echo "%now_time% Not enough free space on disk" >> %log_path% && exit

:: Skip if archive already downloaded
if %rarPathLocal% exist goto unrar

:: 
echo %now_time% Archive downloading >> %log_path%
robocopy %rarNetworkPath% %tmp_path% /NDL /NJH
echo %now_time% Archive downloading finished >> %log_path%

:unrar
"%ProgramFiles%\WinRar\winrar.exe" x %rarPathLocal% *.* %tmp_path%

:: Compatibility check
echo %now_time% Compatibility check >> %log_path%
%tmp_path%\setup.exe /Auto Upgrade /Quiet /NoReboot /DynamicUpdate Disable /Compat ScanOnly
if %errorlevel% EQU -1047526896 else goto error
echo %now_time% Compatibility check successful >> %log_path%

:: Update
echo %now_time% Update started >> %log_path%
%tmp_path%\setup.exe /Auto Upgrade /quiet /NoReboot /DynamicUpdate Disable /showoobe None /Telemetry Disabled
echo %now_time% Update finished >> %log_path%
exit

:error
echo %now_time% Compatibility error: %errorlevel% >> %log_path%
exit

