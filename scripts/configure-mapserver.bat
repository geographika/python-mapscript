REM deprecated - now using PowerShell

call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"

# following lines for local testing
#call "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
#cd /D D:\MapServer\VS2022
#set VS_VER="Visual Studio 17 2022"
#set PATH=D:/Tools/cmake-3.22.3-windows-x86_64/bin;%PATH%
#set PYTHON_ROOT_DIR=C:/Python310
#set SDK=release-1930-x64
#set SWIG_VER=4.1.0

# as above for GHA
set SDK=${{ env.SDK }}
set VS_VER="${{ env.VS_VER }}"
set PYTHON_ROOT_DIR=${{ env.pythonLocation }}
set SWIG_VER=${{ env.SWIG_VER }}

# following commands for both local and GHA
set PYTHON_ROOT_DIR=%PYTHON_ROOT_DIR:\=/%
set ROOT_FOLDER=%cd:\=/%
set SDK_PREFIX=%ROOT_FOLDER%/sdk/%SDK%
set SDK_INC=%SDK_PREFIX%/include
set SDK_LIB=%SDK_PREFIX%/lib
set SDK_BIN=%SDK_PREFIX%/bin
set SWIG_EXECUTABLE=%ROOT_FOLDER%/sdk/swigwin-%SWIG_VER%/swig.exe
set REGEX_DIR=%ROOT_FOLDER%/sdk/support/regex-0.12
set PYTHON_EXECUTABLE=%PYTHON_ROOT_DIR%/python.exe
mkdir build
cd build
set PATH=%ROOT_FOLDER%/build/Release;%SDK_BIN%;%PATH%;
set PROJECT_BINARY_DIR=%ROOT_FOLDER%/build
set SWIG_PYTHON_INTERPRETER_NO_DEBUG=1

set PYMAPSCRIPT_ANNOTATIONS=1
if "${{ matrix.python-version }}" EQU "2.7" (
set PYMAPSCRIPT_ANNOTATIONS=0
)

cmake -G %VS_VER% -A "x64" %ROOT_FOLDER%/mapserver -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%SDK_PREFIX% ^
-DPNG_LIBRARY=%SDK_LIB%/libpng16_static.lib -DHARFBUZZ_INCLUDE_DIR=%SDK_INC%/harfbuzz -DICONV_DLL=%SDK_BIN%/iconv.dll ^
-DFRIBIDI_INCLUDE_DIR=%SDK_INC%/fribidi -DMS_EXTERNAL_LIBS=%SDK_LIB%/harfbuzz.lib;%SDK_LIB%/uriparser.lib -DSVG_LIBRARY=%SDK_LIB%/libsvg.lib ^
-DSVGCAIRO_LIBRARY=%SDK_LIB%/libsvg-cairo.lib -DREGEX_DIR=%REGEX_DIR% -DSWIG_EXECUTABLE=%SWIG_EXECUTABLE% ^
-DPROTOBUFC_COMPILER=%SDK_BIN%/protoc.exe -DPROTOBUFC_LIBRARY=%SDK_LIB%/protobuf-c.lib -DPROTOBUFC_INCLUDE_DIR=%SDK_INC%/protobuf-c ^
-DWITH_CURL=1 -DWITH_KML=1 -DWITH_SVGCAIRO=1 -DWITH_THREAD_SAFETY=1 -DWITH_SOS=1 -DWITH_CLIENT_WFS=1 ^
-DWITH_CLIENT_WMS=1-DWITH_CSHARP=1 -DWITH_PROTOBUFC=1 -DWITH_POSTGIS=1 -DWITH_PERL=0 -DWITH_MSSQL2008=1 -DWITH_PYTHON=1 ^
-DWITH_PHPNG=0 -DWITH_HARFBUZZ=1 -DPROJ_INCLUDE_DIR=%SDK_INC%/proj7 -DPython_ROOT_DIR=%PYTHON_ROOT_DIR% ^
-DPython_EXECUTABLE=%PYTHON_EXECUTABLE% -DWITH_PYMAPSCRIPT_ANNOTATIONS=%PYMAPSCRIPT_ANNOTATIONS%

#cmake --build . --config Release
# cannot use DEBUG here - see https://github.com/gisinternals/buildsystem/issues/195
# can use RelWithDebInfo
cmake --build . --config Release

set MAPSERVER_DLL_PATH=%ROOT_FOLDER%/build/Release;%SDK_BIN%
set PROJ_LIB=%SDK_BIN%/proj7/SHARE

#set MAPSCRIPT_FLD=%ROOT_FOLDER%/build/mapscript/python/Release/mapscriptvenv/Lib/site-packages/mapscript
#if "${{ matrix.python-version }}" NEQ "3.10" (
#  copy %SDK_BIN%/sqlite3.dll %MAPSCRIPT_FLD%
#)
cmake --build . --target pythonmapscript-wheel --config Release

REM make sdist for one version of Python as they are identical
if "${{ matrix.python-version }}" EQU "3.10" (
cd %ROOT_FOLDER%/build/mapscript/python/Release
%PYTHON_EXECUTABLE% setup.py sdist
cd %ROOT_FOLDER%
)
