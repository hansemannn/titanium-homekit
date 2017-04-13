/**
 * Home Creator
 * Creates a new home specified by name and makes it the primary home.
 *
 * Example log-flow:
 * 2017-04-13 16:15:30.998231+0200 test_homekit[436:31295] [INFO] Adding new home ...
 * 2017-04-13 16:15:31.142577+0200 test_homekit[436:31295] [INFO] Home successfully added!
 * 2017-04-13 16:15:31.142670+0200 test_homekit[436:31295] [INFO] Making home primary home ...
 * 2017-04-13 16:15:31.168587+0200 test_homekit[436:31295] [DEBUG] Event: Did update homes!
 * 2017-04-13 16:15:31.191480+0200 test_homekit[436:31295] [INFO] Home successfully made primary!
 *
 **/

var HomeKit = require('ti.homekit');

HomeKit.addEventListener('didAddHome', function(e) {
    Ti.API.debug('Event: Did add home!');
});

HomeKit.addEventListener('didRemoveHome', function(e) {
    Ti.API.debug('Event: Did remove home!');
});

HomeKit.addEventListener('didUpdateHomes', function(e) {
    Ti.API.debug('Event: Did update homes!');
});

HomeKit.addEventListener('didUpdatePrimaryHome', function(e) {
    Ti.API.debug('Event: Did update primary home!');
});

var win = Ti.UI.createWindow({
    backgroundColor: '#fff'
});

var btn1 = Ti.UI.createButton({
    title: 'Add Home'
});

btn1.addEventListener('click', function() {
    Ti.API.info('Adding new home ...');
    HomeKit.addHome('Titanium', function(e) {
        if (!e.success) {
            alert('Cannot add home! Error: ' + e.error);
            return;
        }
        
        var myHome = e.home;
        
        Ti.API.info('Home successfully added!');
        Ti.API.info('Making home primary home ...');
        
        HomeKit.updatePrimaryHome(myHome, function(_e) {
            if (!_e.success) {
                alert('Cannot make home with name ' + myHome.name + ' primary! Error: ' + e.error);
                return;
            }
 
            Ti.API.info('Home successfully made primary!');
        });
    });
});

win.add(btn1);
win.open();
