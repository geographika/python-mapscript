Wheels Repository
=================

3.10 failing - see https://github.com/geographika/python-mapscript/runs/5514334505?check_suite_focus=true


3.6 - strange errors:

https://github.com/geographika/python-mapscript/runs/5514601765?check_suite_focus=true




          git fetch
          git rebase origin/main
          
Used to avoid locking the repos e.g. https://github.com/geographika/python-mapscript/runs/5514794165?check_suite_focus=true

 ! [remote rejected] HEAD -> main (cannot lock ref 'refs/heads/main': is at f0e19aaeeb5146da2c33771d3be9e7ba2c62ecd0 but expected af5536c25df656a02807b5a7f4ee56df76accc8b)
 

Sqlite
------

CUSTOMBUILD : error : module or package not found: mapscript.tests (missing __init__.py?) [D:\MapServer\release-1928-x64-dev\build\mapscript\python\pythonma
pscript-wheel.vcxproj]

Issue due to SQLlite DLL

SWIG
----

D:/a/python-mapscript/python-mapscript/sdk/swigwin-4.1.0/Lib\swigwarnings.swg(39): error : Unable to find 'swigwarn.swg' [D:\a\python-mapscript\python-mapscript\build\mapscript\python\_pythonmapscript.vcxproj]

After building SWIG make sure the contents of C:\swig\install2\share\swig\4.1.0 is copied to D:\Tools\swigwin-4.1.0\Lib

swigwarn.swg is only difference?


Python 3.6

Broken. Builds ok but fails on test suite:

https://github.com/geographika/python-mapscript/runs/5534457813?check_suite_focus=true

Windows fatal exception: code 0xc0000139
  
  Thread 0x000011a0 (most recent call first):
    File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_removed
    File "<frozen importlib._bootstrap_external>", line 922 in create_module
    File "<frozen importlib._bootstrap>", line 571 in module_from_spec
    File "<frozen importlib._bootstrap>", line 658 in _load_unlocked
    File "<frozen importlib._bootstrap>", line 955 in _find_and_load_unlocked
    File "<frozen importlib._bootstrap>", line 971 in _find_and_load
    File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_removed
    File "<frozen importlib._bootstrap>", line 1023 in _handle_fromlist
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\mapscript\mapscript.py", line 13 in <module>
    File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_removed
    File "<frozen importlib._bootstrap_external>", line 678 in exec_module
    File "<frozen importlib._bootstrap>", line 665 in _load_unlocked
    File "<frozen importlib._bootstrap>", line 955 in _find_and_load_unlocked
    File "<frozen importlib._bootstrap>", line 971 in _find_and_load
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\mapscript\__init__.py", line 32 in <module>
    File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_removed
    File "<frozen importlib._bootstrap_external>", line 678 in exec_module
    File "<frozen importlib._bootstrap>", line 665 in _load_unlocked
    File "<frozen importlib._bootstrap>", line 955 in _find_and_load_unlocked
    File "<frozen importlib._bootstrap>", line 971 in _find_and_load
    File "C:\hostedtoolcache\windows\Python\3.6.8\x64\lib\importlib\util.py", line 88 in find_spec
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 835 in search_pypath
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 879 in resolve_collection_argument
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 638 in perform_collect
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 332 in pytest_collection
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_callers.py", line 39 in _multicall
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_manager.py", line 80 in _hookexec
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_hooks.py", line 265 in __call__
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 321 in _main
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 268 in wrap_session
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\main.py", line 315 in pytest_cmdline_main
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_callers.py", line 39 in _multicall
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_manager.py", line 80 in _hookexec
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pluggy\_hooks.py", line 265 in __call__
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\config\__init__.py", line 166 in main
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\_pytest\config\__init__.py", line 188 in console_main
    File "D:\a\python-mapscript\python-mapscript\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\pytest\__main__.py", line 5 in <module>
    File "C:\hostedtoolcache\windows\Python\3.6.8\x64\lib\runpy.py", line 85 in _run_code
    File "C:\hostedtoolcache\windows\Python\3.6.8\x64\lib\runpy.py", line 193 in _run_module_as_main
    
    
Projection Errors


proj_create: Cannot find proj.db
proj_create: no database context specified
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "C:\VirtualEnvs\hymo\lib\site-packages\mapscript\mapscript.py", line 1433, in __init__
    _mapscript.mapObj_swiginit(self, _mapscript.new_mapObj(*args))
_mapscript.MapServerError: msProcessProjection(): Projection library error. proj error "no arguments in initialization list" for "init=epsg:2157"

Check if PROJ_LIB is set in the Mapfile to a relative path


SWIG Errors


 -features python:annotations=c
 
In CMakeLists this should not be in quotes or get 

CUSTOMBUILD : swig error : Unrecognized option -features python:annotations=c [D:\MapServer\VS2022\build\mapscript\pyth
on\_pythonmapscript.vcxproj]

Look for swig.exe command in _pythonmapscript.vcxproj (in Notepad++)

Testing Python MapScript
------------------------

D:\MapServer\VS2022\build\mapscript\python\Release\mapscriptvenv\Scripts\activate

REM SET PATH=D:\MapServer\VS2022\build\Release;D:\MapServer\VS2022\sdk\release-1930-x64\bin;%PATH%

set MAPSERVER_DLL_PATH=D:\MapServer\VS2022\build\Release;D:\MapServer\VS2022\sdk\release-1930-x64\bin;

python -c "import mapscript;print(mapscript.msGetVersion())"



C:\Python310\scripts\virtualenv C:\VirtualEnvs\mapscript8-test
C:\VirtualEnvs\mapscript8-test\Scripts\activate
pip install D:\MapServer\VS2022\build\mapscript\python\Release\dist\mapscript-8.1.0-cp310-cp310-win_amd64.whl






