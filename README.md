# 🏡 iOS HomeKit in Appcelerator Titanium</h1></td>
Ti.HomeKit is an open-source project to support the HomeKit API in Appcelerator's Titanium. 

## Requirements
  - Titanium Mobile SDK 5.5.1.GA+
  - iOS 8.0+
  - Xcode 7.3+

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

Ensure that the HomeKit- and Wireless Configuration capabilities are added to your entitlements (example):
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.developer.homekit</key>
    <true/>
    <key>com.apple.external-accessory.wireless-configuration</key>
    <true/>
</dict>
</plist>
```
Also ensure that the HomeKit- and location usage permissions are set in the tiapp.xml
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>HMCatalog needs your location to search for relevant places in your area.</string>
<key>NSHomeKitUsageDescription</key>
<string>HMCatalog needs access top your HomeKit devices.</string>
```

## Supported API's

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

### Home

#### Properties
- [x] `uniqueIdentifier`
- [x] `name`

#### Methods
- [x] `updateName`
- [x] `addAccessory`
- [x] `removeAccessory`
- [x] `assignAccessory`
- [x] `addAndSetupAccessories`
- [x] `manageUsers`
- [x] `addUser`
- [x] `removeUser`
- [x] `currentUser`
- [x] `homeAccessControlForUser`
- [x] `addRoom`
- [x] `removeRoom`

#### Events
- [x] `homeDidUpdateName`
- [x] `didAddAccessory`
- [x] `didRemoveAccessory`
- [x] `didAddUser`
- [x] `didRemoveUser`
- [x] `didAddRoom`
- [x] `didUpdateRoom`
- [x] `didUpdateNameForRoom`
- [x] `didRemoveRoom`
- [x] `didAddZone`
- [x] `didUpdateNameForZone`
- [x] `didRemoveZone`
- [x] `didAddRoomToZone`
- [x] `didRemoveRoomFromZone`
- [x] `didAddServiceGroup`
- [x] `didUpdateNameForServiceGroup`
- [x] `didRemoveServiceGroup`
- [x] `didAddServiceToServiceGroup`
- [x] `didRemoveServiceFromServiceGroup`
- [x] `didAddActionSet`
- [x] `didUpdateNameForActionSet`
- [x] `didUpdateActionsForActionSet`
- [x] `didAddActionSet`
- [x] `didAddTrigger`
- [x] `didUpdateTrigger`
- [x] `didUpdateNameForTrigger`
- [x] `didRemoveTrigger`
- [x] `didUnblockAccessory`
- [x] `didEncounterErrorForAccessory`

### AccessoryBrowser

#### Methods
- [x] `startSearchingForNewAccessories`
- [x] `stopSearchingForNewAccessories`

#### Properties
- [x] `discoveredAccessories`

#### Events
- [x] `didFindNewAccessory`
- [x] `didRemoveNewAccessory`

### Accessory

#### Properties
- [x] `uniqueIdentifier`
- [x] `name`
- [x] `isReachable`
- [x] `isBridged`
- [x] `isBlocked`
- [x] `room`
- [x] `services`

#### Events
- [x] `didUpdateName`
- [x] `didUpdateNameForService`
- [x] `didUpdateAssociatedServiceTypeForService`
- [x] `didUpdateServices`
- [x] `didUpdateReachability`
- [x] `didUpdateValueForCharacteristic`

### Service

#### Properties
- [x] `uniqueIdentifier`
- [x] `name`
- [x] `serviceType`
- [x] `localizedDescription`

### Room

#### Properties
- [x] `uniqueIdentifier`
- [x] `name`
- [x] `accessories`

### User

#### Properties
- [x] `uniqueIdentifier`
- [x] `name`

## Author
Hans Knoechel ([@hansemannnn](https://twitter.com/hansemannnn) / [Web](http://hans-knoechel.de))

## License
Apache 2.0

## Contributing
Code contributions are greatly appreciated, please submit a new [pull request](https://github.com/hansemannn/titanium-homekit/pull/new/master)!
