Build Issues
============


.. code-block:: ps1

      D:\MapServer\VS2022\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\wheel\bdist_wheel.py:100: RuntimeWarning: Config variable 'Py_DEBUG' is unset, Python ABI tag may be incorrect
        if get_flag("Py_DEBUG", hasattr(sys, "gettotalrefcount"), warn=(impl == "cp")):
      Installing the Python wheel and testing it in the virtual environment, then running tests and examples
      Looking in links: d:/MapServer/VS2022/build/mapscript/python/Release/dist
    CUSTOMBUILD : error : Could not find a version that satisfies the requirement mapscript (from versions: none) [D:\MapServer\VS2022\build\mapscript\python\pythonmapscript-wheel.vcxproj]
    CUSTOMBUILD : error : No matching distribution found for mapscript [D:\MapServer\VS2022\build\mapscript\python\pythonmapscript-wheel.vcxproj]


DUE TO BUILDING A x32 VERSION and not x64


.. code-block:: ps1

    D:\MapServer\VS2022\build\mapscript\python\Release\mapscriptvenv\Scripts\activate.ps1
    (mapscriptvenv) PS C:\Users\seth_> pip install D:\MapServer\VS2022\build\mapscript\python\Release\dist\mapscript-8.1.0-cp310-cp310-win32.whl
    ERROR: mapscript-8.1.0-cp310-cp310-win32.whl is not a supported wheel on this platform.


WINDOWS 32? Should be amd64 not win32

-----
Following issue fixed by adding:

$env:PATH="$SDK_BIN;" + $env:PATH

It is looking for D:\MapServer\VS2022\sdk\release-1930-x64\bin\protoc-gen-c.exe
Issue error:

  Checking Build System
  Generating renderers/mvt/vector_tile.pb-c.c, renderers/mvt/vector_tile.pb-c.h
  'protoc-gen-c' is not recognized as an internal or external command,
  operable program or batch file.
  --c_out: protoc-gen-c: Plugin failed with status code 1.



----

  Building Custom Rule D:/MapServer/VS2022/mapserver/CMakeLists.txt
  mapmssql2008.c
LINK : fatal error LNK1104: cannot open file 'C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64\odbc32.lib' [D:\MapServer\VS2022\build\msplugin_mssql2008.vcxproj]

Comment out the following?

# -DODBC_LIBRARY="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64\odbc32.lib" `

No change.

Had the following in the log:

-- Selecting Windows SDK version 10.0.22621.0 to target Windows 10.0.22631.
-- The C compiler identification is MSVC 19.39.33523.0
-- The CXX compiler identification is MSVC 19.39.33523.0

Deleted build folder and ran again with DODBC_LIBRARY commented out and worked.

Looking again and the Windows SDK had been updated from 10.0.19041.0 to 10.0.22621.0. Still don't need the following though:


-DODBC_LIBRARY="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\um\x64\odbc32.lib" `



----

Python MapScript build issue:

Windows fatal exception: code 0xc0000139

  Thread 0x0000a10c (most recent call first):
    File "<frozen importlib._bootstrap>", line 488 in _call_with_frames_removed
    File "<frozen importlib._bootstrap_external>", line 1316 in create_module
    File "<frozen importlib._bootstrap>", line 813 in module_from_spec
    File "<frozen importlib._bootstrap>", line 921 in _load_unlocked
    File "<frozen importlib._bootstrap>", line 1331 in _find_and_load_unlocked
    File "<frozen importlib._bootstrap>", line 1360 in _find_and_load
    File "<frozen importlib._bootstrap>", line 488 in _call_with_frames_removed
    File "<frozen importlib._bootstrap>", line 1415 in _handle_fromlist
    File "D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscriptvenv\Lib\site-packages\mapscript\mapscript.py", line 10 in <module>
    File "<frozen importlib._bootstrap>", line 488 in _call_with_frames_removed
    File "<frozen importlib._bootstrap_external>", line 1022 in exec_module
    File "<frozen importlib._bootstrap>", line 935 in _load_unlocked
    File "<frozen importlib._bootstrap>", line 1331 in _find_and_load_unlocked
    File "<frozen importlib._bootstrap>", line 1360 in _find_and_load

D:\MapServer\VS2022\sdk\release-1930-x64\bin\sqlite3.dll version is 3.37.2

C:\Python313\DLLs\sqlite3.dll version is 3.45.3


Copy D:\MapServer\VS2022\sdk\release-1930-x64\bin\sqlite3.dll to D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscriptvenv\Lib\site-packages\mapscript

Same as issue in https://github.com/MapServer/MapServer/issues/6101
See https://github.com/gisinternals/buildsystem/issues/156


Python 3.13.0 (tags/v3.13.0:60403a5, Oct  7 2024, 09:38:07) [MSC v.1941 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> import sqlite3
>>> sqlite3.sqlite_version
'3.45.3'

