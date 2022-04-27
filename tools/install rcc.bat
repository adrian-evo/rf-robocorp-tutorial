:: This batch file will check and create Rcc folder and download rcc.exe if does not exists
@echo off

echo This script will download rcc.exe from Robocorp, copy it under %userprofile%\Rcc and set the Path to it. Close this window to exit.
timeout 10

if not exist %userprofile%\Rcc\rcc.exe (
  mkdir %userprofile%\Rcc
  cd %userprofile%\Rcc
  curl -o rcc.exe https://downloads.robocorp.com/rcc/releases/latest/windows64/rcc.exe
  powershell -Command "& {$value = Get-ItemProperty -Path HKCU:\Environment -Name Path; $newpath = $value.Path += "";%userprofile%\Rcc\""; Set-ItemProperty -Path HKCU:\Environment -Name Path -Value $newpath;}"
  goto END
) else (
  echo rcc.exe already installed under %userprofile%\Rcc. Press enter to update or close this window to exit.
  pause
)

:UPDATE
cd %userprofile%\Rcc
curl -o rcc.exe https://downloads.robocorp.com/rcc/releases/latest/windows64/rcc.exe
echo Rcc updated to the latest version.

:END
pause
