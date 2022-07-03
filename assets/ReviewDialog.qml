import bb.system 1.0
import bb.cascades 1.0

Container {
    id: cont
    onCreationCompleted: {dio.show();}
    function close(){cont.close();cont.destroy();}
    attachedObjects: [ Invocation
    {
        id: invoke
        query: InvokeQuery
        {
            id: query
            mimeType: "text/html"
            uri: "appworld://content/59945087"
            invokeActionId: "bb.action.OPEN"
        }
    },
    SystemDialog{
        id: dio
        title: "Feedback"
        body: "How is Nightly Clock?\nPlease leave us a review so we can improve Nightly Clock."
        buttonAreaLimit: 2
        confirmButton.label: qsTr("Review")
        confirmButton.enabled: true
        cancelButton.label: qsTr("Don't Show Again")
        cancelButton.enabled: true
        onFinished: {
            if(result == SystemUiResult.ConfirmButtonSelection) {
                invoke.trigger("bb.action.OPEN"); 
            }
            else if (result == SystemUiResult.CancelButtonSelection) {
                close();
            }
        }
    }]
}