:: Sometimes BSS plugin report to update
:: but message still showed
:: this script stop chrome and bss plugin
:: clean cache
:: and starting bss plugin and chrome

@echo off

Taskkill /IM bssPluginHost.exe /F
Taskkill /IM chrome.exe /F

del /q /s /f "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\Cache\*"

start /D "C:\Users\%username%\AppData\Roaming\BSS\BSSPlugin\" bssPluginHost.exe
start /D "C:\Program Files (x86)\Google\Chrome\Application" chrome.exe