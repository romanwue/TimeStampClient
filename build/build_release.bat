setlocal

@rem Initialize Visual Studio build environment:
@rem - Visual Studio 2017 Community/Professional/Enterprise is the preferred option
@set tools=
@set tmptools="c:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsMSBuildCmd.bat"
@if exist %tmptools% set tools=%tmptools%
@set tmptools="c:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools\VsMSBuildCmd.bat"
@if exist %tmptools% set tools=%tmptools%
@set tmptools="c:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsMSBuildCmd.bat"
@if exist %tmptools% set tools=%tmptools%
@if not defined tools goto :error
call %tools%
@echo on

@rem Remove leftovers of any previous builds
rmdir /S /Q ..\src\TimeStampClient\bin
rmdir /S /Q ..\src\TimeStampClient\obj
rmdir /S /Q ..\src\TimeStampClientCmd\bin
rmdir /S /Q ..\src\TimeStampClientCmd\obj
rmdir /S /Q ..\src\TimeStampClientGui\bin
rmdir /S /Q ..\src\TimeStampClientGui\obj

@rem Build for AnyCPU platform
msbuild ..\src\DisigTimeStamp.sln /p:Configuration=Release /p:Platform="Any CPU" /target:Clean || goto :error
msbuild ..\src\DisigTimeStamp.sln /p:Configuration=Release /p:Platform="Any CPU" /target:Restore /target:ReBuild || goto :error

endlocal

setlocal

@rem Prepare output directory for application
set APPDIR=application
set LICDIR=%APPDIR%\license
rmdir /S /Q %APPDIR%
mkdir %APPDIR% || goto :error
mkdir %LICDIR% || goto :error

@rem Copy binaries to the output directory
copy ..\src\TimeStampClientGui\bin\Release\TimeStampClientGui.exe %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\TimeStampClientGui.exe.config %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\TimeStampClient.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\BouncyCastle.Crypto.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.Wpf.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.WinForms.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\MonoMac.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.Mac64.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.Gtk2.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.Gtk3.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Eto.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientGui\bin\Release\Ionic.Zip.Reduced.dll %APPDIR% || goto :error
copy ..\src\TimeStampClientCmd\bin\Release\TimeStampClientCmd.exe %APPDIR% || goto :error
copy ..\src\TimeStampClientCmd\bin\Release\TimeStampClientCmd.exe.config %APPDIR% || goto :error

@rem Copy licenses to the output directory
copy license\*.txt %LICDIR% || goto :error

endlocal

setlocal

@rem Prepare output directory for nuget
set NUGETDIR=nuget
rmdir /S /Q %NUGETDIR%
mkdir %NUGETDIR% || goto :error

@rem Copy packages to the output directory
copy ..\src\TimeStampClient\bin\Release\*.nupkg %NUGETDIR%
copy ..\src\TimeStampClient\bin\Release\*.snupkg %NUGETDIR%

endlocal

@echo *** BUILD SUCCESSFUL ***
@endlocal
@exit /b 0

:error
@echo *** BUILD FAILED ***
@endlocal
@exit /b 1

