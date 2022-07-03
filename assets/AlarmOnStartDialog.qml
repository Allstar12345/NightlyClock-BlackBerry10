import bb.system 1.0
import bb.cascades 1.0

Container {
    id: cont
    
    onCreationCompleted: {
        dio.show()
    }
    function close(){cont.destroy();}
    attachedObjects: 
    SystemDialog{
        id: dio
        title: "Alarm"
        body: "Alarm is turned on (" + alarmTime +"), would you like to turn it off?"
        buttonAreaLimit: 2
        confirmButton.label: qsTr("Turn Off")
        confirmButton.enabled: true
        cancelButton.label: qsTr("Keep On")
        cancelButton.enabled: true
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) {
                alarmEnabled=false;appsettings.saveSystemSetting("alarmEnabled", "");
            }
            else if (result == SystemUiResult.CancelButtonSelection) {
                close();
            }
        }
    }
}