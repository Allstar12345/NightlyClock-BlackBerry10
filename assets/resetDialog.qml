import bb.system 1.0
import bb.cascades 1.0

Container {
    id: cont
    onCreationCompleted: {dio.show();}
    function close(){cont.close();cont.destroy();}
    function reset() {
        toast.showText("Resetting..")
        appsettings.dropSettings();
        Application.quit();
    }
    attachedObjects: 
    SystemDialog{
        id: dio
        title: "Reset"
        body: "Are you sure you want to reset Nightly Clock?\nNightly Clock will close once completed"
        buttonAreaLimit: 2
        confirmButton.label: qsTr("Yes")
        confirmButton.enabled: true
        cancelButton.label: qsTr("Cancel")
        cancelButton.enabled: true
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) {
                reset();
            }
            else if (result == SystemUiResult.CancelButtonSelection) {
                close();
         }
    }
}
}