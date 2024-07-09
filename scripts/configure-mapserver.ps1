# https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt

# remote
$VCVARS = "${{ env.VC_VARS }}"

cmd.exe /c "call `"$VCVARS`" && set > %temp%\vcvars.txt"
Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
}
}

$SDK="${{ env.SDK }}"
$VS_VER="${{ env.VS_VER }}"
$PYTHON_ROOT_DIR="${{ env.pythonLocation }}" -replace "\\","/"
$SWIG_VER="${{ env.SWIG_VER }}"


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
-DPython_ROOT_DIR="$PYTHON_ROOT_DIR" `
-DPython_EXECUTABLE="$PYTHON_EXECUTABLE" `
-DWITH_PYMAPSCRIPT_ANNOTATIONS=$PYMAPSCRIPT_ANNOTATIONS

cmake --build . --config Release
# cannot use DEBUG here - see https://github.com/gisinternals/buildsystem/issues/195
# can use RelWithDebInfo
# cmake --build . --config RelWithDebInfo

$env:MAPSERVER_DLL_PATH="$ROOT_FOLDER/build/Release;$SDK_BIN"
$env:PROJ_LIB="$SDK_BIN/proj9/SHARE"

cmake --build . --target pythonmapscript-wheel --config Release

# make sdist for one version of Python as they are identical
if ("${{ matrix.python-version }}" -eq "3.10")
{
    cd "$ROOT_FOLDER/build/mapscript/python/Release"
    $params = "setup.py", "sdist"
    & $PYTHON_EXECUTABLE $params
    cd $ROOT_FOLDER
}