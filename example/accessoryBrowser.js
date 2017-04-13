/**
 * Accessory Browser
 * Searches for accessories that are already added to your home.
 **/
 
var HomeKit = require('ti.homekit');
var AccessoryBrowser = HomeKit.createAccessoryBrowser();

AccessoryBrowser.addEventListener('didFindNewAccessory', function(e) {
    Ti.API.info('didFindNewAccessory', e.accessory);
    Ti.API.info('All accessories', AccessoryBrowser.getDiscoveredAccessories());
});

var win = Ti.UI.createWindow({
    backgroundColor: '#fff',
    layout: 'vertical'
});

var btn1 = Ti.UI.createButton({
    title: 'Start searching for devices',
    top: 40
});

btn1.addEventListener('click', function() {
    Ti.API.info('Searching for new devices ...');
    AccessoryBrowser.startSearchingForNewAccessories();
});

var btn2 = Ti.UI.createButton({
    title: 'Stop searching for devices',
    top: 80
});

btn2.addEventListener('click', function() {
    Ti.API.info('Stop searching for new devices ...');
    AccessoryBrowser.stopSearchingForNewAccessories();
});

win.add(btn1);
win.add(btn2);
win.open();
