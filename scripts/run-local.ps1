# local
# in later versions of VS2022 the bat file no longer is deployed by default?!
# need to manually install "MSVC v142 - VS 2019 C++ x64/x86 build tools (v14.29-16.11)"
# https://developercommunity.visualstudio.com/t/vcvarsallbat-fails-after-upgrade-from-2022-preview/1477538
# https://developercommunity.visualstudio.com/t/Provide-a-PowerShell-version-of-vcvarsal/10238319?q=vcvarsall.bat+missing&sort=relevance
#VCVARS = "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"

#cmd.exe /c "call `"$VCVARS`" && set > %temp%\vcvars.txt"
#Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
#	if ($_ -match "^(.*?)=(.*)$") {
#		Set-Content "env:\$($matches[1])" $matches[2]
#	}
#}

# IMPORTANT!!!
# run from within "Developer PowerShell for VS 2022"
# C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2022\Visual Studio Tools
# or run following from a command prompt (not PowerShell!)
# C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -noe -c "&{Import-Module """C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"""; Enter-VsDevShell 7683f8b4  -SkipAutomaticLocation -DevCmdArguments """-arch=x64 -host_arch=x64"""}"

# C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -noe -c "& {Import-Module 'C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\Microsoft.VisualStudio.DevShell.dll'; Enter-VsDevShell 7683f8b4 -SkipAutomaticLocation -DevCmdArguments '-arch=x64 -host_arch=x64'}"

# https://stackoverflow.com/questions/74674641/how-to-integrate-developer-command-prompt-for-vs-2022-as-terminal-in-vs-code

# following lines for local testing
# md D:\MapServer\VS2022
cd D:\MapServer\VS2022
#git clone https://github.com/geographika/mapserver.git --branch main --single-branch mapserver
$env:PATH="D:/Tools/cmake-3.22.3-windows-x86_64/bin;" + $env:PATH
# $env:PATH="C:/Tools/cmake-3.26.0-rc1-windows-x86_64;" + $env:PATH

$VS_VER="Visual Studio 17 2022"
$PYTHON_ROOT_DIR="C:/Python310"
$SDK="release-1930-x64"
# $SWIG_VER="4.1.0"
$SWIG_VER="4.2.1"

# following commands for both local and GHA
$ROOT_FOLDER = (Get-Location).ToString() -replace "\\","/"
$SDK_PREFIX="$ROOT_FOLDER/sdk/$SDK"
$SDK_INC="$SDK_PREFIX/include"
$SDK_LIB="$SDK_PREFIX/lib"
$SDK_BIN="$SDK_PREFIX/bin"
$SWIG_EXECUTABLE="$ROOT_FOLDER/sdk/swigwin-$SWIG_VER/swig.exe"
$REGEX_DIR="$ROOT_FOLDER/sdk/support/regex-0.12"
$PYTHON_EXECUTABLE="$PYTHON_ROOT_DIR/python.exe"

if (Test-Path -Path build) {
    "build folder already exists!"
} else {
	mkdir build
}

cd build
#$env:PATH="$SDK_BIN;" + $env:PATH
# TODO is the following used? it appears in the cmake output
$PROJECT_BINARY_DIR="$ROOT_FOLDER/build"
$SWIG_PYTHON_INTERPRETER_NO_DEBUG=1

$PYMAPSCRIPT_ANNOTATIONS=1

$BUILD_TYPE="RelWithDebInfo"

cmake -G "$VS_VER" -A "x64" "$ROOT_FOLDER/mapserver" `
-DCMAKE_BUILD_TYPE="$BUILD_TYPE" `
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
-DODBC_LIBRARY="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64\odbc32.lib" `
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
-DWITH_PYMAPSCRIPT_ANNOTATIONS=$PYMAPSCRIPT_ANNOTATIONS `
-DBUILD_FUZZER_REPRODUCER=ON

# cmake --build . --config Release
# cannot use DEBUG here - see https://github.com/gisinternals/buildsystem/issues/195
# can use RelWithDebInfo
cmake --build . --config $BUILD_TYPE


$env:MAPSERVER_DLL_PATH="$ROOT_FOLDER/build/RelWithDebInfo;$SDK_BIN"
$env:PATH="$ROOT_FOLDER/build/RelWithDebInfo;$env:PATH"

#$env:MAPSERVER_DLL_PATH="$ROOT_FOLDER/build/$BUILD_TYPE;$SDK_BIN"
# $env:PATH="$ROOT_FOLDER/build/$BUILD_TYPE;$env:PATH"


$env:PROJ_LIB="$SDK_BIN/proj9/SHARE"

# cmake --build . --target pythonmapscript-wheel --config Release
# RelWithDebInfo does not seem to work for pythonmapscript?
# it does work but may have to rebuild main mapserver.dll again
cmake --build . --target pythonmapscript-wheel --config RelWithDebInfo

# for fuzzers - following not working directly..
# but can build manually in Visual Studio
cd fuzzers
cmake --build . --config RelWithDebInfo