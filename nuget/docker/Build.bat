@setlocal enabledelayedexpansion
@echo off
@rem ***************************************
@rem Arguments
@rem %1: Distribution Configuration (ubuntu-16/centos-6)
@rem ***************************************

if "%1"=="" (
  @echo Error: Speficy build configuration [ubuntu-16/centos-6]
  @exit /B
) else if "%1"=="ubuntu-16" (
  @set DISTRIBUTION=ubuntu-16
) else if "%1"=="centos-6" (
  @set DISTRIBUTION=centos-6
)

@rem move to directory of batch file
@cd %~dp0

@rem save directory
@set CURDIR=%cd%

@rem Get root directory of DlibDotNet
@cd ..\..
@set DDNROOT=%cd%

@rem move
@cd %CURDIR%

@rem build
@docker build -t dlibdotnet-%DISTRIBUTION% -f Dockerfile.%DISTRIBUTION% .

@rem covner path
@set VOLUMEPATH=%DDNROOT%

@rem run
@docker run --name dlibdotnet-%DISTRIBUTION% --rm^
            -v "%VOLUMEPATH%:/opt/data/DlibDotNet" ^
            dlibdotnet-%DISTRIBUTION%