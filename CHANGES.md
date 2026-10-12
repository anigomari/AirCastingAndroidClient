# AirBeam1 compatibility changes

## BASE

- Original repository: HabitatMap/AirCastingAndroidClient
- Base version: release-1.5.10
- License: GNU GPL v3

This file documents the changes made in this compatibility fork.

## BUILD SYSTEM CHANGES

The original project relied on repositories and dependencies that are no longer available
in their original form.

Changes:

- Added google().
- Added mavenCentral().
- Removed obsolete/dead Maven repository URLs.
- Preserved Gradle 4.10.1 and Android Gradle Plugin 3.3.2.

GOOGLE PLACES / VOLLEY

The original Google Places dependency expected a Volley artifact that could no longer be resolved.

Changed from:

implementation "com.google.android.libraries.places:places:1.1.0"

to:

implementation("com.google.android.libraries.places:places:1.1.0") {
    exclude group: 'com.android.volley', module: 'volley'
}

implementation 'com.android.volley:volley:1.2.1'

# GOOGLE MAPS API V1 DEPENDENCY

The original dependency:

compileOnly(group: 'com.google.android.maps', name: 'maps', version:'7_r1')

could no longer be resolved.

The project now uses:

implementation files('libs/maps-7_r1.jar')

The JAR itself is not included in this repository.

It can be obtained with:
```powershell
.\scripts\fetch-google-maps-v1.ps1
```

Expected SHA-1:

c49be8f6bab271911c80bee6d571bf107d29a369

## LEGACY GOOGLE MAPS RESOURCE REFERENCES

The original project expects Google Maps API key resources during resource linking.

These placeholder values were added:

<string name="com.google.android.geo.API_KEY">DUMMY_KEY_FOR_AIRBEAM1</string>
<string name="com.google.android.geo.MAPS_KEY">DUMMY_KEY_FOR_AIRBEAM1</string>

These are intentionally not valid API keys.

## GRAPH VIEW COMPATIBILITY

The original activity hierarchy caused the Graph screen to inherit indirectly from the obsolete
Google Maps API v1 MapActivity.

Original hierarchy:

GraphActivity
  -> AirCastingActivity
  -> AirCastingBaseActivity
  -> RoboMapActivityWithProgress
  -> RoboMapActivity
  -> com.google.android.maps.MapActivity

On modern Android, instantiating MapActivity fails because the Google Maps v1 runtime
is no longer available.

AirCastingBaseActivity was changed to inherit from:

RoboActivityWithProgress

instead of:

RoboMapActivityWithProgress

The obsolete isRouteDisplayed() override was also removed.

This allows the Graph screen to work without instantiating the legacy Google Maps activity.

## AIRBEAM1 SUPPORT

The original Bluetooth Classic / RFCOMM SPP implementation was preserved.

Successfully tested:

- Bluetooth pairing
- Bluetooth connection
- Real-time AirBeam1 measurements
- Dashboard
- Graph

Channels tested:

- AirBeam-PM
- AirBeam-F
- AirBeam-RH

## KNOWN LIMITATION

The original Map view is not restored and should be considered unsupported.
