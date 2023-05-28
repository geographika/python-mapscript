Python MapScript
================

This repository is used to build Python MapScript Wheels for Windows.

See `Wheels repository </blob/main/wheels/ReadMe.rst>`_ for details.

Adding Wheels to the Repo
-------------------------

Trigger a new build on GitHub Actions with the following in the commit message: `upload-wheels`

Testing a Wheel
---------------

The example below tests Python 3.11 with a PowerShell script:

..code-block:: ps1

    $PYTHON_VER="Python311"
    $PYTHON_ROOT="C:/$PYTHON_VER"
    $WHEEL="D:\GitHub\python-mapscript\wheels\mapscript-8.0.1-cp311-cp311-win_amd64.whl"
    $VENV="C:\VirtualEnvs\mapscript-$PYTHON_VER"

    .$PYTHON_ROOT\Scripts\pip install virtualenv
    .$PYTHON_ROOT\Scripts\virtualenv $VENV
    .$VENV\Scripts\activate.ps1

    pip install $WHEEL
    $env:MAPSERVER_DLL_PATH="D:\MapServer\VS2022\build\Release;D:\MapServer\VS2022\sdk\release-1930-x64\bin"
    python -c "import mapscript;print(mapscript.msGetVersion())"
