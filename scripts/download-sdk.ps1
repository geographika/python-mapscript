param (
    [string]$SDK,
    [string]$SWIG_VER
)

# http://download.gisinternals.com/sdk/downloads/release-1930-x64-dev.zip

$SDK_ZIP="$SDK-dev.zip"
$SDK_URL="http://download.gisinternals.com/sdk/downloads/$SDK_ZIP"
$ProgressPreference = 'SilentlyContinue' # remove console output and greatly speeds-up downloading and unzipping
Invoke-WebRequest -Uri $SDK_URL -OutFile $SDK_ZIP
Expand-Archive $SDK_ZIP -DestinationPath sdk

$SWIG_ZIP="swigwin-$SWIG_VER.zip"
Expand-Archive $SWIG_ZIP -DestinationPath "sdk"
