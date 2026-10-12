# AirCasting Android Client – AirBeam1 compatibility fork

> [!IMPORTANT]
> This is an **unofficial compatibility fork** of the original
> [HabitatMap/AirCastingAndroidClient](https://github.com/HabitatMap/AirCastingAndroidClient).
>
> The original AirCasting application and AirBeam support were developed by HabitatMap, Inc. This fork is based on `release-1.5.10` and contains a small set of compatibility changes intended to make the original first-generation AirBeam (AirBeam1) usable again on modern Android devices.
>
> See [CHANGES.md](CHANGES.md) for the modifications made in this fork.

## About the original project

AirCasting is a platform for gathering, visualizing and sharing environmental
data.

The original Android application and AirBeam integration were developed by
HabitatMap.

Original repository:

https://github.com/HabitatMap/AirCastingAndroidClient

AirCasting project:

http://aircasting.org

## Purpose of this fork

The original AirBeam communicates with Android through Bluetooth Classic /
RFCOMM SPP.

Recent versions of the AirCasting Android application no longer provide working
support for the first-generation AirBeam.

AirCasting `1.5.10` still contains the original AirBeam1 communication code, but
building and running that version on a modern Android device requires several
compatibility fixes because some of its dependencies and Android APIs are now
obsolete.

The goal of this fork is therefore:

- preserve the original AirBeam1 Bluetooth support;
- make AirCasting 1.5.10 buildable again;
- allow AirBeam1 measurements to be displayed on modern Android devices;
- restore the Graph view without depending on the obsolete Google Maps v1
  runtime.

This fork is **not intended to be a replacement for the current AirCasting
application**.

## Tested functionality

Tested successfully with:

- Original first-generation HabitatMap AirBeam / AirBeam1
- Xiaomi Mi 10T
- MIUI 14
- Bluetooth Classic / RFCOMM SPP

Measurements received successfully:

- `AirBeam-PM`
- `AirBeam-F`
- `AirBeam-RH`

Tested views:

- Dashboard
- Graph

## Build requirements

This project is based on an old Android build environment.

Known working setup:

- Java 8
- Gradle 4.10.1
- Android Gradle Plugin 3.3.2
- Android SDK Platform 26
- Android Build Tools 28.0.3

The Gradle wrapper included in the repository should be used.

Build with the included Gradle wrapper:

```powershell
.\gradlew.bat clean assembleDebug --no-daemon
```

## Legacy Google Maps API v1 dependency

AirCasting 1.5.10 depends on the obsolete Google Maps API v1 `maps.jar`.

That binary is **not redistributed in this repository**.

A helper PowerShell script is provided to retrieve the historical Google APIs
Android SDK package, verify its integrity and extract the required JAR.

From the repository root, run:
```powershell
.\scripts\fetch-google-maps-v1.ps1
```

The script creates:

`libs/maps-7_r1.jar`

Expected SHA-1:

`c49be8f6bab271911c80bee6d571bf107d29a369`

Expected size:

`22048 bytes`

The JAR is ignored by Git and is not redistributed in this repository.

