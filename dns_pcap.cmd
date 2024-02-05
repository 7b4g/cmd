:: Create .pcap file on destop with 53 port knock

@echo off
chcp 65001

pktmon filter add -p 53
pktmon start --etw
cls
set /p input="Send your dns request!"
pktmon stop
pktmon PCAPNG PktMon.etl -o %userprofile%\desktop\%date%.PCAPNG
