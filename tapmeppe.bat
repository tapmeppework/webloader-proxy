@echo off
@REM @since PM (13.05.2024) This script is used to synchronise the code & database between local & remote environments.
@REM testing
@REM WIN + R ++ cmd OR WIN ++ cmd
@REM ...
cls
@REM goto :eof

@REM color output
@REM @link https://stackoverflow.com/a/38617204/2652918
@REM @source https://gist.githubusercontent.com/mlocati/fdabcaeb8071d5c75a2d51712db24011/raw/b710612d6320df7e146508094e84b92b34c77d48/win10colors.cmd
@REM echo [__NUMBER__m__TEXT__[0m

@REM required because variables are set within blocks
@REM for some reason it is not really working this time
@REM @link https://www.tenforums.com/general-support/169953-batch-file-issue-related-enabledelayedexpansion.html VIP
@REM @link https://stackoverflow.com/a/50285862/2652918
SetLocal EnableDelayedExpansion

@REM move to the directory in which the file currently resides
@REM @link https://stackoverflow.com/a/5811989/2652918
@REM @link https://stackoverflow.com/a/636391/2652918
@REM @link https://stackoverflow.com/a/8797999/2652918
@REM echo COMMAND: %CD:~0,2% && CD "%~dp0%"
@REM %CD:~0,2% && CD "%~dp0%" && CD "../.."
@REM echo COMMAND: %CD:~0,2% && CD "%~dp0%" && ...
@REM %TAPMEPPE_CD:~0,2% && CD "%TAPMEPPE_CD%"
set "TAPMEPPE_CD=%cd%"
set "TAPMEPPE_DIRECTORY=%~dp0%"
set "TAPMEPPE_SCRIPT=%~n0%~x0"
%TAPMEPPE_DIRECTORY:~0,2% && CD "%TAPMEPPE_DIRECTORY%"

@REM set the console tile
title "t@pm3pp3 w0rk -- W3B R310@D3R"

if "%1" EQU "config" (
	echo [36mt@pm3pp3 w0rk -- CONFIGURATION[0m
	if not exist config.json (
		if exist config.template.json (
			@REM Install the missing modules
			npm install

			copy config.template.json config.json
			if %ERRORLEVEL% EQU 0 code config.json
		) else (
			echo [31mThe config.template.json could NOT be found.[0m
		)
	) else (
		@REM the config file exists already
		code config.json
	)
	goto :eof
)

echo [36mt@pm3pp3 w0rk -- %1[0m
npm start %1
