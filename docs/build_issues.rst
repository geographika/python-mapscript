Build Issues
============


..code-block:: ps1

      D:\MapServer\VS2022\build\mapscript\python\Release\mapscriptvenv\lib\site-packages\wheel\bdist_wheel.py:100: RuntimeWarning: Config variable 'Py_DEBUG' is unset, Python ABI tag may be incorrect
        if get_flag("Py_DEBUG", hasattr(sys, "gettotalrefcount"), warn=(impl == "cp")):
      Installing the Python wheel and testing it in the virtual environment, then running tests and examples
      Looking in links: d:/MapServer/VS2022/build/mapscript/python/Release/dist
    CUSTOMBUILD : error : Could not find a version that satisfies the requirement mapscript (from versions: none) [D:\MapServer\VS2022\build\mapscript\python\pythonmapscript-wheel.vcxproj]
    CUSTOMBUILD : error : No matching distribution found for mapscript [D:\MapServer\VS2022\build\mapscript\python\pythonmapscript-wheel.vcxproj]


DUE TO BUILDING A x32 VERSION and not x64


..code-block:: ps1

    D:\MapServer\VS2022\build\mapscript\python\Release\mapscriptvenv\Scripts\activate.ps1
    (mapscriptvenv) PS C:\Users\seth_> pip install D:\MapServer\VS2022\build\mapscript\python\Release\dist\mapscript-8.1.0-cp310-cp310-win32.whl
    ERROR: mapscript-8.1.0-cp310-cp310-win32.whl is not a supported wheel on this platform.


WINDOWS 32? Should be amd64 not win32