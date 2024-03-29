Test mapserv.exe
----------------

$ROOT_FOLDER="D:\MapServer\VS2022"
$env:PATH="$ROOT_FOLDER/build/RelWithDebInfo;$env:PATH"
$env:MAPSERVER_CONFIG_FILE="C:\MapServer\apps\mapserver.conf"
gcm mapserv
mapserv -v

Environment Settings
--------------------

Ensure RelWithDebInfo is selected.
mapserv Properties > Debugging > Environment

PROJ_LIB=D:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\SHARE
PATH=D:\MapServer\VS2022\sdk\release-1930-x64\bin;%PATH%
MAPSERVER_CONFIG_FILE=C:\MapServer\apps\mapserver-debug.conf


Command Arguments examples:

mapserver -v
mapserv -nh "QUERY_STRING=map=C:/projects/mapserver/msautotest/mssql/cluster_mssql.map&REQUEST=GetMetadata&LAYER=cities"

mapserv  -nh "QUERY_STRING=map=D:\test.map&REQUEST=GetMetadata&LAYER=test"

SET MAPSERVER_CONFIG_FILE=E:\MapServer\apps\mapserver.conf
mapserv -nh "QUERY_STRING=map=E:\test.map&REQUEST=GetMetadata&LAYER=test"

# move ogr_FileGDB.dll to D:\MapServer\VS2022\sdk\release-1930-x64\bin\gdal\plugins and
# update the mapserver.conf file
# GDAL_DRIVER_PATH "D:\MapServer\VS2022\sdk\release-1930-x64\bin\gdal\plugins"
mapserv -nh "QUERY_STRING=map=test.map&version=1.3.0&request=GetStyles&service=WMS&layers=test&styles=test"

http://localhost:3434/mapserver/?version=1.3.0&request=GetLegendGraphic&service=WMS&sld_version=1.1.0&layer=test&format=image%2Fpng&STYLE=Modifications

We can change the Project Working Directory from:
$(ProjectDir)
to another path, and it still runs

D:\GitHub\mappyfile-editor\mapfiles\benchmarking\
map2img -m FlatGeobuf.map -o FlatGeobuf-bbox.png -map_debug 2 -c 1 -e 211277 3646114 3069903 5906702
map2img -m Shapefile.map -o Shapefile.png -map_debug 2 -c 1 -e 211277 3646114 3069903 5906702

https://stackoverflow.com/questions/46259468/vs-error-when-debugging
Error while trying to to run project: Unable to start program [here follows the path of the executable] Input or output cannot be redirected 
because the specified file is invalid.

Command lines containing "<" or ">" can also cause this issue 



Testing OGC API
---------------

mapserv "PATH_INFO=/itasca/wms/" "QUERY_STRING=REQUEST=GetCapabilities&SERVICE=wms"


From a PowerShell prompt:

$ROOT_FOLDER="D:\MapServer\VS2022"
$env:PATH="$ROOT_FOLDER/build/RelWithDebInfo;$env:PATH"
$env:MAPSERVER_CONFIG_FILE="C:\MapServer\apps\mapserver.conf"

mapserv "PATH_INFO=/hello_world" QUERY_STRING="mode=map"

Debugging and Breakpoints
-------------------------

Disabled breakpoint and message: "The breakpoint will not currently be hit. No executable code of the debugger's target is associated with this line."

mapserver > (Project) Properties > C/C++ > Optimization > Disabled (/Od)

Triggers a new build but can now debug correctly. 

Debugging MapScript
-------------------

D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscriptvenv\Scripts\activate.ps1
# $env:PYTHONPATH = 'D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscript'
$env:MAPSERVER_DLL_PATH="D:\MapServer\VS2022\build\RelWithDebInfo;D:\MapServer\VS2022\sdk\release-1930-x64\bin;"
$env:PROJ_LIB="D:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\share"
python -c "import mapscript;print(mapscript.msGetVersion())"

Start an interactive Python

Attach to process - select both the root Python and the Python in the virtualenv
Debug code types - select Native and Python (Native)
import mapscript again. Might have to run line by line

Add debugger in MapServer C/C++ source files.
Make sure Python was installed with Advanced Options- "Download debugging symbols". Can modify Python from Add/Remove programs if required. 

"No Symbols have been loaded for this document"
Go to the Modules window (Debug > Windows > Modules - note this option is only visible once you have attached to the process) 
and check the mapserver.dll is pointing to the debug version of the DLL and not D:\MapServer\VS2022\sdk\release-1930-x64\bin\mapserver.dll
If mapserver.dll is not listed then the python.exe process is probably incorrect. In a venv you can select both parent and child python.exe

    import mapscript
    p = r"D:\MapServer\VS2022\build\src\mapscript\python\Release\mapscriptvenv\Lib\site-packages\mapscript\tests\data\test.map"
    m = mapscript.mapObj(p)
    #print(m.getLayer(0).convertToString())
    print(m.convertToString())

    print("Done!")

Save to script and run:

python D:\Temp\test.py

Or from an interactive Python - although this does not seem to trigger breakpoints?

import os; os.system(r"D:\Temp\test.py")
import os; os.system(r"D:\Data\ISRIC\test.py")

Check path of loaded module:

>>> mapscript._mapscript.__file__
'D:\\MapServer\\VS2022\\build\\src\\mapscript\\python\\RelWithDebInfo\\mapscriptvenv\\lib\\site-packages\\mapscript\\_mapscript.pyd'

Can even add breakpoints in D:\MapServer\VS2022\build\src\mapscript\python\CMakeFiles\pythonmapscript.dir\mapscriptPYTHON_wrap.c

If these say no symbols loaded check modules again and search for _mapscript.pyd. 
It should point to D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscriptvenv\Lib\site-packages\mapscript\_mapscript.pyd

There may be an error "Cannot find or open the PDB file"

May also need to rebuild MapServer and Python MapScript if still can't set breakpoints. 
Also try break points in different places as sometimes lines are optimised away.

from importlib import reload
reload(mapscript)
