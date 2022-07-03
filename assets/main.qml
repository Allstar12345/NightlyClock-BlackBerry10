import bb.cascades 1.2
import timer 1.0
import bb.multimedia 1.2
import bb.platform 1.2
import bb.device 1.2
import bb.system 1.2
import Flashlight 1.0
import AppSettings 1.0
import QtQuick 1.0

//import QtQuick 1.0

NavigationPane{
    
    onCreationCompleted: {
      if(hwinfo.modelName === "Passport"){
          passport = true;
      }
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All
            
        
        if(appsettings.getSystemSetting("loopColours", "") === "true") randomColourDecider.start();
        if(platinfo.osVersion<("10.2.3".substring(0, 6)))olderFirmware=true; else olderFirmware=false;
        if(appsettings.getSystemSetting("firstrun", "") === "")creator.createQMLObject("FirstRunArea.qml")
        getBatteryIconSource();
        if(battery.level <=20){
            powerSaving = true;
            enablePowerSaving();
        }
        if(alarmEnabled === true) alarmServer.showAlarmEnabledAtRunDialog();
        Application.setCover(bob.createObject())
        if(olderFirmware === false)decideApplicationtheme();
        if(appsettings.getSystemSetting("doNotDisturbOnLaunch", "")==="true"){
            globalNotifications.setMode(NotificationMode.AlertsOff)
        }
        updateWallpaperAspect();
        console.log(display.displayWidth)
        console.log(display.displayHeight)
        if(passport===false){
       if(display.displayHeight===display.displayWidth){
           keyboardDeviceNonPassport=true;}
       console.log(keyboardDeviceNonPassport)
       if(appsettings.getSystemSetting("reviewDioint", "")==="")appsettings.saveSystemSetting("reviewDioint", "1");
       else if (appsettings.getSystemSetting("reviewDioint", "")==="1"){
           creator.createQMLObject("ReviewDialog.qml"); appsettings.saveSystemSetting("reviewDioint", "2");}

        }
    }
    onCustomFontURLChanged: {
        appsettings.saveSystemSetting("customFontURL", customFontURL)
    }
    signal compactModeChanged
    property string clockTime:""
    property bool connectionOnline
    property bool olderFirmware
    property bool compactMode:false
    property bool  keyboardDeviceNonPassport:false
    property bool customFont: appsettings.getSystemSetting("customFontURL", "") ===""?false: true
    property string customFontURL:appsettings.getSystemSetting("customFontURL", "") ===""? "": appsettings.getSystemSetting("customFontURL", "")
    onColourChanged: {getIntervalIconSource(); if(olderFirmware===false)decideApplicationtheme(); }
    property bool showActiveFrameBattery :appsettings.getSystemSetting("showActiveFrameBattery", "")===""? true: false
    property bool showActiveFrameNextAlarm:appsettings.getSystemSetting("showActiveFrameNextAlarm", "")===""? true: false
    property bool liveActiveFrame :appsettings.getSystemSetting("liveActiveFrame", "")===""? true: false
    property bool alarmEnabled :appsettings.getSystemSetting("alarmEnabled", "")===""? false:true
    property string alarmTime: appsettings.getSystemSetting("alarmTime", "") ===""? "": appsettings.getSystemSetting("alarmTime", "")
    property string vibrationDuration: appsettings.getSystemSetting("VibrationDuration", "")? appsettings.getSystemSetting("VibrationDuration", ""): "5000"
    property string alarmSound: appsettings.getSystemSetting("alarmSound", "")==="" ? "asset:///sounds/1.aac": appsettings.getSystemSetting("alarmSound", "")
    property string activeFrameContentColour: appsettings.getSystemSetting("activeFrameContentColour", "")? appsettings.getSystemSetting("activeFrameContentColour", ""): "white"
    property string colour: appsettings.getSystemSetting("clockColour", "")? appsettings.getSystemSetting("clockColour", ""): "#0092cc"
    property string fsize: appsettings.getSystemSetting("fontSize", "")? appsettings.getSystemSetting("fontSize", ""): 55
    property string alarmSnoozeTimeout: appsettings.getSystemSetting("alarmSnoozeTimeout", "")===""?300000: appsettings.getSystemSetting("alarmSnoozeTimeout", "")
    property bool mediaControls: appsettings.getSystemSetting("mediaControls", "")===""? true: appsettings.getSystemSetting("mediaControls", "")
    property bool flashLight:appsettings.getSystemSetting("flashlight", "")===""? true:false
    property int flashSpeed:parseInt(appsettings.getSystemSetting("flashLightSpeed", ""))? parseInt(appsettings.getSystemSetting("flashLightSpeed", "")): 1000
    property bool powerSaving: false
    property string selectedBatterySource:""
    property bool passport: false
    property string previewTitle: ""
    property bool showSeconds:true
    property bool boldFont: appsettings.getSystemSetting("fontBold", "")===""? false:true
    property bool intervalAlarm: appsettings.getSystemSetting("intervalAlarmMode", "")===""? false:true
    property string wallpaper: appsettings.getSystemSetting("appWallpaper", "") ===""? "": appsettings.getSystemSetting("appWallpaper", "")
    property string dateFormat: appsettings.getSystemSetting("dateFormat", "")===""? "dd/MM/yyyy": appsettings.getSystemSetting("dateFormat", "") 
    property bool flashLED:appsettings.getSystemSetting("flashLED", "")===""? true:false
    property bool albumArtWallpaper:appsettings.getSystemSetting("albumArtWallpaper", "")===""? false:true
    property string timeFormat: appsettings.getSystemSetting("timeFormat", "")===""? ("hh:mm:ss"): appsettings.getSystemSetting("timeFormat", "") 
    property bool clock12Hour: timeFormat==="hh:mm:ss"? false: true
    property bool dateVisible:appsettings.getSystemSetting("dateVisible", "")===""? true:false
    property real mainViewBrightness: appsettings.getSystemSetting("mainViewBrightness", "")===""?1:appsettings.getSystemSetting("mainViewBrightness", "")
    property bool faceDownToStop:appsettings.getSystemSetting("faceDownToStop", "")===""? false:true
    property bool faceDownToPowerSave: appsettings.getSystemSetting("faceDownToPowerSave", "")===""? false:true
    property bool tickingSound: appsettings.getSystemSetting("tickingSound", "")===""? false:true
    property bool tickingSoundWhenLocked: appsettings.getSystemSetting("tickingSoundWhenLocked", "")===""? false:true
    property bool mediaKeyToStopAlarm:appsettings.getSystemSetting("mediaKeyToStopAlarm", "")===""?false:true
    property double tickVolume: appsettings.getSystemSetting("tickVolume", "")===""?0.8:appsettings.getSystemSetting("tickVolume", "")
    property int wallpaperAspectRatio: parseInt(appsettings.getSystemSetting("wallpaperAspectRatio", ""))===""? 2: parseInt(appsettings.getSystemSetting("wallpaperAspectRatio", "")) 
function updateWallpaperAspect(){
    if(wallpaperAspectRatio===0){
        wallpaperImg.scalingMethod=ScalingMethod.AspectFit
    }
    else if (wallpaperAspectRatio===1){
        wallpaperImg.scalingMethod=ScalingMethod.AspectFill
    }
    else if (wallpaperAspectRatio===2){
        wallpaperImg.scalingMethod=ScalingMethod.Fill
    }
    console.log(wallpaperImg.scalingMethod)
}
onWallpaperAspectRatioChanged: {
updateWallpaperAspect();

}
onAlbumArtWallpaperChanged: {
    if(albumArtWallpaper===true)appsettings.saveSystemSetting("albumArtWallpaper", "on")
    else{ appsettings.saveSystemSetting("albumArtWallpaper", "")}
}
    id: paneMain
    attachedObjects:[  ComponentDefinition {
            id:bob
            source:if(olderFirmware===true) "CoverOlderFirmware.qml" 
            else{"Cover.qml"}
        },
    NotificationGlobalSettings{id: globalNotifications},
    HardwareInfo {id: hwinfo},
    AppSettings { id: appsettings}, 
    EventServer{ id: eventserver}, 
    MediaController { id: mediaController}
    ]
    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                onTriggered: {creator.createQMLObject("AboutPage.qml")}
                imageSource: "asset:///images/ic_info.png"
                title: "About"
            },
            
            ActionItem {
            title: "Power Saving"
            imageSource: "asset:///images/ic_powersaving.png"
               onTriggered: {
                if(powerSaving===true){disablePowerSaving()}
                else{enablePowerSaving() }
            } 
        }, 
            ActionItem {
                title: "Toggle Alarm"
                imageSource:compactMode? "images/alarm_pulldown_small.png":"images/alarm_pulldown.png"
                onTriggered: {
                    if(alarmTime===""){toast.showText("Alarm Time is not set");}
                    else{
                        if(alarmEnabled===true){
                            console.log("Disabled")
                            alarmEnabled= false;
                            console.log("State: "+ alarmEnabled)
                            appsettings.saveSystemSetting("alarmEnabled", "");
                        }
                        else{
                            console.log("Enabled")
                            alarmEnabled= true;
                            appsettings.saveSystemSetting("alarmEnabled", "true");
                            console.log("State: "+ alarmEnabled)}
                    }
                }
            },
            ActionItem {
                enabled: alarmTime===""?false:true
                title:"Interval Alarm"
                imageSource: "asset:///images/pullDownInterval.png"
                onTriggered: {
                    if(intervalAlarm===true) {intervalAlarm=false; appsettings.saveSystemSetting("intervalAlarmMode",""); toast.showText("Interval Alarm Disabled");alarmImage.decideAlarmIcon();}
                    else{intervalAlarm=true; appsettings.saveSystemSetting("intervalAlarmMode", true);toast.showText("Interval Alarm Enabled"); alarmImage.decideAlarmIcon();}
                }
            }
            ]
        settingsAction: SettingsActionItem {
            onTriggered: {creator.createQMLObject("Settings.qml")}
        } 
    }
