@echo off
title Detection de bornes Cewe sur le reseau
mode con: lines=120
color 4f
:Intro
echo.
echo.
echo.
echo Network Scanner par Maxime Boucher
echo -----------------
echo   d8888b.   8888888888 888       888 8888888888                        
echo d88P  Y88b  888        888   o   888 888                               
echo 888    888  888        888  d8b  888 888                               
echo 888         8888888    888 d888b 888 8888888                           
echo 88          888        888d88888b888 888                               
echo 888    888  888        88888P Y88888 888                               
echo Y88b  d88P  888        8888P   Y8888 888                               
echo "Y8888P"    8888888888 888P     Y888 8888888888                        
echo.
echo.
echo Ce fichier Batch scanne les plages d'adresses IP avec un delai de 160ms 
echo.
:ipconfig
ipconfig.exe | findstr IPv4
echo.
echo.
echo.
echo Veuillez saisir les trois premier chiffres de l'adresse IP affiche ci dessus en suivant le format suivant:
set /p ipbegin=Exemple: "192.168.1" :



if exist errorchk.bat del errorchk.bat
if exist "%userprofile%\desktop\IP Scan.txt" del "%userprofile%\desktop\IP Scan.txt"

 

::Create errorchk.bat
echo @echo off>>errorchk.bat
echo echo.>>errorchk.bat
echo echo Error level finder>>errorchk.bat
echo rem run program>>errorchk.bat
echo call %%1 %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9>>errorchk.bat
echo. >>errorchk.bat
echo for /l %%%%f in (49152, -1, 0 ) do (>>errorchk.bat
echo if errorlevel=%%%%f echo Errorlevel=%%%%f>>errorchk.bat
echo )>>errorchk.bat


set errorlevel=0


rem Declare variables
set timeout=0

if "%1"=="" (
echo Default timeout used [160 ms]
set timeout=160
echo.
)

:settimeout
if %timeout%==0 set timeout=%1


:default
for /l %%f in (1, 1, 254) do (
set errorlevel=0

call "errorchk.bat" ping -n 1 -w %timeout% %ipbegin%.%%f  > nul

rem log entry
if not errorlevel=1 echo %ipbegin%.%%f Actif>>"%userprofile%\desktop\IP Scan.txt"
if errorlevel=1 echo.

if %%f EQU 1 (cls
echo. Scan en cours
echo [                             ]    0 %%)
if %%f EQU 25 (cls
echo.Scan en cours
echo [###                          ]    10 %%)
if %%f EQU 55 (cls
echo.Scan en cours
echo [######                       ]    20 %%)
if %%f EQU 75 (cls
echo.Scan en cours
echo [#########                    ]    30 %%)
if %%f EQU 100 (cls
echo.Scan en cours
echo [############                 ]    40 %%)
if %%f EQU 125 (cls
echo.Scan en cours
echo [###############              ]    50 %%)
if %%f EQU 150 (cls
echo.Scan en cours
echo [##################           ]    60 %%)
if %%f EQU 175 (cls
echo.Scan en cours
echo [#####################        ]    70 %%)
if %%f EQU 200 (cls
echo.Scan en cours
echo [########################     ]    80 %%)
if %%f EQU 225 (cls
echo.Scan en cours
echo [###########################  ]    90 %%)
if %%f EQU 254 (cls
echo.Scan en cours
echo [#############################]    Network Scan complete)
)

if exist errorchk.bat del errorchk.bat
echo ouverture du fichier dans 5 secondes 
choice /t: o,5>nul

START  notepad "%userprofile%\desktop\IP Scan.txt"


exit