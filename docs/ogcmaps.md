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


