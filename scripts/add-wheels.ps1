$root=(Get-Item .).FullName
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"

cd wheels
$fld="$root/build/mapscript/python/release/dist"
if (Test-Path -Path $fld) {
cp -r "$fld/*" .
}
git add .
git commit -m "Add wheels"

cd "$root/src/${{ matrix.python-version }}"
dir
$fld="$root/build/mapscript/python/CMakeFiles/pythonmapscript.dir"
if (Test-Path -Path $fld) {
cp -r "$fld/*" .
}

$pyfile="$root/build/mapscript/python/mapscript.py"
if (Test-Path -Path $pyfile) {
cp "$pyfile" .
}

git add .
git commit -m "Add source files"
git pull
git push --force