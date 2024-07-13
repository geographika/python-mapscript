"""
python D:\GitHub\python-mapscript\tests\test2.py

"""
import mapscript

# D:\MapServer\VS2022\mapserver\msautotest\gdal\classtest1.map
map = mapscript.mapObj(r"D:\MapServer\VS2022\mapserver\msautotest\gdal\classtest1.map")
layer = map.getLayer(0)

pnt = mapscript.pointObj()
pnt.x = 88.5
pnt.y = 7.5

# map = mapscript.mapObj(r"D:\MapServer\VS2022\mapserver\msautotest\gdal\tileindex.map")
# layer = map.getLayer(0)

# pnt = mapscript.pointObj()
# pnt.x = 35.5
# pnt.y = 25.5


layer.queryByPoint(map, pnt, mapscript.MS_SINGLE, 10.0)

###############################################################################
# Scan results.  This query is for a transparent pixel within the "x" of
# the cubewerx logo.  In the future the raster query may well stop returning
# "offsite" pixels and we will need to update this test.

#########################################################################
# Check result count.
layer.open()
count = 0
for i in range(1000):
    result = layer.getResult(i)
    if result is None:
        break

    count = count + 1
    
print(count)

result = layer.getResult(0)
s = layer.getShape(result)
print(s)
assert count == 1
