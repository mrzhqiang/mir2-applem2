@echo off
echo ***************************************************
echo Building Raize Components 5
echo ***************************************************

rem ****************************************************************************
rem **** IMPORTANT NOTES *******************************************************
rem ****************************************************************************

rem     DO NOT MOVE THIS FILE!
rem     THIS COMMAND FILE MUST BE LOCATED IN THE SOURCE DIRECTORY FOR YOUR
rem     INSTALLATION OF RAIZE COMPONENTS 5.
rem
rem     e.g. C:\Program Files\Raize\RC5\Source
                         

rem     ALL APPLICATIONS THAT USE THE RAIZE COMPONENTS 5 RUNTIME PACKAGES
rem     (INCLUDING DELPHI AND RAD STUDIO) MUST BE SHUT DOWN BEFORE REBUILDING 
rem     THE COMPONENTS.


rem ****************************************************************************
rem **** SET CONFIGURATION VARIABLES *******************************************
rem ****************************************************************************

rem     Uncomment the following goto statement after you have initialized the
rem     Configuraion Variables.

rem goto InitComplete

echo.
echo Build Configuration Variables have not been initialized.  
echo.
echo Before you can execute this command file to rebuild Raize Components 5,
echo you must initialize a few configuration variables.  Simply edit the
echo !Build_RC5.cmd file with a text editor and follow the instructions in the
echo SET CONFIGURATION VARIABLES section. Also, please read the IMPORTANT NOTES
echo section.
echo.
echo Once the configuration variables have been initialized and the
echo !Build_RC5.cmd saved, you can simply run !Build_RC5.cmd file to rebuild
echo Raize Components 5.
echo.
pause
exit

:InitComplete



rem     Change the SysPath variable to the path of your Windows System folder.
rem     Please note that if you are running a 64-bit OS, then the Windows
rem     System folder should be the SysWOW64 folder.

set SysPath="C:\Windows\System32"


rem     Set Compiler to "Delphi" if building for
rem       Delphi 7 
rem       Delphi 2005
rem
rem     Set Compiler to "BDS" if building for
rem       Borland Developer Studio 2006 (including Turbo Editions)
rem       CodeGear RAD Studio 2007 (e.g. Delphi 2007)
rem       CodeGear RAD Studio 2009
rem       Embarcadero RAD Studio 2010
rem       Embarcadero RAD Studio XE

set Compiler="BDS"


rem     Change VCLVersion to 7, 9, 10, 12, 14, or 15 depending on version of 
rem     Delphi/BDS/RADStudio you are using
rem
rem     RAD Studio XE   (Delphi XE)      VCLVersion="15"
rem     RAD Studio 2010 (Delphi 2010)    VCLVersion="14"
rem     RAD Studio 2009 (Delphi 2009)    VCLVersion="12"
rem     RAD Studio 2007 (Delphi 2007)    VCLVersion="10"   RS 2007 & BDS 2006 use same VCL
rem     BDS 2006                         VCLVersion="10"
rem     Delphi 2005                      VCLVersion="9"
rem     Delphi 7                         VCLVersion="7"

set VCLVersion="15"


rem     Change the DCC32EXE variable to specify the full path of the DCC32.exe 
rem     command line compiler located in your Delphi/BDS Bin directory.

set DCC32EXE="C:\Program Files\Embarcadero\RAD Studio\8.0\Bin\DCC32.exe"


rem ****************************************************************************
rem **** DO NOT CHANGE ANYTHING BELOW THIS POINT *******************************
rem ****************************************************************************

if %VCLVersion% == "7" goto Version7
if %VCLVersion% == "9" goto Version9
if %VCLVersion% == "10" goto Version10
if %VCLVersion% == "12" goto Version12
if %VCLVersion% == "14" goto Version14
if %VCLVersion% == "15" goto Version15
echo Invalid VCL Version %VCLVersion%
goto Error


rem ============================================================================
:Version7

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi7
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl70.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb70.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design70.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design70.bpl

goto Init

rem ============================================================================
:Version9

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=Delphi2005
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl90.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb90.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design90.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design90.bpl

goto Init

rem ============================================================================
:Version10              

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=BDS2006
set Options=-LUDclStd
set DBOptions=-LUDclDB

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl100.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb100.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design100.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design100.bpl

goto Init

rem ============================================================================
:Version12

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=RS2009
set Options=-LUDclStd
set DBOptions=-LUDclDB
set SkipFixupHppFiles=True

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl120.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb120.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design120.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design120.bpl

goto Init

rem ============================================================================
:Version14

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=RS2010
set Options=-LUDclStd
set DBOptions=-LUDclDB
set SkipFixupHppFiles=True

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl140.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb140.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design140.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design140.bpl

goto Init

rem ============================================================================
:Version15

set DCC32=%DCC32EXE% -Q -W -H -$D- -$L- -$Y-
set LibDir=RS-XE
set Options=-LUDclStd
set DBOptions=-LUDclDB
set SkipFixupHppFiles=True

set ND_RTP=RaizeComponentsVcl
set ND_RTP_BPL=RaizeComponentsVcl150.bpl
set DB_RTP=RaizeComponentsVclDb
set DB_RTP_BPL=RaizeComponentsVclDb150.bpl
set ND_DP=RaizeComponentsVcl_Design
set ND_DP_BPL=RaizeComponentsVcl_Design150.bpl
set DB_DP=RaizeComponentsVclDb_Design
set DB_DP_BPL=RaizeComponentsVclDb_Design150.bpl

