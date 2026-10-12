# Google Maps API v1 dependency

AirCasting 1.5.10 requires the legacy Google Maps API v1 `maps.jar`
to compile and run this compatibility fork.

The binary is part of the historical Google APIs Android SDK add-on
and is therefore not redistributed in this repository.

Run:

.\scripts\fetch-google-maps-v1.ps1

The script downloads the historical Google SDK package, verifies it
and extracts the required file as:
libs/maps-7_r1.jar
Expected JAR SHA-1:
c49be8f6bab271911c80bee6d571bf107d29a369