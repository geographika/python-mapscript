param (
    [string]$PYTHON_VERSION     
)

$root=(Get-Item .).FullName
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"

cd wheels
$fld="$root/build/src/mapscript/python/release/dist"
if (Test-Path -Path $fld) {
    cp -r "$fld/*" .
}

git add .
git commit -m "Add wheels"

cd "$root/src/$PYTHON_VERSION"
dir
$fld="$root/build/src/mapscript/python/CMakeFiles/pythonmapscript.dir"
if (Test-Path -Path $fld) {
    cp -r "$fld/*" .
}

$pyfile="$root/build/src/mapscript/python/mapscript.py"
if (Test-Path -Path $pyfile) {
    cp "$pyfile" .
}

git add .
git commit -m "Add source files"
git pull
git push --force