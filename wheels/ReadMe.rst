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