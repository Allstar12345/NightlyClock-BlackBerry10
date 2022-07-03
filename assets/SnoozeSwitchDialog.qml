import bb.system 1.0
import bb.cascades 1.0

Container {
    id: cont
    
    onCreationCompleted: {dio.show()}
    function close(){cont.destroy();}
    attachedObjects: 
    SystemDialog{
        id: dio
        title: "Snooze"
        body: "Turn off Snooze?"
        buttonAreaLimit: 2
        confirmButton.label: qsTr("Turn Off")
        confirmButton.enabled: true
        cancelButton.label: qsTr("Keep On")
        cancelButton.enabled: true
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) {
            alarmServer.stopSnooze(); close();
            }
            else if (result == SystemUiResult.CancelButtonSelection) {
                close();
            }
        }
    }
}