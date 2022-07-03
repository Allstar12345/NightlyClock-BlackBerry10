import bb.cascades 1.2
import bb.system 1.0
import bb.cascades.pickers 1.0


Container {
    onCreationCompleted: {
        filePicker.open();
    }
    attachedObjects:    FilePicker {
        id:filePicker
        type : FileType.Music
        mode: FilePickerMode.Picker
        title : "Select Audio"
        directories : ["/accounts/"]
        filter: FileType.Music
        onFileSelected : {
            console.log("FileSelected signal received : " + selectedFiles);
            alarmSound= "file://" + selectedFiles[0];
            appsettings.saveSystemSetting("alarmSound", alarmSound);
            appsettings.saveSystemSetting("alarmSoundDescription", "Custom Sound");
            toast.showText("Alarm Sound Selected: " + alarmSound);
        }
    }
    }