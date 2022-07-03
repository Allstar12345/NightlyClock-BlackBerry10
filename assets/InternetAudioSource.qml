import bb.cascades 1.2
import bb.system 1.2
import bb.platform 1.0
import QtQuick 1.0
import DownloadManager 1.0
Container {
id: cont
property string newURL
property string type
onCreationCompleted: {
prompt.show();
}

function getFileType(fname){return fname.substr((~-fname.lastIndexOf(".") >>> 0) + 2);}

function openStream(){

newURL=prompt.inputFieldTextEntry();
console.log(newURL)
if(getFileType(newURL)==="m3u"){type="m3u";prompt.activityIndicatorVisible=true;
console.log("M3U detected" + newURL);downloadManager.download(newURL, appUI.homePath()+"/m3ufile.m3u")
}
else if((getFileType(newURL)==="pls")){type="pls";
prompt.activityIndicatorVisible=true;
console.log("PLS detected" + newURL);downloadManager.download(newURL, appUI.homePath()+"/plsfile.pls")



}
else{
    prompt.cancel(); appsettings.saveSystemSetting("alarmSound", prompt.inputFieldTextEntry()); appsettings.saveSystemSetting("alarmSoundInternet", prompt.inputFieldTextEntry()); console.log("ALARM SOUND: " + appsettings.getSystemSetting("alarmSound", "")); alarmSound=appsettings.getSystemSetting("alarmSound", "")
}

}
attachedObjects:[
    DownloadManager {
      id: downloadManager  
      signal downloadCompletedInternal

    },

Connections {
target: downloadManager
onDownloadComplete:{downloadManager.downloadCompletedInternal();}
onDownloadCompletedInternal:{
    if(type==="m3u"){
        var url= appUI.testU(appUI.homePath()+"/m3ufile.m3u"); console.log( appUI.plsFile(appUI.homePath()+"/m3ufile.m3u"));appUI.deleteFile(appUI.homePath()+"/m3ufile.m3u"); 
        prompt.cancel();appsettings.saveSystemSetting("alarmSound",url); appsettings.saveSystemSetting("alarmSoundInternet", url);alarmSound=url;
    
    }
    else if(type==="pls"){var url= appUI.plsFile(appUI.homePath()+"/plsfile.pls"); console.log( appUI.plsFile(appUI.homePath()+"/plsfile.pls"));appUI.deleteFile(appUI.homePath()+"/plsfile.pls"); 
        prompt.cancel();appsettings.saveSystemSetting("alarmSound", url); appsettings.saveSystemSetting("alarmSoundInternet", url); alarmSound=url;
    
    } 
  }
},
SystemPrompt {
   
id: prompt
autoUpdateEnabled: true
dismissAutomatically: false
inputField.inputMode: SystemUiInputMode.Url
title: "Internet Audio URL"
inputField.defaultText:appsettings.getSystemSetting("alarmSoundInternet", "")
inputField.emptyText:  "Enter Internet URL here"
confirmButton.label: "Save"
cancelButton.label: "Cancel"
onFinished: {
if(result== SystemUiResult.ConfirmButtonSelection) {
openStream();
}
else{prompt.cancel(); cont.destroy();}
}
}]
}