function resetScreenSaverMovement(){
    timelabelCont.topPadding=compactMode? -10:-35;
    timelabelCont.leftPadding=0;
    datelabelCont.topPadding=compactMode?-5: -10;
    datelabelCont.leftPadding=0;  
}
function checkKeys(){if(mediaKeyToStopAlarm===true){creator.createQMLObject("MediaWatcher.qml")}}

    
    function decideApplicationtheme(){
        if(colour==="white")Application.themeSupport.setPrimaryColor(Color.create("#B0B0B0"), Color.create("#909090"));
        else if(colour==="#0092cc") Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour));
        else if(colour==="#0000ff")Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour));
        else if(colour==="#ff0000") Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour)); 
        else if(colour==="#48ff00")  Application.themeSupport.setPrimaryColor(Color.create("#22E200"), Color.create("#22E200"));
        else if(colour==="#ffff00") Application.themeSupport.setPrimaryColor(Color.create("#CCCC00"), Color.create("#CCCC00"));
        else if(colour==="#ffcc00") Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour));
        else if(colour==="#ff00ff") Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour));
        else if(colour==="#9900ff") Application.themeSupport.setPrimaryColor(Color.create(colour), Color.create(colour));
    }
    function decideBackIcon(){
        if(colour==="white"){return "asset:///images/MediaControlIcons/back_white.png"}
        else if(colour==="#0092cc") {return "asset:///images/MediaControlIcons/back_bbblue.png"}  
        else if(colour==="#0000ff"){ return "asset:///images/MediaControlIcons/back_blue.png"}  
        else if(colour==="#ff0000") {return "asset:///images/MediaControlIcons/back_red.png"} 
        else if(colour==="#48ff00"){return "asset:///images/MediaControlIcons/back_green.png"}  
        else if(colour==="#ffff00"){return "asset:///images/MediaControlIcons/back_yellow.png"}   
        else if(colour==="#ffcc00"){return "asset:///images/MediaControlIcons/back_orange.png"}   
        else if(colour==="#ff00ff") {return "asset:///images/MediaControlIcons/back_magenta.png"}
        else if(colour==="#9900ff"){return "asset:///images/MediaControlIcons/back_purple.png"}
    }
    function decideSkipIcon(){
        if(colour==="white"){return "asset:///images/MediaControlIcons/skip_white.png"}
        else if(colour==="#0092cc") {return "asset:///images/MediaControlIcons/skip_bbblue.png"}  
        else if(colour==="#0000ff"){ return "asset:///images/MediaControlIcons/skip_blue.png"}  
        else if(colour==="#ff0000") {return "asset:///images/MediaControlIcons/skip_red.png"} 
        else if(colour==="#48ff00"){return "asset:///images/MediaControlIcons/skip_green.png"}  
        else if(colour==="#ffff00"){return "asset:///images/MediaControlIcons/skip_yellow.png"}   
        else if(colour==="#ffcc00"){return "asset:///images/MediaControlIcons/skip_orange.png"}   
        else if(colour==="#ff00ff") {return "asset:///images/MediaControlIcons/skip_magenta.png"}
        else if(colour==="#9900ff"){return "asset:///images/MediaControlIcons/skip_purple.png"}
    }
    function decidePlayPauseIcons(){
    if( mediaController.state===2) {
        if(colour==="white"){return "asset:///images/MediaControlIcons/pause_white.png"}
        else if(colour==="#0092cc") {return "asset:///images/MediaControlIcons/pause_bbblue.png"}  
        else if(colour==="#0000ff"){ return "asset:///images/MediaControlIcons/pause_blue.png"}  
        else if(colour==="#ff0000") {return "asset:///images/MediaControlIcons/pause_red.png"} 
        else if(colour==="#48ff00"){return "asset:///images/MediaControlIcons/pause_green.png"}  
        else if(colour==="#ffff00"){return "asset:///images/MediaControlIcons/pause_yellow.png"}   
        else if(colour==="#ffcc00"){return "asset:///images/MediaControlIcons/pause_orange.png"}   
        else if(colour==="#9900ff"){return "asset:///images/MediaControlIcons/pause_purple.png"}
        else if(colour==="#ff00ff") {return "asset:///images/MediaControlIcons/pause_magenta.png"}
        else{return "asset:///images/MediaControlIcons/pause_bbblue.png"} 
    }
    else if (mediaController.state===3){
        if(colour==="white"){return "asset:///images/MediaControlIcons/play_white.png"}
        else if(colour==="#0092cc") {return "asset:///images/MediaControlIcons/play_bbblue.png"}  
        else if(colour==="#0000ff"){ return "asset:///images/MediaControlIcons/play_blue.png"}  
        else if(colour==="#ff0000") {return "asset:///images/MediaControlIcons/play_red.png"} 
        else if(colour==="#48ff00"){return "asset:///images/MediaControlIcons/play_green.png"}  
        else if(colour==="#ffff00"){return "asset:///images/MediaControlIcons/play_yellow.png"}   
        else if(colour==="#ffcc00"){return "asset:///images/MediaControlIcons/play_orange.png"}   
        else if(colour==="#9900ff"){return "asset:///images/MediaControlIcons/play_purple.png"}
        else if(colour==="#ff00ff") {return "asset:///images/MediaControlIcons/play_magenta.png"}
        else{return "asset:///images/MediaControlIcons/play_bbblue.png"}
    }
    }
    function colourLoop(){
        if(colour==="white"){ colour= "#0092cc";
            if(intervalAlarm){alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_defaultbblue.png": "asset:///images/alarmicons/alarm_defaultbbblue.png";}
            appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_bbblue.png");}
        else if(colour==="#0092cc") {colour= "#0000ff";
           alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_blue.png": "asset:///images/alarmicons/alarm_blue.png";
           appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_blue.png");}
            else if(colour==="#0000ff"){ colour= "#ff0000";
           alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_red.png": "asset:///images/alarmicons/alarm_red.png";
           appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_red.png"); }
            
            else if(colour==="#ff0000") {colour= "#48ff00";
           alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_green.png": "asset:///images/alarmicons/alarm_green.png";
           appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_green.png");}
            
            else if(colour==="#48ff00"){ colour= "#ffff00";
          alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_yellow.png": "asset:///images/alarmicons/alarm_yellow.png";
          appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_yellow.png");}
            
            else if(colour==="#ffff00"){colour= "#ffcc00";
       alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_orange.png": "asset:///images/alarmicons/alarm_orange.png";
       appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_orange.png");}
            
            else if(colour==="#ffcc00"){ colour= "#ff00ff"; 
           alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_magenta.png": "asset:///images/alarmicons/alarm_magenta.png";
            appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_magenta.png");}
            else if(colour==="#ff00ff") {colour= "#9900ff";
       alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_purple.png": "asset:///images/alarmicons/alarm_purple.png";
       appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_purple.png");}
            
            else if(colour==="#9900ff"){ colour= "white"; 
            alarmImage.imageSource= intervalAlarm?"asset:///images/alarmicons/interval_white.png": "asset:///images/alarmicons/alarm_white.png";
            appsettings.saveSystemSetting("alarmtriggerimgSource", "asset:///images/alarmicons/TriggerPage/alarm_white.png");}
       console.log("Colour Loop Selected: "+colour)
       timelabel.textStyle.color=  Color.create(colour)
       datelabel.textStyle.color= Color.create(colour)
       batteryPercentage.textStyle.color = Color.create(colour)
       getBatteryIconSource();
       getLedColour();
    }
    
    function getBatteryIconSource(){ 
        if(colour==="#0092cc") {
            selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_bbblue.png" :
            battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_bbblue.png" :
            battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_bbblue.png" :
            battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_bbblue.png" : "asset:///images/BatteryIcons/full_battery_bbblue.png"
        }
        else if(colour==="white"){ selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_white.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_white.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_white.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_white.png" : "asset:///images/BatteryIcons/full_battery_white.png"}
        
        else if(colour==="#0000ff"){ selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_blue.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_blue.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_blue.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_blue.png" : "asset:///images/BatteryIcons/full_battery_blue.png"}
        else if(colour==="#ff0000"){ selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_red.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_red.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_red.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_red.png" : "asset:///images/BatteryIcons/full_battery_red.png"}
        else if(colour==="#48ff00"){
            selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_green.png" :
            battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_green.png" :
            battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_green.png" :
            battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_green.png" : "asset:///images/BatteryIcons/full_battery_green.png"
        }
        else if(colour==="#ffcc00"){selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_orange.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_orange.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_orange.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_orange.png" : "asset:///images/BatteryIcons/full_battery_orange.png"}
        else if(colour==="#ffff00"){
            {selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_yellow.png" :
            battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_yellow.png" :
            battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_yellow.png" :
            battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_yellow.png" : "asset:///images/BatteryIcons/full_battery_yellow.png"
        }}
        else if(colour==="#ff00ff"){
        {selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_magenta.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_magenta.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_magenta.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_magenta.png" : "asset:///images/BatteryIcons/full_battery_magenta.png"
        }}
        else if(colour==="#9900ff"){
        selectedBatterySource=battery.level <= 20 ?  "asset:///images/BatteryIcons/low_battery_purple.png" :
        battery.level <= 55 ? "asset:///images/BatteryIcons/medium_battery_purple.png" :
        battery.level <= 70 ? "asset:///images/BatteryIcons/70plus_battery_purple.png" :
        battery.level < 100 ? "asset:///images/BatteryIcons/full_battery_purple.png" : "asset:///images/BatteryIcons/full_battery_purple.png"  
        }
        console.log(selectedBatterySource)
        return selectedBatterySource;
    }
    
 function getIntervalIconSource(){
     if(colour==="white"){return "asset:///images/IntervalIcons/white_interval.png" }
     else if(colour==="#0092cc") {return "asset:///images/IntervalIcons/bblue_interval.png"}
     else if(colour==="#0000ff"){ return "asset:///images/IntervalIcons/blue_interval.png"}
     else if(colour==="#ff0000") {return "asset:///images/IntervalIcons/red_interval.png"}
     else if(colour==="#48ff00"){return "asset:///images/IntervalIcons/green_interval.png"}   
     else if(colour==="#ffff00"){return "asset:///images/IntervalIcons/yellow_interval.png"} 
     else if(colour==="#ffcc00"){return "asset:///images/IntervalIcons/orange_interval.png" }  
     else if(colour==="#ff00ff") {return "asset:///images/IntervalIcons/magenta_interval.png" } 
     else if(colour==="#9900ff"){return "asset:///images/IntervalIcons/purple_interval.png"}
 }
 
 function getSnoozeIconSource(){
     if(colour==="white"){return "asset:///images/SnoozeIcons/snooze_white.png" }
     else if(colour==="#0092cc") {return "asset:///images/SnoozeIcons/snooze_bblue.png"}
     else if(colour==="#0000ff"){ return "asset:///images/SnoozeIcons/snooze_blue.png"}
     else if(colour==="#ff0000") {return "asset:///images/SnoozeIcons/snooze_red.png"}
     else if(colour==="#48ff00"){return "asset:///images/SnoozeIcons/snooze_green.png"}   
     else if(colour==="#ffff00"){return "asset:///images/SnoozeIcons/snooze_yellow.png"} 
     else if(colour==="#ffcc00"){return "asset:///images/SnoozeIcons/snooze_orange.png" }  
     else if(colour==="#ff00ff") {return "asset:///images/SnoozeIcons/snooze_magenta.png" } 
     else if(colour==="#9900ff"){return "asset:///images/SnoozeIcons/snooze_purple.png"}
 }

 function disablePowerSaving(){powerSaving=false;toast.showText("Power Saving Disabled");timelabel.opacity=1; datelabel.opacity=1; batteryPercentage.opacity=1; alarmImage.opacity=1;snoozeImage.opacity=1;  batteryImage.opacity=1; screensavermovementplus.interval=1000; screensavermovementneg.interval=1000; batteryScreenMovementneg.interval=1000; batteryScreenMovementplus.interval=1000; alarmMovementneg.interval=1000; alarmMovementplus.interval=1000}
    function enablePowerSaving(){ powerSaving=true;toast.showText("Power Saving Enabled");  if( mediaControls===true) {mediaControls=false}timelabel.opacity=0.6;datelabel.opacity=0.6;batteryPercentage.opacity=0.6; alarmImage.opacity=0.6;snoozeImage.opacity=0.6; batteryImage.opacity=0.6; screensavermovementplus.interval=3000; screensavermovementneg.interval=3000; batteryScreenMovementneg.interval=3000; batteryScreenMovementplus.interval=3000; alarmMovementneg.interval=3000; alarmMovementplus.interval=3000}
    
    function soundAlarm(){
        if(alarmServer.alarmSounding===false){
         tickSound.stop();
         console.log("Times Match, sounding")
         alarmServer.alarmSounding=true;
         mediaController.pause();
         
         if(intervalAlarm===true){alarmServer.soundInterval();intervalTriggerCont.opacity=0.9}
         else{
             if(eventserver.thumbnailed===true) {console.log("THUMBNAIL OPENING"); eventserver.openThumbnailedAlarmDialog()
             
                 if(appsettings.getSystemSetting("alarmSoundInternet", "")===""){console.log("Not Using Internet Sound"); alarmServer.sound();}
                 else{
                     if(connectionOnline===true){ console.log("Firing from here, apparently"); alarmServer.sound();}
                     else{console.log("CONNECTION DEAD, SHOULD SWAP SOURCE") ; alarmSound="asset:///sounds/1.aac"; alarmServer.sound();console.log("CONNECTION DEAD, NEW SOURCE ? " + alarmSound)}
             }
                }
             
                else{ if(appsettings.getSystemSetting("alarmSoundInternet", "")===""){console.log("Not Using Internet Sound"); alarmServer.sound();}
                else{
                        if(connectionOnline===true){ alarmSound=appsettings.getSystemSetting("alarmSound", "");console.log("Firing from here, apparently"); alarmServer.sound();}
                        else{console.log("CONNECTION DEAD, SHOULD SWAP SOURCE") ; alarmSound="asset:///sounds/1.aac"; alarmServer.sound();console.log("CONNECTION DEAD, NEW SOURCE ? " + alarmSound)}
                }
                 
                 creator.createQMLObject("AlarmTriggerPage.qml")} 
         }
         if(flashLED===true) led.flash();
         if(flashLight===true)alarmServer.flashLight();
     }

        }
        
    
        function startScreenSaveMovement(){
            screensavermovementplus.start();
            batteryScreenMovementplus.start();
            alarmMovementplus.start();
        }

    
function getLedColour(){
    if(colour==="white")led.color=LedColor.White
    else if(colour==="#0092cc") led.color=LedColor.Cyan
    else if(colour==="#0000ff") led.color=LedColor.Blue
    else if(colour==="#ff0000") led.color=LedColor.Red
    else if (colour==="#48ff00")led.color=LedColor.Green
    else if(colour==="#ffff00")led.color=LedColor.Yellow
    else if(colour==="#ff00ff") led.color=LedColor.Magenta
    else led.color=LedColor.Cyan 
}
Page {
    
    onCreationCompleted: {
        timer.start();
        startScreenSaveMovement();
        dateTimer.start();
        chargingStateCheck.start();
    }
    attachedObjects: [
        Connections{
            target: appUI
            onOnlineModeChanged: {
                connectionOnline = isOnline;
                console.log("Connection Online " +connectionOnline)
            
            }
        },
        MediaPlayer {
           id: tickSound
           sourceUrl:"sounds/tick.mp3"
           volume: if(tickingSoundWhenLocked===true){ tickVolume }
           else{ eventserver.thumbnailed? 0: tickVolume }
           repeatMode: RepeatMode.None
        },
    
        ComponentDefinition {
            id: creator;
            function createQMLObject(sourceUrl){source=sourceUrl; creator.createObject()}
        }, 
       
      SystemTimer {id: randomColourDecider;interval:300000 ; onTimeout: {colourLoop();}},
  
      SystemToast{id: toast;property string uid:""
      onFinished: {
          if (buttonSelection().label==="Ok"){
              if(uid==="ClockTip")appsettings.saveSystemSetting("ClockTip", "true")
              else if (uid==="SettingsStart")appsettings.saveSystemSetting("SettingsStart", "true")
              else if (uid==="facedownAlarmEnabledWarning")appsettings.saveSystemSetting("facedownAlarmEnabledWarning", "true")
              

              } }
          
      
          function showText(text) {button.label="";toast.body = text; toast.show()} 
          function showTextWithButton(text, buttonText, uId) {button.label=buttonText;uid=uId;toast.body = text; toast.show()} 
      },
      Flashlight {id: flashlight},
      Led {
          id: led
          color: if(colour==="white")LedColor.White
          else if(colour==="#0092cc") LedColor.Cyan
          else if(colour==="#0000ff") LedColor.Blue
          else if(colour==="#ff0000") LedColor.Red
          else if (colour==="#48ff00") LedColor.Green
          else if(colour==="#ffff00") LedColor.Yellow
          else if(colour==="#ff00ff") LedColor.Magenta
          else LedColor.Cyan
      },
      AlarmServer {id: alarmServer},
    //  WeatherServer { id: weatherServer},
      
      BatteryInfo {
          id: battery
          onLevelChanged: { getBatteryIconSource();
              if(powerSaving=== true){
              if(battery.chargingState=== 2){
                  powerSaving=false;disablePowerSaving();} }
              if(powerSaving=== false){
                  if(level <=20){
                      powerSaving=true;
                      enablePowerSaving();
                  }
              }
          }
      },
      
 LayoutUpdateHandler
      {id: layout} 
  ]
    content:  Container {
        id: cont1
        opacity: mainViewBrightness
       ImageView {
           id: wallpaperImg
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            scalingMethod: ScalingMethod.Fill
            imageSource: wallpaper
        }
        layout: DockLayout {}

SystemTimer {
    id:firstRunTip
    interval: 1500
    onTimeout: {
        if(appsettings.getSystemSetting("firstrun", "")===""){}
        else{  {if(appsettings.getSystemSetting("ClockTip", "")===""){toast.showTextWithButton("Double Tap the Clock to Quickly Access the Alarm Settings", "Ok", "ClockTip")}}}
    }
}
        SystemTimer {
            id: timer
            interval: 1000
            onTimeout: {clockTime=Qt.formatDateTime (new Date(), timeFormat);
               if(alarmEnabled === true){
                   if(alarmTime=== clockTime) soundAlarm();}
               
               if(alarmServer.alarmSounding===false){
                       if(tickingSound===true) tickSound.play();
                   }
               
            }
            }
        
        SystemTimer {
            id: dateTimer
            interval: 40000
            onTimeout: {
                datelabel.text= Qt.formatDateTime (new Date(), dateFormat)
            }
        }
        SystemTimer {
            id: screensavermovementplus
            interval: 1000
            onTimeout: {
                if(compactMode===true){
                  //  console.log("TOP PADDING " + timelabelCont.topPadding)
                    if(timelabelCont.topPadding<=-10){screensavermovementplus.stop(); screensavermovementneg.start(); }
                    else{
                      //  console.log("TOP PADDING " + timelabelCont.topPadding)
                        timelabelCont.topPadding -=1;
                        datelabelCont.topPadding -=1;
                    }
                    
                }
                else{
                if(timelabelCont.leftPadding>=150){screensavermovementplus.stop(); screensavermovementneg.start()}
              else{
                 timelabelCont.leftPadding +=1
                 datelabelCont.leftPadding +=1
                    }
        }
                }
        }
        SystemTimer {
            id: screensavermovementneg
            interval: 1000
            onTimeout: {

                if(compactMode===true){
                    if(timelabelCont.topPadding >=50){screensavermovementneg.stop(); screensavermovementplus.start()} 
                    else{
                        timelabelCont.topPadding +=1;
                        datelabelCont.topPadding +=1; 
                    } 
                }
                
                else{
                    
                if(timelabelCont.leftPadding <=-25){screensavermovementneg.stop(); screensavermovementplus.start()} 
                else{
                timelabelCont.leftPadding -=1;
                datelabelCont.leftPadding -=1;
              } 
            }
            }
        }
        SystemTimer {
            id: batteryScreenMovementplus
            interval: 1000
            onTimeout: {
                if(batteryImageCont.bottomPadding >=70){
                    batteryScreenMovementplus.stop();  
                    batteryScreenMovementneg.start();
                }
                else{batteryImageCont.bottomPadding +=1
                    batteryperlabel.bottomPadding +=1
                    mediaButtonsCont.bottomPadding+=1;
                    }
            }
        }
        SystemTimer {
            id: batteryScreenMovementneg
            interval: 1000
            onTimeout: {
                if(batteryImageCont.bottomPadding===0){
                    batteryScreenMovementneg.stop()
                    batteryScreenMovementplus.start() 
                }
                else{batteryImageCont.bottomPadding-=1
                    batteryperlabel.bottomPadding -=1
                    mediaButtonsCont.bottomPadding-=1;
                    }
            }
        }
        SystemTimer {
            id: alarmMovementplus
            interval: 1000
            onTimeout: {
                if(alarmCont.bottomPadding >=70){
                    alarmMovementplus.stop();  
                    alarmMovementneg.start();
                }
                else{alarmCont.bottomPadding +=1; snoozeCont.bottomPadding +=1}
            }
        }
        
        SystemTimer {
            id: alarmMovementneg
            interval: 1000
            onTimeout: {
                if(alarmCont.bottomPadding === 0){
                    alarmMovementplus.start();  
                    alarmMovementneg.stop();
                }
                else{alarmCont.bottomPadding -=1; snoozeCont.bottomPadding-=1;}
            }
        }
        SystemTimer {
            id: chargingStateCheck
            interval: 4000
            onTimeout: {if(battery.chargingState=== 2)batteryImage.flash();}
        }
        Container {
            id: timelabelCont
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            topPadding: compactMode? -10:-35
            gestureHandlers: [ DoubleTapHandler {onDoubleTapped: {creator.createQMLObject("AlarmSettings.qml")} }]
        Label {
            id: timelabel  
            accessibility.name:"The Current Time is" + clockTime    
            textStyle.base: myStyle.style
            text: clockTime===""? Qt.formatDateTime (new Date(), timeFormat): clockTime
    attachedObjects: TextStyleDefinition {
        id: myStyle
        base:SystemDefaults.TextStyles.BigText
        
        fontWeight: boldFont?  FontWeight.Bold:FontWeight.Normal 
        fontSize: FontSize.PointValue
        
        fontSizeValue: if(customFont===true){
            if(timeFormat==="hh:mm:ss"){
                if(compactMode===true){
                    return fsize-20;
                }
                else{
                    return fsize;
                }
            }
            else if(timeFormat==="hh:mm"){
                if(compactMode===true){
                    return fsize-4;
                }
                else{return fsize}
            }
            
            else if(timeFormat==="h:mm:ss AP"){
                if(compactMode===true){
                    fsize-30
                }
                else{
                    fsize-15
                
                }
            }
            
            else  if(timeFormat==="h:mm AP"){
                if(compactMode===true){
                    fsize-21
                }
                else{ fsize-14}
            }
                
        }
        
        else{
        if(timeFormat==="hh:mm:ss"){
        if(compactMode===true){
        return fsize-17;
        }
        else{
        return fsize;
        }
        }
        else if(timeFormat==="hh:mm"){
        if(compactMode===true){
            return fsize-1;
        }
        else{return fsize+3}
        }
        
        else if(timeFormat==="h:mm:ss AP"){
        if(compactMode===true){
            fsize-27
        }
        else{
            fsize-15
            
        }
        }
        
        else  if(timeFormat==="h:mm AP"){
        if(compactMode===true){
            fsize-18
        }
        else{ fsize-11}
        }
        
        }
            
            //customFont?compactMode? timeFormat==="hh:mm:ss"?fsize-20 :fsize-30 :timeFormat==="hh:mm:ss"? fsize:fsize-17 :compactMode? timeFormat==="hh:mm:ss"?fsize-17 :fsize-27 :timeFormat==="hh:mm:ss"? fsize:fsize-14
        color: Color.create(colour)  
        rules:[
            
            FontFaceRule {
                fontFamily:"sans-serif"
                source: customFontURL
            }
        ]
        fontFamily: "MyFont, sans-serif"

    }
           /* textStyle{
                
                
                fontWeight: if(appsettings.getSystemSetting("fontBold", "")==="")FontWeight.Normal 
                else FontWeight.Bold
                fontSize: FontSize.PointValue
                
                fontSizeValue: compactMode? timeFormat==="hh:mm:ss"?fsize-17 :fsize-27 :timeFormat==="hh:mm:ss"? fsize:fsize-14
               // base: SystemDefaults.TextStyles.BigText
                color: Color.create(colour)      
            }  */
        }
    }
  
        Container {
            visible: dateVisible
            accessibility.name:"The Current Date is" + Qt.formatDateTime (new Date(), dateFormat)   
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center  
            topPadding: compactMode?-5: -10
            minWidth: customFont?layout.layoutFrame.width +70:layout.layoutFrame.width +60
            id:datelabelCont
        Label {
            id: datelabel 
           // minWidth: datelabelCont.minWidth
            textStyle.base: myStyle1.style

            text:Qt.formatDateTime (new Date(), dateFormat)
            attachedObjects: TextStyleDefinition {
                id: myStyle1
                base:SystemDefaults.TextStyles.BigText
                fontWeight:  boldFont?  FontWeight.Bold:FontWeight.Normal 
                fontSize: FontSize.PointValue
                fontSizeValue:customFont?compactMode? 16:19:  compactMode? 18:21
                color: Color.create(colour)
                rules:[
                    FontFaceRule {
                        fontFamily:"sans-serif"
                        source:customFontURL
                    }
                
                ]
                fontFamily: "MyFont, sans-serif"
            
            
            }
            /*textStyle{
                fontWeight: if(appsettings.getSystemSetting("fontBold", "")==="")FontWeight.Normal 
                else FontWeight.Bold
                fontSize: FontSize.PointValue
                fontSizeValue: compactMode? 18:21
                color: Color.create(colour)
            }*/
        }
        }
        Container{
            maxWidth: 100
            accessibility.name:"Battery is at" +  battery.level + "%" 
            id: batteryImageCont
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            ImageFade {
                id: batteryImage
                visible: true
                customFadeInValue: powerSaving? 0.6: 1
                imageSource: getBatteryIconSource();          
                minHeight: 98
                minWidth:compactMode? 56: 60
            } 
        }
    
        Container {
            accessibility.name:"Battery is at" +  battery.level + "%" 
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            leftPadding: compactMode? 73:75
            id:  batteryperlabel
            Label {
                text: battery.level + "%"
                id: batteryPercentage
                textStyle.base: myStyle2.style
                attachedObjects: TextStyleDefinition {
                    id: myStyle2
                    fontWeight: boldFont? FontWeight.Bold: FontWeight.Normal
                    fontSize: FontSize.PointValue
                    fontSizeValue:customFont? compactMode? 10:12:compactMode? 11:13
                    color: Color.create(colour)
                    rules:[
                        
                        FontFaceRule {
                            fontFamily:"sans-serif"
                            source:customFontURL
                        }

                    ]
                    fontFamily: "MyFont, sans-serif"
                
                
                }
                textStyle{
                   
                }
            }
        }  
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            id: snoozeCont
            bottomPadding: 0
            onTouch: {
                if(event.isUp()) {
                    creator.createQMLObject("SnoozeSwitchDialog.qml")}   
            }
            onTouchExit: {
                if(event.isDown()){}
            }
            
            ImageView {
                opacity:1
                imageSource: getSnoozeIconSource();
                id: snoozeImage
                visible:alarmServer.snoozed
                minHeight: 98
                minWidth: 98        
            }
        }    
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            id: alarmCont
            bottomPadding: 0
            onTouch: {
                if(event.isUp()) {
                    if(intervalAlarm===true){
                        toast.showText("Interval Alarm:\n\n" + "Interval Timeout: " + appsettings.getSystemSetting("intervalAlarmTimeoutText", "") +"\n" + "Times To Sound: " + appsettings.getSystemSetting("intervalHowManyToSoundText", "") +"\n" +"Time between sounding: "+appsettings.getSystemSetting("intervalTimeBetweenSoundingText", "") )
                    }
                    else{toast.showText("Alarm Time: " + alarmTime)} 
                }   
            }
            onTouchExit: {
                if(event.isDown()){}
            }
            ImageView {
                accessibility.name:"Alarm is set for" +  alarmTime
                function decideAlarmIcon(){imageSource= intervalAlarm? appsettings.getSystemSetting("intervalIconSource", "")===""? "asset:///images/alarmicons/interval_defaultbblue.png":appsettings.getSystemSetting("intervalIconSource", ""):appsettings.getSystemSetting("alarmimgSource", "")===""? "asset:///images/alarmicons/alarm_defaultbbblue.png": appsettings.getSystemSetting("alarmimgSource", "")}
                opacity:1
                id: alarmImage
                visible: alarmEnabled
                imageSource: intervalAlarm? appsettings.getSystemSetting("intervalIconSource", "")===""? "asset:///images/alarmicons/interval_defaultbblue.png":appsettings.getSystemSetting("intervalIconSource", ""):appsettings.getSystemSetting("alarmimgSource", "")===""? "asset:///images/alarmicons/alarm_defaultbbblue.png": appsettings.getSystemSetting("alarmimgSource", "")
                minHeight: 98
                minWidth: 98        
            }
        }   
        
        Container{
            id: mediaButtonsCont
            minWidth: compactMode? 295:550
            maxWidth: 500
            maxHeight: 200
            minHeight: 200
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            layout: DockLayout {
                
            }
        MediaControlButton {
        //    id: pauseplay
            iconSource: decidePlayPauseIcons()
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            onClicked: { mediaController.playPause()}
        }
      MediaControlButton {
         //   id: skip
            visible: mediaController.forwardEnabled
            iconSource: decideSkipIcon()
          horizontalAlignment: HorizontalAlignment.Right
          verticalAlignment: VerticalAlignment.Bottom

         // leftPadding: 150
            onClicked:{mediaController.next()}
        }
        MediaControlButton {
            //id: back
            visible: mediaController.backEnabled
            iconSource: decideBackIcon()
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Left
         //   leftPadding: 350
            onClicked:{mediaController.previous()}
        }
}
        Container {
            background: Color.Black
            opacity: 0
            id: intervalTriggerCont       
            onTouch: { if(event.isUp()) {opacity=0;alarmServer.stop();alarmServer.stopFlash();led.cancel();} }
            onTouchExit: {if(event.isDown()){}}
            layout: DockLayout {}
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            ImageView {
                imageSource:getIntervalIconSource()
                minHeight: 700
                opacity: 1
                minWidth:700
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
            Label{
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                text:"Touch to stop Interval Alarm"
                textStyle{
                    fontWeight: FontWeight.Bold
                    fontSize: FontSize.PointValue
                    fontSizeValue: 12
                    base: SystemDefaults.TextStyles.BigText
                    color: Color.create(colour)
                }
            }
            ActivityIndicator {
                id: bufferInd
                preferredHeight: 100  
                preferredWidth: 100
                running: alarmServer.audioBufferProgress===1? true:false
                horizontalAlignment: HorizontalAlignment.Right
                rightMargin: 5
                verticalAlignment: VerticalAlignment.Center
            }
        }
    }
}
}
