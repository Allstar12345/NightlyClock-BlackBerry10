import bb.cascades 1.2
import timer 1.0
import bb.system 1.0
import bb.platform 1.0
import bb.device 1.2
import QtQuick 1.0
Container {
    id: eventserver
    property bool thumbnailed:false
    property bool deviceLocked: false
    property bool flipEnabledPowerSaving:false
    property alias deviceOrientation: deviceInfo.ori
    property int eventsRefreshRate: powerSaving?5000:2000
    function openThumbnailedAlarmDialog(){creator.createQMLObject("ThumbnailAlarmTriggerDialog.qml")}
    onCreationCompleted:{ events.start(); if(passport===false){
compactMode=true;}
  
//Application.invisible.connect(onInvisibleChanged);
//Application.thumbnail.connect(onThumbnailChanged);
}
function onInvisibleChanged(){if(Application.isInvisible()==true){ thumbnailed=true;} else{thumbnailed=false} console.log("Invisible "+ Application.isInvisible())}
function onThumbnailChanged(){if(Application.isThumbnailed()==true) {thumbnailed=true; } else{thumbnailed=false}; ; console.log("Thumbailed "+ Application.isThumbnailed())}


    
    attachedObjects: [   
        SystemTimer {
            id: events
            interval: 2000
            onTimeout: {
                if(Application.isThumbnailed()==true) { thumbnailed=true;}
                
                else if(Application.isInvisible()){thumbnailed=true;}
                
                else {thumbnailed=false;}
                console.log(thumbnailed);
            }
        
        },
        OrientationHandler {
            id: handler
            onOrientationAboutToChange: {
                if (orientation == UIOrientation.Portrait) {
                    if(passport){}
                    else{compactMode=true;}
                    resetScreenSaverMovement();
                    appUI.setGlobalCompactMode(compactMode);
                    compactModeChanged();
                } else if (orientation == UIOrientation.Landscape) {
                    if(passport){}
                    else{compactMode=false;}
                    resetScreenSaverMovement();
                    appUI.setGlobalCompactMode(compactMode);
                    compactModeChanged();
                }
            }
            onOrientationChanged: {
                // can update the UI after the orientation changed
            }
            onDisplayDirectionChanged: {
                // can perform actions based on the direction of the display
            }
        },
        DeviceInfo {
        
            id: deviceInfo
            property int ori
            
            onOrientationChanged: {

                console.log("DeviceInfo::onOrientationChanged : " + orientation)
                ori=orientation
                
                alarmServer.checkOrientationStop();
                console.log(ori)
                
                if(battery.chargingState=== 2){}
                else{
                if(faceDownToPowerSave===true){
                    if(powerSaving===false){
                        if(orientation===1){
                            enablePowerSaving();
                            console.log("Flip Power Saving enabled")
                            flipEnabledPowerSaving=true;
                        }
                    }
                    if(powerSaving===true){
                        if(flipEnabledPowerSaving===true){
                            if(orientation===0){
                                disablePowerSaving();
                            }
                            else  if(orientation===2){
                                disablePowerSaving();
                            }
                            else  if(orientation===3){
                                disablePowerSaving();
                            }
                            else  if(orientation===4){
                                disablePowerSaving();
                            }
                            else  if(orientation===5){
                                disablePowerSaving();
                            }
                            
                        }    
                    }
                }
                    
                }
                
                switch (orientation) {
                    case DeviceOrientation.BottomUp: return 5
                    case DeviceOrientation.FaceDown:return 1 
                    case DeviceOrientation.FaceUp: return 0
                    case DeviceOrientation.LeftUp:return 3
                    case DeviceOrientation.RightUp: return 4
                    case DeviceOrientation.TopUp: return 2
                }
            }
        },
        HomeScreen{
            id: homescreen
            onBedsideModeActiveChanged: {
                if(homescreen.bedsideModeActive===true) if(powerSaving===false)enablePowerSaving();
                else{ disablePowerSaving();}
            }
            onLockStateChanged: {
                console.log(lockState)
                if(lockState===2) deviceLocked=true;
                else if (lockState===3) deviceLocked=true;
                else if(lockState===4) deviceLocked=true;
                else deviceLocked=false;
            }
        }
    ] 
}
