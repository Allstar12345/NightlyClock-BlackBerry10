import bb.cascades 1.2
import bb.multimedia 1.2
import QtQuick 1.0



Container {
    id: watcherparent
    
    attachedObjects: [ MediaKeyWatcher {
        id: keyWatcher
        
        key: MediaKey.PlayPause
        onShortPress: {
            if(mediaKeyToStopAlarm===true){
                if(appsettings.getSystemSetting("mediaKeyOption", "")===""){ if(alarmServer.alarmSounding){
                        if(alarmServer.intervalAlarmSounding){alarmServer.intervalSounder.stop();} alarmServer.stop();led.cancel();alarmServer.triggerPageClose();alarmServer.minimisedAlarmDialogClose();
                }}
               
                else if(appsettings.getSystemSetting("mediaKeyOption", "")==="Snooze"){
                alarmServer.stopFlash();alarmServer.stop(); led.cancel();alarmServer.snooze();triggerPageClose();alarmServer.minimisedAlarmDialogClose();
                    
                }
            }
        }
    },
    Connections{
    target: alarmServer
    onKillKeysWatcher:{watcherparent.removeAll(); watcherparent.destroy();}
    }
    
]
}
