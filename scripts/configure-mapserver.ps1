param (
    [string]$SDK,
    [string]$SWIG_VER,
    [string]$VS_VER,
    [string]$VC_VARS,
    [string]$PYTHON_LOCATION,
    [string]$PYTHON_VERSION
)

# https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt

cmd.exe /c "call `"$VC_VARS`" && set > %temp%\vcvars.txt"
Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
}
}

$PYTHON_ROOT_DIR="$PYTHON_LOCATION" -replace "\\","/"

# following commands for both local and GHA
$ROOT_FOLDER = (Get-Location).ToString() -replace "\\","/"
$SDK_PREFIX="$ROOT_FOLDER/sdk/$SDK"
$SDK_INC="$SDK_PREFIX/include"
$SDK_LIB="$SDK_PREFIX/lib"
$SDK_BIN="$SDK_PREFIX/bin"
$SWIG_EXECUTABLE="$ROOT_FOLDER/sdk/swigwin-$SWIG_VER/swig.exe"
$REGEX_DIR="$ROOT_FOLDER/sdk/support/regex-0.12"
$PYTHON_EXECUTABLE="$PYTHON_ROOT_DIR/python.exe"
mkdir build
cd build
$env:PATH="$ROOT_FOLDER/build/Release;$SDK_BIN;" + $env:PATH
# TODO is the following used?
$PROJECT_BINARY_DIR="$ROOT_FOLDER/build"
$SWIG_PYTHON_INTERPRETER_NO_DEBUG=1
$PYMAPSCRIPT_ANNOTATIONS=1

if ($PYTHON_VERSION -eq "3.13") {
    $sourcePath = Join-Path $SDK_BIN "sqlite3.dll"
    $targetPath = "c:\hostedtoolcache\windows\python\3.13.1\x64\DLLs"
    Copy-Item -Path $sourcePath -Destination $targetPath -Force
    Write-Host "sqlite3.dll successfully copied to $targetPath"
}

cmake -G "$VS_VER" -A "x64" "$ROOT_FOLDER/mapserver" `
-DCMAKE_BUILD_TYPE=Release `
-DCMAKE_PREFIX_PATH="$SDK_PREFIX" `
-DPNG_LIBRARY="$SDK_LIB/libpng16_static.lib" `
-DHARFBUZZ_INCLUDE_DIR="$SDK_INC/harfbuzz" `
-DICONV_DLL="$SDK_BIN/iconv.dll" `
-DFRIBIDI_INCLUDE_DIR="$SDK_INC/fribidi" `
-DMS_EXTERNAL_LIBS="$SDK_LIB/harfbuzz.lib;$SDK_LIB/uriparser.lib" `
-DSVG_LIBRARY="$SDK_LIB/libsvg.lib" `
-DSVGCAIRO_LIBRARY="$SDK_LIB/libsvg-cairo.lib" `
-DREGEX_DIR="$REGEX_DIR" `
-DSWIG_EXECUTABLE="$SWIG_EXECUTABLE" `
-DPROTOBUFC_COMPILER="$SDK_BIN/protoc.exe" `
-DPROTOBUFC_LIBRARY="$SDK_LIB/protobuf-c.lib" `
-DPROTOBUFC_INCLUDE_DIR="$SDK_INC/protobuf-c" `
-DWITH_CURL=1 `
-DWITH_KML=1 `
-DWITH_SVGCAIRO=1 `
-DWITH_THREAD_SAFETY=1 `
-DWITH_SOS=1 `
-DWITH_CLIENT_WFS=1 `
-DWITH_CLIENT_WMS=1 `
-DWITH_CSHARP=1 `
-DWITH_PROTOBUFC=1 `
-DWITH_POSTGIS=1 `
-DWITH_PERL=0 `
-DWITH_MSSQL2008=1 `
-DWITH_PYTHON=1 `
-DWITH_PHPNG=0 `
-DWITH_HARFBUZZ=1 `
-DPROJ_INCLUDE_DIR="$SDK_INC/proj9" `
-DPROJ_LIBRARY="$SDK_LIB/proj9.lib" `
-DPython_ROOT_DIR="$PYTHON_ROOT_DIR" `
-DPython_EXECUTABLE="$PYTHON_EXECUTABLE" `
-DWITH_PYMAPSCRIPT_ANNOTATIONS=$PYMAPSCRIPT_ANNOTATIONS

cmake --build . --config Release
# cannot use DEBUG here - see https://github.com/gisinternals/buildsystem/issues/195
# can use RelWithDebInfo
# cmake --build . --config RelWithDebInfo

$env:MAPSERVER_DLL_PATH="$ROOT_FOLDER/build/Release;$SDK_BIN"
$env:PROJ_DATA="$SDK_BIN/proj9/SHARE"

cmake --build . --target pythonmapscript-wheel --config Release

echo "Using $PYTHON_VERSION"

# make sdist for one version of Python as they are identical
# cannot use 3.13 as get the following error
# File "D:\a\python-mapscript\python-mapscript\build\src\mapscript\python\Release\setup.py", line 2, in <module>
#    from setuptools import setup, find_packages, Distribution
# ModuleNotFoundError: No module named 'setuptools'
if ($PYTHON_VERSION -eq "3.10")
{
    echo "Creating sdist..."
    cd "$ROOT_FOLDER/build/src/mapscript/python/Release"
    $params = "setup.py", "sdist"
    & $PYTHON_EXECUTABLE $params
    cd $ROOT_FOLDER
}