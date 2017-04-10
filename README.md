# iOS HomeKit in Appcelerator Titanium
   
## Summary
Ti.HomeKit is an open-source project to support the HomeKit API in Appcelerator's Titanium. 
Requirements
---------------
  - Titanium Mobile SDK 5.5.1.GA or later
  - iOS 7.1 or later
  - Xcode 7.3 or later

## Download + Setup

### Download
  * [Stable release](https://github.com/hansemannn/titanium-homekit/releases)
  * [![gitTio](http://hans-knoechel.de/shields/shield-gittio.svg)](http://gitt.io/component/titanium-homekit)

### Setup
Unpack the module and place it inside the `modules/iphone/` folder of your project.
Edit the modules section of your `tiapp.xml` file to include this module:
```xml
<modules>
    <module platform="iphone">ti.homekit</module>
</modules>
```

## API

### Top-Module

#### Methods
- [x] `addHome`
- [x] `removeHome`
- [x] `updatePrimaryHome`
- [x] `createAccessoryBrowser`

#### Events
- [x] `didAddHome`
- [x] `didRemoveHome`
- [x] `didUpdateHomes`
- [x] `didUpdatePrimaryHome`

### AccessoryBrowser

#### Methods
- [x] `startSearchingForNewAccessories`
- [x] `stopSearchingForNewAccessories`

#### Properties
- [x] `discoveredAccessories`

#### Events
- [x] `didFindNewAccessory`
- [x] `didRemoveNewAccessory`

## Author
Hans Knoechel ([@hansemannnn](https://twitter.com/hansemannnn) / [Web](http://hans-knoechel.de))

## License
Apache 2.0

## Contributing
Code contributions are greatly appreciated, please submit a new [pull request](https://github.com/hansemannn/titanium-homekit/pull/new/master)!
