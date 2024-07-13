Test mapserv.exe
----------------

$ROOT_FOLDER="D:\MapServer\VS2022"
$env:PATH="$ROOT_FOLDER/build/RelWithDebInfo;$env:PATH"
$env:MAPSERVER_CONFIG_FILE="C:\MapServer\apps\mapserver.conf"
gcm mapserv
mapserv -v

Environment Settings
--------------------

mapserv Properties > Debugging > Environment

PROJ_LIB=D:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\SHARE
PATH=D:\MapServer\VS2022\sdk\release-1930-x64\bin;%PATH%
MAPSERVER_CONFIG_FILE=C:\MapServer\apps\mapserver.conf

PROJ_LIB=C:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\SHARE
PATH=C:\MapServer\VS2022\sdk\release-1930-x64\bin;%PATH%
MAPSERVER_CONFIG_FILE=C:\MapServer\apps\mapserver.conf

Command examples:

mapserv -nh "QUERY_STRING=map=C:/projects/mapserver/msautotest/mssql/cluster_mssql.map&REQUEST=GetMetadata&LAYER=cities"

mapserv  -nh "QUERY_STRING=map=D:\TFS\PublicLighting\Main\Python\plpy\mapfiles\generated\monaghan.map&REQUEST=GetMetadata&LAYER=LightUnit"

SET MAPSERVER_CONFIG_FILE=E:\MapServer\apps\mapserver.conf
mapserv -nh "QUERY_STRING=map=E:\MapServer\apps\publiclighting\monaghan.map&REQUEST=GetMetadata&LAYER=LightUnit"

Testing OGC API
---------------

mapserv "PATH_INFO=/itasca/wms/" "QUERY_STRING=REQUEST=GetCapabilities&SERVICE=wms" -conf "C:\MapServer\apps\mapserver.config"



