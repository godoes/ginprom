@echo off
color 07
title ���²����� GO ģ������
:: file-encoding=GBK
rem by iTanken

cd /d %~dp0/../../
echo 1. ������������...
cd
::& go get -d -u & echo.
go get github.com/gin-gonic/gin@latest
::go get github.com/prometheus/client_golang@latest

echo 2. ����ģ������...
go mod tidy & echo.

:: echo 3. ����ģ�������� vendor Ŀ¼...
:: go mod vendor & echo.

git add .
call "%~dp0/done-time-pause.bat"
