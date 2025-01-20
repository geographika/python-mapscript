mapserv "PATH_INFO=/itasca/wms/" "QUERY_STRING=REQUEST=GetCapabilities&SERVICE=wms" -conf "C:\MapServer\apps\mapserver.config"

mapserv "PATH_INFO=/itasca/ogcapi/" "QUERY_STRING=?f=json" -conf "C:\MapServer\apps\mapserver.config"


https://demo.mapserver.org/cgi-bin/mapserv/localdemo/ogcapi?f=json

mapserv "QUERY_STRING=?f=json" PATH_INFO=/itasca/ogcapi/" 


Command arguments: mapserv "QUERY_STRING=f=json" "PATH_INFO=/itasca/ogcapi/conformance"

Command arguments: mapserv "QUERY_STRING=f=png&width=600&height=900" "PATH_INFO=/itasca/ogcapi/collections/ruins/map"

https://demo.pygeoapi.io/stable/conformance?f=html

http://www.opengis.net/spec/ogcapi-maps-1/1.0/conf/core


Not found: http://www.opengis.net/spec/ogcapi-maps-1/1.0/conf/core
http://www.opengis.net/spec/ogcapi-features-1/1.0/conf/core


https://demo.pygeoapi.io/stable/collections/mapserver_world_map
https://demo.pygeoapi.io/stable/collections/mapserver_world_map/map?f=png


https://ogcapi.ogc.org/maps/

https://ogcapi.ogc.org/maps/overview.html

https://demo.pygeoapi.io/stable/collections/mapserver_world_map/map?f=png&width=600&height=900

https://github.com/geopython/pygeoapi/blob/0169e433297f6e5a6c630e3937e3d5b43515d1cc/pygeoapi/provider/wms_facade.py#L50


http://localhost/mapserver/?map=C:\MapServer\apps\mapview-demo\example.map&request=getcapabilities&service=wms


No jpg format
https://demo.pygeoapi.io/stable/collections/mapserver_world_map/map?f=jpg&width=600&height=900
# following throws an error
https://demo.pygeoapi.io/stable/collections/mapserver_world_map/map?f=jpeg&width=600&height=900


https://demo.pygeoapi.io/stable/collections/mapserver_world_map?f=json

        {
            "type":"image/png",
            "rel":"http://www.opengis.net/def/rel/ogc/1.0/map",
            "title":"Map as png",
            "href":"https://demo.pygeoapi.io/stable/collections/mapserver_world_map/map?f=png"
        }
        


Needed to update handler for IIS:

        <handlers>
            <add name="MapServerFastCgi" path="/*" verb="*" type="" modules="FastCgiModule" scriptProcessor="C:\MapServer\bin\mapserv.exe" resourceType="Unspecified" requireAccess="Script" allowPathInfo="true" preCondition="" />
        </handlers>


http://localhost/mapserver/itasca/ogcapi/collections/ruins/map?f=png&width=600&height=900        

http://localhost/mapserver/itasca/ogcapi/collections/ruins/items?f=json&limit=10&offset=0



## Testing

# RUN_PARMS: ogcapi_collections_tanzania1_items.json.txt [MAPSERV] "PATH_INFO=/[MAPFILE]/ogcapi/collections/tanzania1/items" "QUERY_STRING=f=json" > [RESULT_DEMIME]
mapserv "PATH_INFO=/D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi_world.map/ogcapi/collections/tanzania1/items" "QUERY_STRING=f=json"

# RUN_PARMS: ogcapi_collections_mn_counties.json [MAPSERV] "PATH_INFO=/[MAPFILE]/ogcapi/collections/mn_counties" "QUERY_STRING=f=json" > [RESULT_DEMIME]
mapserv "PATH_INFO=/D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi.map/ogcapi/collections/mn_counties" "QUERY_STRING=f=json"

D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi_world.map


MAPSERVER_CONFIG_FILE=../etc/mapserv.conf

mapserv "QUERY_STRING=f=png&width=600&height=900" "PATH_INFO=/itasca/ogcapi/collections/ruins/map"


mapserv "PATH_INFO=/D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi_maps.map/ogcapi/collections/cities" "QUERY_STRING=f=json"

mapserv -nh "PATH_INFO=/D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi_maps.map/ogcapi/collections/cities/map" "QUERY_STRING=f=png"  > D:\Temp\ogcmap.png

# equivalent WMS request
mapserv -nh "PATH_INFO=/D:\MapServer\VS2022\mapserver\msautotest\api\ogcapi_maps.map/" "QUERY_STRING=service=WMS&request=GetMap&version=1.3.0&LAYERS=cities&STYLES=&crs=EPSG:3857&BBOX=-20037508.34,-20048966.1,20037508.34,20048966.1&FORMAT=png&HEIGHT=300&WIDTH=300" > D:\Temp\map.png