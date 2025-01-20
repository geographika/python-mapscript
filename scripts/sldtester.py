"""
D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscriptvenv\Scripts\activate.ps1
# $env:PYTHONPATH = 'D:\MapServer\VS2022\build\src\mapscript\python\RelWithDebInfo\mapscript'
$env:MAPSERVER_DLL_PATH="D:\MapServer\VS2022\build\RelWithDebInfo;D:\MapServer\VS2022\sdk\release-1930-x64\bin;"
$env:PROJ_DATA="D:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\share"
python -c "import mapscript;print(mapscript.msGetVersion())"

python D:\GitHub\python-mapscript\scripts\sldtester.py
"""

import mapscript
import os


def test1():
    output_folder = r"D:\Temp\sldtest"
    p = os.path.join(output_folder, "test.map")
    m = mapscript.mapObj(p)
    # print(m.getLayer(0).convertToString())
    print(m.convertToString())

    output_file = os.path.join(output_folder, "output2.map")
    with open(output_file, "w") as f:
        f.write(m.convertToString())


def test2():
    path = r"D:\MapServer\VS2022\mapserver\msautotest\sld"
    os.chdir(path)

    p = os.path.join(path, "sld_styleitem_file.map")
    m = mapscript.mapObj(p)
    lyr = m.getLayerByName("rgb")
    # print(m.getLayer(0).convertToString())
    print(lyr.convertToString())


def test3():
    path = r"D:\MapServer\VS2022\mapserver\msautotest\sld"
    os.chdir(path)

    p = os.path.join(path, "test.map")
    m = mapscript.mapObj(p)
    lyr = m.getLayerByName("main")
    # stylelayer is matching NamedLayer
    stylelayer = "main"
    sld_file = r"D:\Dropbox\Inetpub\wwwroot\sld\danube2.xml"
    with open(sld_file) as f:
        sld = f.read()        
    # sld_file = r"D:\MapServer\VS2022\mapserver\msautotest\sld\data\danube.sld"
    lyr.applySLD(sld, stylelayer)
    url = "http://localhost/sld/danube2.xml"
    #lyr.applySLDURL(url, "main")
    # print(lyr.convertToString())
    print(m.convertToString())


test3()
