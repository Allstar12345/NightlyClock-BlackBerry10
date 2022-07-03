import bb.cascades 1.2
import bb.multimedia 1.2
import timer 1.0
import bb.device 1.2
import bb.system 1.2


Container {
    id: page
    function soundInterval(){
        if(intervalCount==counted){}
        else{intervalAlarmSounding=true;sound();intervalSounder.start();if(flashLight===true){flashLight();}
         }       }
 function checkOrientationStop(){if(faceDownToStop===true){
     if(alarmSounding===true){
         if(eventserver.deviceOrientation===1){if(intervalAlarmSounding){intervalSounder.stop();} stop();led.cancel();triggerPageClose();}
         else{console.log("Not in correct position to stop")}
     }
 }}


   property double globalVolume:0
    signal killKeysWatcher
    signal triggerPageClose
   signal minimisedAlarmDialogClose
   function showAlarmEnabledAtRunDialog(){alarmEnabledBoxBodge.start()}
   function sound(){checkKeys();alarmSounding=true;alarmSounder.play();if(appsettings.getSystemSetting("fadeAudio", "")==="true"){volFade.start();} else{globalVolume=1.0}
   vibrate.start(100, vibrationDuration)}
   function stop() {snoozed=false; alarmSounding=false; globalVolume=0;volFade.stop();alarmSounder.stop(); vibrate.stop();flashTimer.stop(); alarmEnabled=false; appsettings.saveSystemSetting("alarmEnabled", "");intervalTriggerCont.opacity=0; killKeysWatcher();}
   function snooze(){snoozed=true;snoozeTimer.start()}
   function flashLight(){flashTimer.start();}
   function stopFlash() {flashTimer.stop(); flashlight.enabled=true; flashlight.enabled=false}
   function stopSnooze(){snoozed=false; snoozeTimer.stop();}
   property bool alarmSounding:false
   property int intervalCount: parseInt(appsettings.getSystemSetting("intervalHowManyToSound", ""))
   property int intervalRestartTime: parseInt(appsettings.getSystemSetting("intervalTimeBetweenSounding", ""))
   property int counted:0
   property int soundingInterval: parseInt(appsettings.getSystemSetting("intervalAlarmTimeout", ""))
   property int audioBufferProgress
   property bool snoozed:false
   property bool intervalAlarmSounding:false
   attachedObjects: [
       SystemTimer {
           id: volFade
           interval: 400
           onTimeout: {
               if(alarmSounder.volume===0.9999999999999999){volFade.stop();}
               else{
               globalVolume +=0.100}
           }
       },
      
       SystemTimer{
           id: intervalSounder
           interval: soundingInterval
           onTimeout: {
               counted+=1
               if(intervalCount==counted){intervalSounder.stop();page.stop(); led.cancel(); lastStepTimer.start(); }
               else{
                   page.stop(); led.cancel();
                   intervalSounder.stop();
                   intervalRestart.start();
               }
           }
       },
       
       SystemTimer {
           id: intervalRestart
           interval:intervalRestartTime
            onTimeout: {
             intervalRestart.stop()
             soundInterval();
         }
       },
       
       SystemTimer {
           id: lastStepTimer
           interval: intervalRestartTime
           onTimeout: {
               
               lastStepTimer.stop()
                   sound()
                   led.flash();
                   if(flashLight===true)flashLight();
                   if(eventserver.thumbnailed) eventserver.openThumbnailedAlarmDialog()
                   else{ creator.createQMLObject("AlarmTriggerPage.qml")
                     }
           }
       },
       
       SystemTimer {
           interval:alarmSnoozeTimeout    
       id: snoozeTimer
       onTimeout: {
           paneMain.soundAlarm();
            snoozeTimer.stop();
       }
   }, 
   SystemTimer {
       id: flashTimer
       interval: flashSpeed
       onTimeout: {
           if(flashlight.enabled===true)flashlight.enabled=false 
           else{flashlight.enabled=true}
       }
   },
   SystemTimer {
       id: alarmEnabledBoxBodge
       interval: 1000
       onTimeout: {
           creator.createQMLObject("AlarmOnStartDialog.qml");
           alarmEnabledBoxBodge.stop();
           alarmEnabledBoxBodge.destroy();
       }
   }
 ]
    Container {
        attachedObjects: [
            MediaPlayer {
            volume: globalVolume
            repeatMode: RepeatMode.Track
            id: alarmSounder
            sourceUrl: alarmSound
            onBufferStatusChanged: {audioBufferProgress=bufferStatus}
            onError: { sourceUrl="asset:///sounds/1.aac"; play(); toast.showTextWithButton("Unable to play Alarm Sound", "OK", "")}
            }, 
            VibrationController {id: vibrate}
        ]
    }  
}
