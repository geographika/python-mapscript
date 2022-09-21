# python-mapscript


CUSTOMBUILD : error : module or package not found: mapscript.tests (missing __init__.py?) [D:\a\python-mapscript\python-mapscript\build\mapscript\python\pythonmapscript-wheel.vcxproj]

Use SWIG from nuget?
#nuget install swigwintools -Version 4.0.0 -OutputDirectory sdk/swig


## PowerShell

```yaml

      - name: Configure MapServer with PowerShell
        if: ${{ false }}
        shell: powershell
        run: |
          # https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt
          pushd "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools"
          cmd /c "VsDevCmd.bat&set" |
          foreach {
            if ($_ -match "=") {
              $v = $_.split("=", 2); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])" 
            }
          }
          popd
          echo $PYTHONPATH
          $SDK="${{ env.SDK }}" # $SDK="release-1930-x64"
          $ROOT_FOLDER=(Get-Location).path -replace "\\","/"
          $SDK_PREFIX="$ROOT_FOLDER/sdk/$SDK"
          $SDK_INC="$ROOT_FOLDER/sdk/$SDK/include"
          $SDK_LIB="$ROOT_FOLDER/sdk/$SDK/lib"
          $SDK_BIN="$ROOT_FOLDER/sdk/$SDK/bin"
          $SWIG_EXECUTABLE="$ROOT_FOLDER/sdk/swigwin-4.0.2/swig.exe"
          #$SWIG_DIR="$ROOT_FOLDER/sdk/swig"
          $REGEX_DIR="$ROOT_FOLDER/sdk/support/regex-0.12"
          #$PYTHON_ROOT_DIR=
          mkdir build
          cd build
          $env:Path = "$ROOT_FOLDER/build/Release;$SDK_BIN;" + $env:Path
          
          # $env:Path = "$ROOT_FOLDER/build/Release;D:\Tools\cmake-3.19.4-win64-x64\bin;$SDK_BIN;" + $env:Path # local only
          $PROJECT_BINARY_DIR="$ROOT_FOLDER/build"
          cmake -G "Visual Studio 17 2022" -A "x64" .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$SDK_PREFIX" -DPNG_LIBRARY="$SDK_LIB/libpng16_static.lib" -DHARFBUZZ_INCLUDE_DIR="$SDK_INC/harfbuzz" -DICONV_DLL="$SDK_BIN/iconv.dll" -DFRIBIDI_INCLUDE_DIR="$SDK_INC/fribidi" -DMS_EXTERNAL_LIBS="$SDK_LIB/harfbuzz.lib;$SDK_LIB/uriparser.lib" -DSVG_LIBRARY="$SDK_LIB/libsvg.lib" -DSVGCAIRO_LIBRARY="$SDK_LIB/libsvg-cairo.lib" -DREGEX_DIR="$REGEX_DIR" -DSWIG_EXECUTABLE="$SWIG_EXECUTABLE" -DPROTOBUFC_COMPILER="$SDK_BIN/protoc.exe" -DPROTOBUFC_LIBRARY="$SDK_LIB/protobuf-c.lib" -DPROTOBUFC_INCLUDE_DIR="$SDK_INC/protobuf-c" -DWITH_CURL=1 -DWITH_KML=1 -DWITH_SVGCAIRO=1 -DWITH_THREAD_SAFETY=1 -DWITH_SOS=1 -DWITH_CLIENT_WFS=1 -DWITH_CLIENT_WMS=1-DWITH_CSHARP=1 -DWITH_PROTOBUFC=1 -DWITH_POSTGIS=0 -DWITH_PERL=0 -DWITH_MSSQL2008=0 -DWITH_PYTHON=1 -DWITH_PHPNG=0 -DWITH_HARFBUZZ=1 -DPROJ_INCLUDE_DIR="$SDK_INC/proj7"
          
          cmake --build . --config Release
          $env:MAPSERVER_DLL_PATH="$ROOT_FOLDER/build/Release;$SDK_BIN"
          $env:PROJ_LIB="$SDK_BIN/proj7/SHARE"
          cmake --build . --target pythonmapscript-wheel --config Release
          
          
Debug Builds
------------


https://stackoverflow.com/a/29295896/179520

harfbuzz.lib(harfbuzz.obj) : error LNK2038: mismatch detected for '_ITERATOR_DEBUG_LEVEL': value '0' doesn't match value '2' in mapwms.obj [D:\MapServer\VS2022\build\mapserver.vcxproj]

Add _ALLOW_ITERATOR_DEBUG_LEVEL_MISMATCH under C/C++ >> Preprocessor >> PreprocessorDefinitions
To the mapserver project in VS (not mapserv)

harfbuzz.lib(harfbuzz.obj) : error LNK2038: mismatch detected for 'RuntimeLibrary': value 'MD_DynamicRelease' doesn't match value 'MDd_DynamicDebug' in mapwms.obj [D:\MapServer\VS2022\build\mapserver.vcxproj]