goto Init

:Init

set ND_RegFile=RaizeComponentsVcl_Reg.pas
set DB_RegFile=RaizeComponentsVclDb_Reg.pas

:PathSetup

set LibPath=..\Lib\%LibDir%
set BinPath=..\Bin
set SysPath1=..\Bin\System32
set SysPath2=%SysPath%
goto Build


rem ============================================================================
rem ==== Build Processing Section ==============================================
rem ============================================================================

:Build

if %Compiler% == "BDS" goto Build_BDS
if %Compiler% == "Delphi" goto Build_Delphi
echo Invalid Compiler 
goto Error


rem ============================================================================
rem ==== Delphi BDS Section ====================================================
rem ============================================================================
:Build_BDS

echo.
echo Compiling %ND_RegFile% File...
echo.
%DCC32% -B %Options% %ND_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %DB_RegFile% File...
echo.
%DCC32% -B %DBOptions% %DB_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %ND_RTP%.dpk Package...
echo.
%DCC32% -B -jl -LN. %ND_RTP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %DB_RTP%.dpk Package...
echo.
%DCC32% -B -jl -LN. %DB_RTP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %ND_DP%.dpk Package...
echo.
%DCC32% -jl -LN. %ND_DP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Compiling %DB_DP%.dpk Package...
echo.
%DCC32% -jl -LN. %DB_DP%.dpk
if errorlevel 1 goto error
echo.

echo.
echo Deleting Package DCU files...
del %ND_RTP%.dcu > nul
del %DB_RTP%.dcu > nul
del %ND_DP%.dcu > nul
del %ND_DP%.hpp > nul
del %ND_DP%.lib > nul
del %DB_DP%.dcu > nul
del %DB_DP%.hpp > nul
del %DB_DP%.lib > nul


echo.
echo Copying Build Files to %LibPath%...
copy "*.dcu" %LibPath% > nul
copy "*.dfm" %LibPath% > nul
copy "*.res" %LibPath% > nul
copy "*.hpp" %LibPath% > nul
copy "*.lib" %LibPath% > nul
      
copy %ND_RTP%.dcp %LibPath% > nul
copy %ND_RTP%.bpi %LibPath% > nul
copy %ND_RTP%.hpp %LibPath% > nul
copy %ND_RTP_BPL% %SysPath1% > nul
copy %ND_RTP_BPL% %SysPath2% > nul

copy %DB_RTP%.dcp %LibPath% > nul
copy %DB_RTP%.bpi %LibPath% > nul
copy %DB_RTP%.hpp %LibPath% > nul
copy %DB_RTP_BPL% %SysPath1% > nul
copy %DB_RTP_BPL% %SysPath2% > nul

copy %ND_DP_BPL% %BinPath% > nul
copy %DB_DP_BPL% %BinPath% > nul

rem If building for BDS 2006 or BDS 2007, then we need to fix up some of the
rem HPP files that get generated. This step gets skipped for RS 2009 and later.
if "%SkipFixupHppFiles%" == "True" goto SkipBDSFixup
"FixupHppFiles\FixupHppFiles.exe" %LibPath%
if errorlevel 1 goto error 
:SkipBDSFixup

goto Success


rem ============================================================================
rem ==== Delphi Build Section ==================================================
rem ============================================================================
:Build_Delphi

echo.
echo Compiling %ND_RegFile% File...
echo.
%DCC32% -B %Options% %ND_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %DB_RegFile% File...
echo.
%DCC32% -B %DBOptions% %DB_RegFile%
if errorlevel 1 goto error

echo.
echo Compiling %ND_RTP%.dpk Package...
echo.
%DCC32% -LN. %ND_RTP%.dpk
if errorlevel 1 goto error
echo.
copy %ND_RTP%.dcp %LibPath% > nul
copy %ND_RTP_BPL% %SysPath1% > nul
copy %ND_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %DB_RTP%.dpk Package...
echo.
%DCC32% -LN. %DB_RTP%.dpk
if errorlevel 1 goto error
echo.
copy %DB_RTP%.dcp %LibPath% > nul
copy %DB_RTP_BPL% %SysPath1% > nul
copy %DB_RTP_BPL% %SysPath2% > nul

echo.
echo Compiling %ND_DP%.dpk Package...
echo.
%DCC32% -LN. %ND_DP%.dpk
if errorlevel 1 goto error
echo.
copy %ND_DP_BPL% %BinPath% > nul

echo.
echo Compiling %DB_DP%.dpk Package...
echo.
%DCC32% -LN. %DB_DP%.dpk
if errorlevel 1 goto error
echo.
copy %DB_DP_BPL% %BinPath% > nul

echo.
echo Deleting Package DCU files...
del %ND_RTP%.dcu > nul
del %DB_RTP%.dcu > nul
del %ND_DP%.dcu > nul
del %DB_DP%.dcu > nul

echo.
echo Copying Build Files to %LibPath%...
copy "*.dcu" %LibPath% > nul
copy "*.dfm" %LibPath% > nul
copy "*.res" %LibPath% > nul


goto Success


rem ============================================================================
:Success
echo.
echo Build was Successful.
goto end


rem ============================================================================
:error
echo.
echo **ERROR**

rem ============================================================================
:end
pause
