import bb.cascades 1.2
import bb.system 1.0
import bb.cascades.pickers 1.0


Container {
    onCreationCompleted: {
        filePicker.open();
    }
    attachedObjects: 
    FilePicker {
        id:filePicker
        type : FileType.Picture
        mode: FilePickerMode.Picker
        title : "Select Background"
        directories : ["/accounts/"]
        filter: FileType.Picture
        onFileSelected : {
            console.log("FileSelected signal received : " + selectedFiles);
            appsettings.saveSystemSetting("appWallpaper", "file:///"+selectedFiles);
            wallpaper="file:///"+selectedFiles.toString();        
        }
    }
}