import bb.cascades 1.2
import bb.system 1.0
import bb.platform 1.0
Container {
    id: root
    onCreationCompleted:{alertdialog.show();}
    attachedObjects: 
    SystemDialog {
        id: alertdialog
        title: "Clock Font Changed"
        body:"The Clock Font has Changed, Nightly Clock needs to close to apply the changes\n\nPlease Note: Although Nightly Clock Automatically scales itself down for Custom Fonts please be aware that some fonts may be too large for the screen and may not display properly"
        buttonAreaLimit: 1
        confirmButton.label: qsTr("Close")
        confirmButton.enabled: true
        cancelButton.enabled: false
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) { Application.quit();}
        }  
    }
}

