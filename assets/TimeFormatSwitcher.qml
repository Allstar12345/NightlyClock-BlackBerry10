import bb.cascades 1.2
import bb.system 1.0
import bb.platform 1.0
Container {
    id: root
    onCreationCompleted:{alertdialog.show();}
    attachedObjects: 
    SystemDialog {
        id: alertdialog
        title: "Time Format Changed"
        body:"Time Format Changed, please re-set the Alarm Time"
        buttonAreaLimit: 2
        confirmButton.label: qsTr("OK")
        confirmButton.enabled: true
        cancelButton.enabled: false
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) {
                appsettings.saveSystemSetting("alarmTime", ""); alarmTime="";alarmEnabled= false;
                appsettings.saveSystemSetting("alarmEnabled", "")
            }
        }  
    }
}

