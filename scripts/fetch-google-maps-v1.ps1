$ErrorActionPreference = "Stop"

$url = "https://dl-ssl.google.com/android/repository/google_apis-7_r01.zip"

$expectedZipSha1 = "2e7f91e0fe34fef7f58aeced973c6ae52361b5ac"
$expectedJarSha1 = "c49be8f6bab271911c80bee6d571bf107d29a369"

$root = Split-Path -Parent $PSScriptRoot
$libs = Join-Path $root "libs"
$temp = Join-Path $env:TEMP "aircasting-google-apis-7"

$zip = Join-Path $temp "google_apis-7_r01.zip"
$extract = Join-Path $temp "extracted"

Write-Host "Downloading legacy Google APIs package..."

Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $temp | Out-Null
New-Item -ItemType Directory -Force $libs | Out-Null

Invoke-WebRequest -Uri $url -OutFile $zip

$zipHash = (Get-FileHash $zip -Algorithm SHA1).Hash.ToLower()

if ($zipHash -ne $expectedZipSha1) {
    throw "ZIP SHA-1 mismatch. Expected $expectedZipSha1, got $zipHash"
}

Write-Host "ZIP verified."

Expand-Archive -Path $zip -DestinationPath $extract

$mapsJar = Get-ChildItem $extract -Recurse -Filter "maps.jar" |
    Select-Object -First 1

if (-not $mapsJar) {
    throw "maps.jar was not found in the Google APIs package."
}

$jarHash = (Get-FileHash $mapsJar.FullName -Algorithm SHA1).Hash.ToLower()

if ($jarHash -ne $expectedJarSha1) {
    throw "maps.jar SHA-1 mismatch. Expected $expectedJarSha1, got $jarHash"
}

Copy-Item $mapsJar.FullName (Join-Path $libs "maps-7_r1.jar") -Force

Write-Host ""
Write-Host "Google Maps API v1 compatibility JAR installed successfully:"
Write-Host (Join-Path $libs "maps-7_r1.jar")
Write-Host "SHA-1: $jarHash"