import bb.cascades 1.2
import bb.system 1.0
import bb.platform 1.0
import QtQuick 1.0
Container {
    id: root
    onCreationCompleted:{  alertdialog.show()}
    attachedObjects:[ Connections {
        target: alarmServer
        onMinimisedAlarmDialogClose:{alarmServer.stopFlash();alertdialog.cancel();}
        
    },
    
    NotificationDialog {
        id: alertdialog         
        soundUrl: _publicDir + "notificationBlankSound.mp3"
        title: "Alarm - " + alarmTime
        body:appsettings.getSystemSetting("alarmCompletedMessage", "")===""? "Alarm!": appsettings.getSystemSetting("alarmCompletedMessage", "")
        buttons: [
            SystemUiButton {
                label: "Stop"
            },
            SystemUiButton {
                label: "Snooze"
            }
        ]
        onFinished: {
            if(buttonSelection().label==="Stop"){ alarmServer.stopFlash(); alarmServer.stop();led.cancel();}
            
                else if(buttonSelection().label=== "Snooze") {alarmServer.stopFlash();alarmServer.stop(); led.cancel();alarmServer.snooze();
                }
        }
    }
]

}

